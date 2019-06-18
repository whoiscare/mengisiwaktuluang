#!/usr/bin/env bash
#
# Reverse IP Lookup

#####################
##      COLOR      ##
#####################
B1='\e[38;5;3m'    ##
B3='\e[38;5;6m'    ##
B4='\e[38;5;4m'    ##
B5='\e[38;5;2m'    ##
B6='\e[38;5;9m'    ##
C1='\e[38;5;37m'   ##
NC='\e[0m'         ##
#####################

single(){
    echo -ne "${C1}[>]${B1} Insert domain : ${B4}"
    read domain
    echo -ne "${C1}[>]${B1} Save output [Y/n] ${B4}"
    read outopt
    reverse_it $domain
}

mass(){
    echo -ne "${C1}[>]${B1} Insert list : ${B4}"
    read listdom
    for i in $(cat $listdom); do
        reverse_it $i
    done
}

reverse_it(){
    dom=$1
    if [[ -z "$listdom" ]]; then
        getData=$(curl -s "https://api.hackertarget.com/reverseiplookup/?q=$dom")
        count=$(echo "$getData" | wc -l)
        echo -e "${C1}[-]${B1} Total domain :${B4} $count"
        echo -ne "${C1}[>]${B1} Do you want to see result? [Y/n] ${B4}"
        read seeres
        if [[ $seeres == 'y' || $seeres == 'Y' ]]; then
            while IFS=$'\n' read -r domain; do
                echo -e "${C1}[-]${B4} $domain"
            done <<< "$getData"
        fi
        if [[ $outopt == 'y' || $outopt == 'Y' ]]; then
            echo "$getData" > "result/$dom.txt"
        fi
        echo -e "${C1}[+]${B5} DONE ${NC}"
    else
        getData=$(curl -s "https://api.hackertarget.com/reverseiplookup/?q=$dom")
        count=$(echo "$getData" | wc -l)
        echo -e "${C1}[+]${B1}---------------------------->"
        echo -e "${C1}[-]${B1} Domain :${B4} $dom"
        echo -e "${C1}[-]${B1} Total domain :${B4} $count"
        echo -ne "${C1}[-]${B1} Saving result ... "
        echo "$getData" > "result/$dom.txt"
        if [[ -f "result/$dom.txt" && -n $(cat "result/$dom.txt") ]]; then
            echo -e "${B5}[DONE]${NC}"
        else
            echo -e "${B6}[FAILED]${NC}"
        fi
    fi
}

banner(){
echo -e "${B3}"
cat << "banner"
  ____             ___ ____     +-----------------------+
 |  _ \  ___  ___ |_ _|  _ \    -   Reverse IP Lookup   -
 | |_) |/ _ \/ __| | || |_) |   -  Coded by wayangcode  -
 |  _ <|  __/\__ \ | ||  __/    -       (c) 2019        -
 |_| \_\\___||___/|___|_|       +-----------------------+
banner
echo -e "${NC}"
}

if [[ ! -d "result" ]]; then
    mkdir result
fi

clear
banner
echo -e "${C1}[-]${B1} Option : ${B4}"
echo -e "    1: Single Reverse IP"
echo -e "    2: Mass Reverse IP"
echo -ne "${C1}[>]${B1} Select : ${B4}"
read opt

case $opt in
    1) single ;;
    2) mass ;;
    *) exit 0
esac

# END OF FILE
