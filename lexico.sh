#!/bin/bash 
#Desarrolle un programa en c++ que reciba de entrada una cadena, el programa debe decir a la salida, si la cadena es un:
#
#1.-Numero entero
#2.-Numero flotante
#3.-Numero hexadecimal
#4.-Mensaje de error para cualquier otra cadena
#set -x;
#cachamos nombre de archivo a analizar
cp $1 file.lv
error=1;




##funcion que recibe lineas y genera tokens
generatokens()
{
    #case word in
#    	pattern )
#    		;;
	#cat tabla | grep digitos | awk '{print $2}' FS=":" | awk '{print $3}' FS=","
    #esac
    #echo "linea numero : $2 contenido: $1 es: $tipo"

    #
    #if echo "$1" | egrep -q '^\-?[0-9]+$'; then 
	

##busca audios 
    if echo "$1" | egrep -q 'audio'; then 
		echo "linea numero : $2 contenido: $1 . <- Es un audio para ser reproducido en el sistema" 
    	error=0
    fi
#busca comentarios   
    if 	echo "$1" | egrep -q ';'; then 
    ##if 	echo "$1" | egrep -q '[:.:]'; then 
    	echo "linea numero : $2 contenido: $1 . <- Es comentario dentro del sistema, se pasara a asterisk como tal"
    	error=0
    fi

##busca enteros para las opciones
 	if echo "$1" | grep -q int; then 
 		echo "linea numero : $2 contenido: $1 . <- Es Entero" 
    	error=0
    fi



if  echo "$1" | egrep -q 'dial'; then
    ##if        echo "$1" | egrep -q '[:.:]'; then 
        echo "linea numero : $2 contenido: $1 . <- funcion Dial "
        error=0
    fi


if  echo "$1" | egrep -q 'Instrucciones'; then
    ##if        echo "$1" | egrep -q '[:.:]'; then 
	echo ""
        echo "linea numero : $2 contenido: $1 . <- Inicia lista de instrucciones del programa "
        echo ""
	echo "Ejectutar comando ->>>>>>>>>> ./compilador $1.compilador "
	echo ""
	touch /root/proyecto_asterisk_compilador/lineafinallexico
	#Freno de mano


	########################## Llamamos a compilador una vez que encuentra instrucciones

	/bin/kill -9 `/bin/ps ax | /bin/grep lexico | /bin/cut -c-5`


	error=0
    fi


	if [ $error -eq 1 ]  ; then
	echo "linea numero : $2 contenido: $1 NO SE PUEDE DEFINIR!!ERR0R "
	fi

error=1;
}
	

##Leemos el archivo  linea por linea
echo -e "\n                                                        Inicia analisis Lexico\n"


###
totallineas=$(/usr/bin/wc instrucciones.lv  | /usr/bin/awk '{print $1}')
echo El total de lineas de este codigo es de : $totallineas
echo 
##inicia contador de lineas
lineas=1
while read line; 
	do #echo -e "$line"
	if [ -f `/root/proyecto_asterisk_compilador/lineafinallexico`]; 
	then
		echo "si existe comprobacon. Continua"
	else
		echo "no existe"
	fi;
	generatokens "$line" $lineas $totallineas
	lineas=$((lineas + 1))  
	done < file.lv



##while read -n1 letra; do
#done < < (echo -n "texto")

