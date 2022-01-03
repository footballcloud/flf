BEGIN {
        FS=",";
		#gawk -f c_awk_3.awk tarjetas_minuto.csv

print ""
print "Ejecutando gawk -f c_awk_3.awk "  ARGV[1]
print ""

		while(( getline line < "equipos.data") > 0 ) {
		
			quince[line] = 0
			treinta[line] = 0
			cuarenta_y_cinco[line] = 0
			
			sesenta[line] = 0
			setenta_y_cinco[line] = 0
			noventa[line] = 0
		}
		
}

{
	#if ($1 ~ /^1[0-5]{1}[,]*/) {
	if ($1 <= 15 ){
		quince[$2] = quince[$2]+1;
		#print $1 # quince[$2]
	}else if ($1 <= 30 ){
		treinta[$2] = treinta[$2]+1;
	}else if ($1 <= 45 ){
		cuarenta_y_cinco[$2] = cuarenta_y_cinco[$2]+1;
	}else if ($1 <= 60 ){
		sesenta[$2] = sesenta[$2]+1;
	}else if ($1 <= 75 ){
		setenta_y_cinco[$2] = setenta_y_cinco[$2]+1;
	}else{
		noventa[$2] = noventa[$2]+1;
	}
	
}

END {

	#for (equipo in quince)	print equipo " " quince[equipo] ;
	#print "EQUIPO,QUINCE,TREINTA,CUARENTA_Y_CINCO,SESENTA,SETENTA_Y_CINCO,NOVENTA" > "reporte_tarjetas_minutos.csv"
	for (equipo in quince){
		print equipo "," quince[equipo] "," treinta[equipo] "," cuarenta_y_cinco[equipo] "," sesenta[equipo] "," setenta_y_cinco[equipo] "," noventa[equipo] > "reporte_tarjetas_minutos.data"
	}
	print "Fichero generado reporte_tarjetas_minutos.data"
}