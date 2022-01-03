#!/bin/bash

usage()
{
  echo "Ayuda: a.sh comandos "
  echo 
  echo "   Los comandos validos son"
  echo "      [-o]  : Ejecutar en modo offline "
  echo "      [-v]  : Mostrar logs "
  echo "      [-h]  : Mostrar ayuda" 
  #echo "      [-f <nombre>] : Especificar el nombre del dataset ej. dataset.csv "
}

tarea() { 
	echo "tarea"
	exit 1; 
}

debug=false
online=true
url_dataset="https://drive.google.com/uc?export=download&id=1pwasbyXr-d8-FRK0Azj9GD2PT7AsbPEl"


nombre_dataset="uoc_actas.csv"

##Leer y procesar argumentos
while getopts :f:ohv option; do
  case $option in
		o) online=false ;;
        v) debug=true ;;
        h) usage 
		   exit 1 ;;
#        f) nombre_dataset=$OPTARG ;;
		\?) usage 
		   exit 1 ;;
		:) usage 
		   exit 1 ;;
    esac
done

shift $(( OPTIND - 1 ));

if $online
then
   echo "URL: $url_dataset"
   curl -sS -L $url_dataset > ./$nombre_dataset
else
	echo "URL: ./$nombre_dataset"
fi

[ ! -f $INPUT ] && { echo "$INPUT file not found"; usage; exit 99; }

if [ ! -f "./$nombre_dataset" ]; then
	echo "Fichero ./$nombre_dataset no encontrado"
	usage
	exit 0
fi

 

numero_columnas=$(head -1 ./$nombre_dataset | tr ',' '\n' | wc -l)
numero_filas=$(wc -l ./$nombre_dataset | cut -d ' ' -f 1)

echo "Número de columnas: $numero_columnas" 
echo "Número de registros: $numero_filas " 
	
if $debug
then
	extension_dataset=$(file -b ./$nombre_dataset)
	echo "Formato: '$extension_dataset'" 
	cat << EOF
Tipo de datos de las columnas: 
	URL: Cadena de 100 caractéres. URL donde se descargo la informacion del partido. ej.'https://www.fupa.net/match/fc-blo-waeiss-medernach-m1-fc-mamer-32-m1-210912'.
	ACCION1: Cadena de 100 caractéres. Minuto del succeso en el partido. ej. '84'   
	ACCION2: Cadena de 100 caractéres. Accion del partido, contine: tarjetas amarillas, rojas, goles y otros. ej. 'Gelb für Mamer'  
	ACCION3: Cadena de 100 caractéres. Nombre de la persona protagonista de la accion., . ej. 'Nuno Fernandes'  
EOF

fi