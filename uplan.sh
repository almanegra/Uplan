#!/bin/bash/env bash

#================================================================
#Uplan, faz Digitalização DTP
#================================================================


#================================================================
#Autors: almanegra
#================================================================
# Preciso só entender como fazer a integração com o fantasma.sh


DTPSEC = " 90 " # número de segundos para detectar o DTP. Sugira 90, pois a cada 30-60 segundos, dependendo do modo DTP
Versão = " 1.3 "

Claro
echo -e " \ e [00; 32m ###################################### ############### \ e [00m"
echo "*** DTPScan - o VLN DTP SCanner $ Version *** "
echo " "
echo " *** Detecta DTP  salto de Vlan (passivo) *** "
echo -e " \ e [00; 32m ############################################## ########## \ e [00m"

# Verifique o tshark
which tshark > / dev / null
if [ $? -eq 1]
	then
		echo -e "\e[01;31m[!]\e[00m Não foi possível encontrar o programa tshark necessário, instale e tene novamente."
		echo ""
		exit 1
fi


echo ""
echo -e "\e[01;32m[-]\e[00m As seguintes interfaces estão disponíveis"
echo ""
ifconfig | grep -o "eth.*" |cut -d " " -f1
echo ""
echo -e "\e[1;31m--------------------------------------------------------\e[00m"
echo -e "\e[01;31[?]\e[00m Entre na interface para digitalizar com a fonte"
echo -e  " \ e [1; 31m ------------------------------- ----------------- \ e [00m"
read INT
ifconfig | grep -i -w "$INT" >/dev/null

if [ $? = 1 ]
	then
		echo""
		echo -e "\e[01;31m[!]\e[00m Desculpe a interface que você inseriu não existe! - verifiquee tente novamente."
		echo " "
		exit 1
fi


echo ""
echo -e "\e[01,32m[-]\e]00m Agora procurando pacotes DTP na interface $ INT  for "$DTPSEC" seconds."
echo ""

tshark -a duration:$DTPSEC -i $INT -Y "dtp" -x -V >dtp.tmp 2>&1
COUNTDTP=$(cat dtp.tmp |grep "dtp" |wc -1)

if [$COUNTDTP = 0 ]

	then
			echo ""
			echo -e "\[01;31m[!]\e[00m 
