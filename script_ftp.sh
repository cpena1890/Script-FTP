#!/bin/sh
#prueba de conectividad al servidor ftp
#datos de conexion al servidor FTP

username=carlos
pass='1890'

echo "Se realizara una primer prueba al servidor, mediante la herramienta PING"
echo ""
printf "\e[1;32mrealizando ping...\e[0m"
#primero se prueba conectividad al servidor ftp mediante ping
ping $1 -c 4 > ping.txt
sleep 3
#si el ping es exitoso devuelve un codigo de error $? = 0
if [ $? -eq 0 ];then
  echo ""
  printf "\e[1;32mping al servidor realizado con exito\e[0m"
  echo ""
  echo "**********************************************"
  echo ""
  echo "Segunda etapa de prueba:"
  echo ""
  #Intentamos conectarnos al servidor FTP 
  salida=$(ftp -inv $1 <<EOF
  user $username $pass
  quit
EOF
)
else
  echo ""
  printf "\e[1;31mERROR de PING\e[0m"
  echo ""
  mail -s "msj servidor FTP" asdf@spgr.com <<< "servidor FPT no funciona - Error de PING"
fi
echo "-----------------------------------"
echo "salida de conexion a servidor FTP:"
echo $salida
echo "-----------------------------------"

if [ "$salida" = "Not connected." ];then
  echo "enviando email de error..." 
  mail -s "msj servidor FTP" asdf@spgr.com <<< "servidor FPT no funciona - Error de servicio FTP"
else
  echo ""
  printf "\e[1;32mservidor FTP funcionando correctamente\e[0m"
  echo ""
fi