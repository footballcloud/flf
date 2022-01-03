BEGIN {

print ""
print "Ejecutando gawk -f c_awk.awk " ARGV[1]
print ""

        FS=",";
		#gawk -f c_awk.awk actas.csv
		while(( getline line < "equipos.data") > 0 ) {
			amarillas[line] = 0
			rojas[line] = 0
			goles[line] = 0
			victorias[line] = 0
			empates[line] = 0
			derrotas[line] = 0
			#print line
		}
		
		while(( getline line < "jugadores.data") > 0 ) {
		
			
			sub(",","#",line)
			#print line
			amarillas_jugador[line] = 0
			rojas_jugador[line] = 0
			goles_jugador[line] = 0
		}
		
}
{
	
}

$5 ~ /^Gelb$/ {
	amarillas[$6] = amarillas[$6]+1;
	id=$6 "#" $7
	#print amarillas_jugador[id]
	amarillas_jugador[id] = amarillas_jugador[id]+1;
}
$5 ~ /^Gelb-/ || $5 ~ /^Rot/ {
	rojas[$6] = rojas[$6]+1;
	id=$6 "#" $7
	#print rojas_jugador[id]
	rojas_jugador[id] = rojas_jugador[id]+1;
}
$5 ~ /Tor$/ {
	goles[$6] = goles[$6]+1;
	id=$6 "#" $7
	
	#print goles_jugador[id]
	goles_jugador[id] = goles_jugador[id]+1;
}
$5 ~ /Tor$/ || $5 ~ /^0:0/ {

	sub(" Tor","",$5)
	sub(" FIN","",$5)
	split($5,resultado,":")
	
	#en un proceso anterior ya se ordeno por minuto por lo que el primer registro contiene el resultado final
	if(partidos[$1 "-" $2 "-" $3] ~ /^$/){
	
		if(resultado[1] == resultado[2]){
			#print "Empate " $1 "v" $2 " " $5
			empates[$1] = empates[$1]+1
			empates[$2] = empates[$2]+1
		}else if(resultado[1] > resultado[2]){		
			#print "Victoria " $1 " Derrota " $2 " " $5
			victorias[$1] = victorias[$1]+1
			derrotas[$2] = derrotas[$2]+1
		}else{
			#print "Derrota " $1 " Victoria " $2 " " $5 " " resultado[1] "==" resultado[2]
			victorias[$2] = victorias[$2]+1
			derrotas[$1] = derrotas[$1]+1
		}
		partidos[$1 "-" $2 "-" $3] = a[1]+a[2]
		#print partidos[$1 "-" $2 "-" $3]
	}
}

END {

	#for (partido in partidos)	print partido " " partidos[partido] ;
	#print "EQUIPO,VICTORIAS,EMPATES,DERROTAS,GOLES,AMARILLAS,ROJAS" > "reporte_equipo.csv"
	for (equipo in amarillas){
		print equipo "," victorias[equipo] "," empates[equipo] "," derrotas[equipo] "," goles[equipo] "," amarillas[equipo] "," rojas[equipo] > "reporte_equipo.data"
	}
	print "Fichero generado reporte_equipo.data"
	
	#print "EQUIPO,JUGADOR,GOLES,AMARILLAS,ROJAS" > "reporte_jugador.csv"
	for (jugador in goles_jugador){
		split(jugador,resultado,"#")
		print resultado[1] ","  resultado[2] ","  goles_jugador[jugador] ","  amarillas_jugador[jugador] ","  rojas_jugador[jugador] > "reporte_jugador.data"
	}
	print "Fichero generado reporte_jugador.data"
}

