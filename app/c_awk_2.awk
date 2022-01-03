BEGIN {
        FS=",";
		#gawk -f c_awk_2.awk goles_minuto.csv
		
print ""
print "Ejecutando gawk -f c_awk.c_awk_2 " ARGV[1]
print ""

		while(( getline line < "equipos.data") > 0 ) {
		
			quince[line] = 0
			treinta[line] = 0
			cuarenta_y_cinco[line] = 0
			
			sesenta[line] = 0
			setenta_y_cinco[line] = 0
			noventa[line] = 0

			
			quince_encajado[line] = 0
			treinta_encajado[line] = 0
			cuarenta_y_cinco_encajado[line] = 0
			
			sesenta_encajado[line] = 0
			setenta_y_cinco_encajado[line] = 0
			noventa_encajado[line] = 0
			
		}
		
}

{

	equipo_encajado = $4 
	if ($2 == $4 ){
		equipo_encajado = $5 
	}
	#if ($1 ~ /^1[0-5]{1}[,]*/) {
	if ($1 <= 15 ){
		quince[$2] = quince[$2]+1;
		quince_encajado[equipo_encajado] = quince_encajado[equipo_encajado]+1;
		#print $1 # quince[$2]
	}else if ($1 <= 30 ){
		treinta[$2] = treinta[$2]+1;
		treinta_encajado[equipo_encajado] = treinta_encajado[equipo_encajado]+1;
	}else if ($1 <= 45 ){
		cuarenta_y_cinco[$2] = cuarenta_y_cinco[$2]+1;
		cuarenta_y_cinco_encajado[equipo_encajado] = cuarenta_y_cinco_encajado[equipo_encajado]+1;
	}else if ($1 <= 60 ){
		sesenta[$2] = sesenta[$2]+1;
		sesenta_encajado[equipo_encajado] = sesenta_encajado[equipo_encajado]+1;
	}else if ($1 <= 75 ){
		setenta_y_cinco[$2] = setenta_y_cinco[$2]+1;
		setenta_y_cinco_encajado[equipo_encajado] = setenta_y_cinco_encajado[equipo_encajado]+1;
	}else{
		noventa[$2] = noventa[$2]+1;
		noventa_encajado[equipo_encajado] = noventa_encajado[equipo_encajado]+1;
	}
	
}

END {

	#for (equipo in quince)	print equipo " " quince[equipo] ;
	#print "EQUIPO,QUINCE,TREINTA,CUARENTA_Y_CINCO,SESENTA,SETENTA_Y_CINCO,NOVENTA" > "reporte_goles_minutos.data"
	for (equipo in quince){
		print equipo "," quince[equipo] "," treinta[equipo] "," cuarenta_y_cinco[equipo] "," sesenta[equipo] "," setenta_y_cinco[equipo] "," noventa[equipo] > "reporte_goles_minutos.data"
		print equipo "," quince_encajado[equipo] "," treinta_encajado[equipo] "," cuarenta_y_cinco_encajado[equipo] "," sesenta_encajado[equipo] "," setenta_y_cinco_encajado[equipo] "," noventa_encajado[equipo] > "reporte_goles_encajados_minutos.data"
	}
	print "Fichero generado reporte_goles_minutos.data"
	print "Fichero generado reporte_goles_encajados_minutos.data"

}