<h1 align="center">Atomicpi Bash Welcome Tweak</h1>
<div align="center">

<a href="https://github.com/Griffen8280/atomicpibashwelcome/stargazers"><img src="https://img.shields.io/github/stars/Griffen8280/atomicpibashwelcome?style=plastic" alt="Stars Badge"/></a>
<a href="https://github.com/Griffen8280/atomicpibashwelcome/network/members"><img src="https://img.shields.io/github/forks/Griffen8280/atomicpibashwelcome?style=plastic" alt="Forks Badge"/></a>
<a href="https://github.com/Griffen8280/atomicpibashwelcome/pulls"><img src="https://img.shields.io/github/issues-pr/Griffen8280/atomicpibashwelcome?style=plastic" alt="Pull Requests Badge"/></a>
<a href="https://github.com/Griffen8280/atomicpibashwelcome/issues"><img src="https://img.shields.io/github/issues/Griffen8280/atomicpibashwelcome?style=plastic" alt="Issues Badge"/></a>
<a href="https://github.com/Griffen8280/atomicpibashwelcome/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/Griffen8280/atomicpibashwelcome?color=2b9348&style=plastic"></a>
<a href="https://github.com/Griffen8280/atomicpibashwelcome/blob/master/LICENSE"><img src="https://img.shields.io/github/license/Griffen8280/atomicpibashwelcome?color=2b9348&style=plastic" alt="License Badge"></a></div>

# A Bash Welcome Tweak similar to Retro-Pie for PiHole

much of the code for this came from the orignal over at: https://github.com/retropie/RetroPie-Setup/blob/master/scriptmodules/supplementary/bashwelcometweak.sh  
I only updated it with a new variable and changed many of the system call backs to work independantly instead of being a part of the
overall menu system used by the RetroPie team.

# Installation 
```
git clone --depth=1 https://github.com/Griffen8280/atomicpibashwelcome.git
cd atomicpibashwelcome
chmod +x bashwelcometweak.sh
./bashwelcometweak.sh
```
This will install the tweak for the user running it and contains much of the same useful information as the RetroPie tweak
with an updated PiHole logo in ascii art.
