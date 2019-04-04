# simple loops in bash
while true; do . proxyon; ./make.sh; . proxyoff; ./make.sh; done 
------------------------------------------------

# Concatenate to a file
cat <<'EOF' >> /tmp/proxyon

EOF
------------------------------------------------

show_error() {
	echo "error: $*" >&2
}

ask_yesno() {
	ANSWER=
	while [ "$ANSWER" != "yes" -a "$ANSWER" != "no" ]; do
		echo -n "${1} [yes/no] "
		read ANSWER
	done
	if [ "$ANSWER" != "yes" ]; then
		exit ${2:-255}
	fi
}

test_program() {
	if ! which $1 2> /dev/null > /dev/null; then
		show_error $2
		exit 2
	fi
	if [ ! -x `which $1` ]; then
		show_error $2
		exit 2
	fi
}

# Examples
ask_yesno "Do you want to continue with the installation?"
show_error $2
show_error "No 'sudo' found on your machine. Since the installation requires"
test_program apt-key "the required tool 'apt-key' cannot be found on your system"
test_program dpkg "this script can not run on non debian derived distributions."
--------------------------------------------------

