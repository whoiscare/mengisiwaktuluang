#!/bin/bash
# Coded by Arief R

h='\e[38;5;85m' # HIJAU
nc='\033[0m' # DEFAULT
delim="|" # SEPARATOR BARU (Sesuaikan)

move(){
	str=$1
	str1=$(printf "$str" | sed "s/${delim}.*//g")
	str2=$(printf "$str" | sed "s/.*${delim}//g")
	echo "${email}${sptbaru}${pass}" >> $result
}

clear
echo "	    [ MOVER 1.0 ]"
echo "	github.com/whoiscare"
echo ""
read -p "File list   : " list
read -p "Separator   : " delim
read -p "File result : " result
echo "Total list : `cat $list | wc -l`";
echo "";
echo -n "[INFO] Moving...";
for string in $(cat $list)
do move $string
done
echo -e "\n[INFO] ${h}Finished ${nc}";

# EOF
