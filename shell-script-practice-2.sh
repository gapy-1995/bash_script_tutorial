# Display UID and user name and user execute this script
# Display if user is root or not

# Display the UID
UID_TO_TEST='111111000'
if [[ "${UID}" -ne "${UID_TO_TEST}" ]]; then
	echo "Your UID does not match ${UID_TO_TEST}"
	exit 1
fi

# Display the username
USER_NAME=$(id -un)

if [[ "${?}" -ne 0 ]]; then
	echo 'The id command not execute success'
	exit 1
fi
