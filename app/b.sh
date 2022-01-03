#!/usr/bin/env bash
# 
echo ""
echo "Ejecutando ./b.sh"
nombre_dataset=./uoc_actas.csv
OLDIFS=$IFS
 
IFS=','
[ ! -f $nombre_dataset ] && { echo "$nombre_dataset file not found"; exit 99; }

unset uoc_actas_4
unset sin_goles
#unset tarjetas

sort -k 1 -t, -n -r uoc_actas.csv | grep -E -wv URL > actas_1.data
cat actas_1.data | sed -r 's/-m1-/\,/g' | sed -r 's/https:\/\/www.fupa.net\/match\///g'  > actas_2.data
cat actas_2.data | awk -F, '$4 ~ /^[0-9]/' > actas_3.data

anterior="-"

while read LOCAL VISITANTE FECHA MINUTO ACCION PERSONA
do
		minutos_accion="$(($MINUTO))";
		incluir=false

		actual=$LOCAL-$VISITANTE-$FECHA
		
		#Noramlizar los minutos a numeros enteros.
		if [[ $MINUTO =~ ^45+ ]];then
			minutos_accion="45"
		fi
		
		#Añadimos los partidos que quedaron 0-0
		if [ ! "$anterior" == "$actual" ]; then
			if [ ! "$gol" == "true" ]; then
				ROW="$anterior_local,$anterior_visitante,$anterior_fecha,90,0:0 FIN,UOC,UOC"
				if [ ! "$anterior" == "-" ]; then
					uoc_actas_4[${#uoc_actas_4[@]}]=$ROW
				fi
				
			fi
			
			#Se utiliza un fichero de propiedades para mapaer los identificadores con la descriptio del equipo.
			equipo_local=$(grep -E "$LOCAL" equipos.properties | cut -d'=' -f2 | sed 's/\r$//')
			equipo_visitante=$(grep -E "$VISITANTE" equipos.properties | cut -d'=' -f2 | sed 's/\r$//')

			anterior=$actual
			anterior_local=$equipo_local
			anterior_visitante=$equipo_visitante
			anterior_fecha=$FECHA
			gol=false
		fi
		
		ROW="$equipo_local,$equipo_visitante,$FECHA,$minutos_accion,$ACCION,$PERSONA"
		
		##Nos quedamos con los goles marcados y recividos en propia puerta.
		#Tor = Gol
		#Eigentor = Gol en propia puerta.
		if [[ $ACCION =~ [[:space:]]Tor[[:space:]]für ]] ||
		   [[ $ACCION =~ [[:space:]]Eigentor[[:space:]]für ]]  ;then
           #goles[${#goles[@]}]=$ROW
		   incluir=true
		   gol=true
		   
        fi
		
		##Nos quedamos con las tarjetas
		#Gelb = Tarjeta amarilla.
		#Gelb-Rot = Doble Tarjeta amarilla.
		#Rot = Tarjeta Roja.
		if [[ $ACCION =~ ^Gelb[[:space:]]für ]] || 
		   [[ $ACCION =~ ^Gelb- ]] ||  
		   [[ $ACCION =~ ^Rot[[:space:]]für ]] ;then
           #tarjetas[${#tarjetas[@]}]=$ROW
		   incluir=true
        fi
		
		if $incluir
		then
			uoc_actas_4[${#uoc_actas_4[@]}]=$ROW
		fi

done < actas_3.data

echo "LOCAL,VISITANTE,FECHA,MINUTO,EVENTO,EQUIPO,JUGADOR" > actas.csv 
printf '%s\n' "${uoc_actas_4[@]}" | sed -r 's/ für /\,/g'| sed 's/\r$//' >> actas.csv
echo "Fichero generado actas.csv"
IFS=$OLDIFS
