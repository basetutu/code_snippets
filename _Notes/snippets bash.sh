# -----------------------------------------------------------------------------------

# How to write colored echo

function coloredEcho(){
    local exp=$1;
    local color=$2;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo -e $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo -e $exp;
    tput sgr0;
}

# example:
coloredEcho 'text' green

# --------------------------------------------------------------------------------------

# How to write to text-file (this will not append, but delete the previous content of file)

cat <<EOF > /tmp/delete.test
#### Write your text or code script here ####

EOF
sudo mv /tmp/delete.test /etc/apt/delete.test

# --------------------------------------------------------------------------------------

# what does -e do ?

echo test 1
echo -e '\n'
echo test 2

# --------------------------------------------------------------------------------------

# How to get user input and use the input variable

coloredEcho 'Please enter your Bosch userID and press [enter]' cyan
read userID
echo $userID
read -s proxy_password # probably obscuring the password
echo $proxy_password

# --------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------

