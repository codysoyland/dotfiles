#!/bin/bash
# Run from bashrc, but work as non-invasive as possible
#  * Silently fail (2>/dev/null)
#  * Only if $TMUX is not set (equivalent to only new SSH sessions)
#  * Only automatically launch tmux if one session with no clients
#  * Any key will cancel the message


# DYNAMIC MOTD which centers in screen. Must be run in a terminal, so normal
# MOTD generation not possible.

# http://parkersamp.com/2010/10/howto-creating-a-dynamic-motd-in-linux/

WIDTH=$(tput cols)

function center {
	while read; do
		printf "%*s\n" $(((${#REPLY}+$(tput cols))/2)) "$REPLY"
	done
}

if ! which figlet &>/dev/null; then
	echo "Install figlet first" >&2
	exit 127
fi

if [ $WIDTH -lt 148 ]; then
	echo Terminal not wide enough >&2
	exit 2
fi


# clear screen (AKA reset terminal)
echo -ne  "\033c"

# hide cursor
echo -ne "\e[?25l"

# clearing screen sometimes leaves bits of last command, blank it
echo "                                                                                "

# white
echo -ne "\033[37m"

PADDING=$(($(($(tput lines)-24))/2))

for i in $(seq 1 $PADDING); do
	echo
done

# ascii art hostname
#hostname -s | tr a-z A-Z | figlet -ctf slant
#hostname -s | tr a-z A-Z | figlet -ct
#hostname -s | tr a-z A-Z | figlet -ctf roman
#hostname -s | tr a-z A-Z | figlet -ctf univers.flf
#hostname -s | tr a-z A-Z | figlet -Wctf colossal.flf
#echo BLACKMESA | tr a-z A-Z | figlet -Wctf univers.flf
#echo BLACKMESA | tr a-z A-Z | figlet -Wctf colossal.flf
#hostname -s | tr a-z A-Z | figlet -ctf slant
#hostname -s | tr a-z A-Z | toilet -F border -f future
#hostname -s | tr a-z A-Z | toilet -F border:crop -f future
#hostname -s | tr a-z A-Z | figlet -ctf roman

# figlet -t is broken on mac os x. Try -w instead.
hostname -s | sed 's/.*/\u&/' | figlet -cf roman -w $WIDTH


# domain name, double spaced. capital, centered
hostname -d | sed 's/./& /g' | tr a-z A-Z | center

# Always reset terminal, regardless of termination reason
function CLEANUP_EXIT {
	# show cursor
	echo -ne "\e[?25h"
	# reset terminal
	echo -ne  "\033c"
}
trap CLEANUP_EXIT EXIT


echo
if [ -r /etc/quotes ]; then
	echo; echo
	cat /etc/quotes | sort -R | tail -n 1 \
		| sed 's/.*/"&"/g' \
		| fold -w 76 -s \
		| center

	# extra pause if there is a quote
	read -n1 -t 1.2 && exit
fi

# wait for up to 1.2 seconds for any character
# Abortable sleep
read -n1 -t 1.2


