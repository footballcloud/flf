#!/usr/bin/env bash
# 

echo ""
echo "Ejecutando ./c_bash.sh $1"
echo ""

OLDIFS=$IFS
 
IFS=','
[ ! -f $1 ] && { echo "$nombre_dataset file not found"; exit 99; }

#Creamos fichero de todos los jugadores mencionados en el acta
cat $1 | grep -E -wv UOC | grep -E -wv unbekannt | grep -E -wv Eigentor | awk -F',' 'NR>1 {print $6","$7}' | sort -k 1,2 -t"," | uniq > jugadores.data
#Creamos fichero de todos los equipos mencionados en el acta
cat jugadores.data |  awk -F',' '{print $1}' | sort | uniq > equipos.data

#Creamos fichero de datos con los nombres de los goleadores y otro con los que marcaron el primer gol. actas.csv
cat $1 | grep -E "Tor.*" | sort -k 6,7 -t"," | sed -r 's/ Tor//g' | awk -F',' '{print $4","$5","$6","$7","$1","$2}' > goles_marcados.data
cat goles_marcados.data | awk -F, '$2 ~ /^1:0/ || $2 ~ /^0:1/' | sort -k 3 -t"," > goleadores_decisivos.data


##Necesitamos una cronologia de los goles por equipo para los estadisticos HTML procesados en c_awk_2.awk
echo "MINUTOS,EQUIPO,JUGADOR,LOCAL,VISITANTE" > goles_minuto.csv 
cat goles_marcados.data | sort -k 1 -t"," --sort=general-numeric |  awk -F',' '{print $1","$3","$4","$5","$6}' >> goles_minuto.csv

##Necesitamos una cronologia de las tarjetas por equipo para los estadisticos HTML procesados en c_awk_3
echo "MINUTOS,EQUIPO,TARJETA,FECHA,LOCAL,VISITANTE" > tarjetas_minuto.csv
cat $1 | grep -E "Gelb.*|Rot.*" | sort -k 4 -t"," --sort=general-numeric | sed -r 's/ für /\,/g' | awk -F',' '{print $4","$6","$5","$3","$1","$2}' >> tarjetas_minuto.csv

unset goleadores
unset goleadores_decisivos
while read EQUIPO JUGADOR
do
	
	goles=$(cat goles_marcados.data | grep -E "$JUGADOR" | wc -l)
	numero_goles="$goles"
	ROW="$EQUIPO,$JUGADOR,$numero_goles"
	#echo "$ROW"
	goleadores[${#goleadores[@]}]=$ROW

	#goles=$(cat goleadores_decisivos.data| grep  -E "$JUGADOR" | wc -l)
	#numero_goles="$goles"
	#ROW="$EQUIPO,$JUGADOR,$numero_goles"
	
	#if [[ $JUGADOR =~ Mickaël[[:space:]]Jager ]];then
	#	echo "$ROW"
	#fi

	#goleadores_decisivos[${#goleadores_decisivos[@]}]=$ROW
	
done < jugadores.data

echo "GOLES,EQUIPO,JUGADOR" > ranking_goleadores.csv
printf '%s\n' "${goleadores[@]}" | sort -k 1 -t"," -n -r | grep -E -wv ^0 >> ranking_goleadores.csv
echo "Fichero generado ranking_goleadores.csv"

#echo "GOLES,EQUIPO,JUGADOR" > ranking_goleadores_decisivos.csv
#printf '%s\n' "${goleadores_decisivos[@]}" | sort -k 1 -t"," -n -r  | grep -E -wv ^0 >> ranking_goleadores_decisivos.csv
#echo "Fichero generado ranking_goleadores_decisivos.csv"

IFS=$OLDIFS
