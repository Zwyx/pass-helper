#!/bin/echo Please-source
# shellcheck shell=bash

alias pgp='pass git push'
alias pgl='pass git pull'

passKeywords=("cp" "edit" "find" "generate" "git" "grep" "help" "init" "init" "insert" "ls" "mv" "rm" "show" "version")

p() {
	# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
	if printf '%s\0' "${passKeywords[@]}" | grep -Fxz "$1"; then
		echo " is a reserved keyword of pass; use 'pass' instead of 'p' to use this feature."
		return 1
	fi

	local secret
	secret=$(pass "$1" | head -n 2)

	if [ -z "$secret" ]; then
		echo "\e[0;31m✘ failed to retrieve password\e[0m"
		return 1
	fi

	# Put the password in the X selection (also called primary, see `man xclip`)
	echo "$secret" | head -n 1 | tr -d "\n" | xclip
	echo "\e[0;32m✔ password retrieved\e[0m"

	local username
	username=$(echo "$secret" | tail -n 1)

	if [[ "$username" =~ ^username:\w* ]]; then
		# Put the username in the clipboard
		echo "${username#"username: "}" | tr -d "\n" | xclip -selection clipboard
		echo "\e[0;32m✔ username retrieved\e[0m"
	else
		echo "\e[0;93m- no username\e[0m"
	fi

	unset secret
	unset username

	for i in {5..1}; do
		printf "\r• clearing password in %s" "$i"
		sleep 1
	done

	echo -n "" | xclip

	printf "\r\e[0;32m✔ password cleared\e[0m       \n"
}

compdef _pass p
