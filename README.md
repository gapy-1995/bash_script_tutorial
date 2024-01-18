# Learning shell script
## Built in
### To get docs of each command use `man <command>` to get information
1. Echo
    Options:
        -n  do not append a new line

        -e  enable interpretation of the fllowing backslash escapse
        
        -E  explicitly suppress interpretation of backslash escapes

### Assign a value to a variable

WORD='abcdef'
`echo "$WORD"`  || `echo "${WORD}"`  -> print the value

### Append text to variable
echo

### show UUID and ID
`man id` to get Information usage

Command: `id -u -n` = to get user name 

```sh
 USER_NAME=$(id -un)
 echo "Your username ${USER_NAME}
 # your username locnguyent3108
```

### if else condition
```sh
if [[ "${UID}" -eq 0]]
then
  echo "You are root"
else
  echo "you are not root"
fi  
```

### Exit code 
> Exit command help exit the shell with a status of N (number we define). If N is omitted, exit status = last command execute

`${?}` < this variable content the most recently status code.
for example
```sh
    id -un # command success
    echo "${?}" # echo 0
    id -abc # command unsuccess
    echo "${?}" # echo 1

### date time command
date [OPTION] [+FORMAT]
e.g: `date --utc MMDDhhmm`
e.g 2: `date +%s` miliseconds

purposing make better password, we add hash function 
| e.g: PASSWORD=$(date --utc +%s | sha256sum | head -c32) # 32 character

### fold command
warp each input line to fit in specified width
for example:
```sh
STRING_SAMPLE="abck1"
echo ${STRING_SAMPLE} | fold -w2 |

output:
ab
ck
1
```
### Shift
shift positional parameters

Rename the positional parameter $N+1
### Write STDOUT file 
```sh
FILE="/tmp/data"
head -n /etc/passwd > ${FILE} # read the first line of passwd file and store it into "/tmp/data
```

### Overwrite the file
By default this would be overwrite the file 
```sh
FILE="/tmp/data"
head -n /etc/passwd1 > ${FILE}
cat ${FILE} # display 1st line  of passwd1 
```
If we want to append we use `>>` 
```sh
  echo "new" >> file1
  cat file1
  echo "another-line" >> file1 # in case file1 doesn't exits, create 1 
  cat file1
  #OUTPUT:
  new
  another-line
```


### Read STDIN file
```sh
read LINE < ${FILE} # assign value to ${LINE}   
```
read the first line of file and store to another file
```sh
# create a file head.err
cat head.err 
# send firstr line of these files  to abc.output
# in case error code is appeared, send to abc.err 
head -n1 /etc/passwd /etc/hosts /fileNotExist > abc.output 2>abc.err
```
> `2> head.output`: The standard error (stderr) of the head command is redirected to a file named "abc.err". This means that any error messages or diagnostic information produced by the head command will be written to the "abc.err" file.

! IF WE WANT TO STORE IN SINGLE FILE

`head -n1 /etc/passwd /etc/hosts/ /fileNotExists > abc.output 2>&1`
same with 
`head -n1 /etc/passwd /etc/hosts/ /fileNotExists &> abc.output`

---

## Case statement

```sh
case "${1}" in
  start)
    echo 'Starting.'
    ;;
  stop)
    echo 'Stopping.'
    ;;
  status)
    echo 'Statuting'
    ;;
  *)
    echo 'Matching with everything'
    ;;
esac
```

run `man case` for more details

some common pattern character:

+ *: matches any string include NULL STRING
+ ?: matches any single char
+ [...]: Matches any one of the enclosed characters. pair characters seperated by hyphen (-)

## Function 

should user variable scope 
local , readonly

```sh
log() {
	local VERBOSE="${1}" # get first argument
	shift # shift the next argument to the left
	local MESSAGE="${@}" 
	if [[ "${VERBOSE}"='true' ]]; then
		echo "${MESSAGE}"
	fi

}

VERBOSITY='true'
log "${VERBOSITY}" 'Hello!'
log "aaa" 'This is fun!' # this would be not display
```
> function to backup file 
```sh
backup_file() {
  if[[ -f "${FILE}"]]; then
    local BACKUP_FILE="/var/temp/$(basename ${FILE})"
  else
    return 1
  fi
}

handle_error_status(){
  if[[${?} -eq 0]]; then
    echo 'File backed up success'
  else
    echo 'Back up process failed'
    exit 1
  fi
}
```

> to quick call the single funcion -> `type -a function_name`
