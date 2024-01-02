echo "hello"
WORD='this is first script from luke nguyen'
echo "$WORD"

# Display username
USER_NAME=$(id -un)

echo "your username ${USER_NAME}"

# if condition
if [[ "${UID}" -eq 0 ]]; then
	echo 'you are root'
else
	echo 'You are not'
fi
