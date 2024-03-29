#!/usr/bin/env bash

# This file is derived from part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to their COPYRIGHT.md file.
#
# See the LICENSE.md file at the top-level directory of their distribution at
# https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
# Modified from the RetroPie project for PiHole
# Also includes the logo for PiHole for a little personalization
#

#The menu system of this script relied on dialog, so we need to install it
command -v "dialog"
if [[ $? -ne 0 ]]; then
    sudo apt install dialog -y
fi

function install_bashwelcometweak() {
    remove_bashwelcometweak
    cat >> "$HOME/.bashrc" <<\_EOF_

# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
        IFS=')' read -ra core_temp_arr <<< "$(sensors -f  | grep '^Core\s[[:digit:]]\+:')" #echo "${core_temp_arr[0]}"
        total_cpu_temp=0
        index=0
        for i in "${core_temp_arr[@]}"; do :
                temp=$(echo "$i" | sed -n 's/F.*//; s/.*[+-]//; p; q' | sed 's/.\{1\}$//')
                let index++
                total_cpu_temp=$(echo "$total_cpu_temp + $temp" | bc)
        done
        cpuTempF=$(echo "scale=2; $total_cpu_temp / $index" | bc)
        cpuTempC=$(echo $(bc <<< "($cpuTempF-32)/1.8"))

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "   _____    __                    __         "
        "  /  _  \ _/  |_  ____    _____  |__|  ____  "
        " /  /_\  \\    __\/  _ \  /     \ |  |_/ ___\ "
        "/    |    \|  | (  <_> )|  Y Y  \|  |\  \___ "
        "\____|__  /|__|  \____/ |__|_|  /|__| \___  >"
        "        \/                    \/          \/ "
        "            __________ .__                   "
        "            \______   \|__|                  "
        "             |     ___/|  |                  "
        "             |    |    |  |                  "
        "             |____|    |__|                  "
        )
    local out
    local i
    local degree="°"
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}${degree}C/${cpuTempF}${degree}F"
                ;;
            10)
                out+="${fgwht}The AtomicPi Project, https://digital-loggers.com/api.html"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}

pihole_welcome
# PIHOLE PROFILE END
_EOF_


}

function remove_bashwelcometweak() {
    sed -i '/PIHOLE PROFILE START/,/PIHOLE PROFILE END/d' "$HOME/.bashrc"
}

function gui_bashwelcometweak() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Bash Welcome Tweak Configuration" 22 86 16)
    local options=(
        1 "Install Bash Welcome Tweak"
        2 "Remove Bash Welcome Tweak"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                install_bashwelcometweak
                dialog --title Complete --msgbox "Installed Bash Welcome Tweak." 22 30
                ;;
            2)
                remove_bashwelcometweak
                dialog --title Complete --msgbox "Removed Bash Welcome Tweak." 22 30
                ;;
        esac
    fi
}

gui_bashwelcometweak
