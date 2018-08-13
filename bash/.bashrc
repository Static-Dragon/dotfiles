#=============================================
# .bashrc
# Maintained by Justin "static-dragon" Doyle
# Last edited: August 12, 2018
#=============================================

shconfig=/etc/shellrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source configuration files

source $shconfig/common.d
source $shconfig/alias.d
source $shconfig/function.d


# MOTD

echo -e  "${RED}==================================================${NC}"
echo -e "Welcome, ${CYAN}$USER${NC}!"
echo  -e "${GREEN}You were last logged in $(last | awk '/pts\// && !users[$1] { users[$1]=1; print $4,$5,$6,$7}') \n\n${NC}"


\df -THx vfat -x tmpfs -x ext2 -x devtmpfs
echo -e "\n\n"


freemem=$(awk '/MemFree/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)
totalmem=$(awk '/MemTotal/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)
freeswp=$(awk '/SwapFree/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)
totalswp=$(awk '/SwapTotal/ { printf "%.3f \n", $2/1024/1024 }' /proc/meminfo)

echo -e " Memory: free \t\t total "
echo -e "  Mem: $freemem GiB \t $totalmem GiB"

echo -e " Swap: free \t\t total"
echo -e " Swap: $freeswp GiB \t $totalswp GiB"

echo -e  "${RED}==================================================${NC}"

