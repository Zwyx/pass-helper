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
		echo "✘ Failed to retrieve password"
		return 1
	fi

	# Put the password in the X selection (also called primary, see `man xclip`)
	echo "$secret" | head -n 1 | tr -d "\n" | xclip
	printf "✔ Retrieved password"

	local username
	username=$(echo "$secret" | tail -n 1)

	if [[ "$username" =~ ^username:\w* ]]; then
		# Put the username in the clipboard
		echo "${username#"username: "}" | tr -d "\n" | xclip -selection clipboard
		echo " and username"
	else
		echo " only"
	fi

	unset secret
	unset username

	for i in {5..1}; do
		printf "\r• Clearing password in %s" "$i"
		sleep 1
	done

	echo -n "" | xclip

	printf "\r✔ Password cleared       \n"
}

compdef _pass p
