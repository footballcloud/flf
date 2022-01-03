#!/usr/bin/env bash
# 

start_time=$(date +%s)

source ./a.sh -v

source ./b.sh
source ./c_bash.sh actas.csv

gawk -f c_awk.awk actas.csv
gawk -f c_awk_2.awk goles_minuto.csv
gawk -f c_awk_3.awk tarjetas_minuto.csv

source ./d.sh

end_time=$(date +%s)

elapsed=$(( end_time - start_time ))
echo ""
echo "$elapsed Segundos."