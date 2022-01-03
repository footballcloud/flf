#!/usr/bin/env bash
# 

OLDIFS=$IFS
 
IFS=','

echo ""
echo "Ejecutando ./d.sh"
echo ""


	cat <<EOF> index.html
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Programación en Script - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="view/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="view/css/sb-admin-2.min.css" rel="stylesheet">

	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap4.min.css">

</head>
    <!-- Page Wrapper -->
    <div id="wrapper">
EOF

cat <<EOF>> index.html

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
		    <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-futbol"></i>
                </div>
                <div class="sidebar-brand-text mx-3">Pedro García</div>
			</a>

			<!-- Divider -->
            <hr class="sidebar-divider my-0">
			
            <!-- Nav Item - Charts -->
            <li class="nav-item">
				<div id="Graficos">
                <a id="All" class="nav-link">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>General</span></a>
				</div>
            </li>



            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Equipos</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Estadísticos</h6>
EOF
			
	
while read EQUIPO VICTORIAS EMPATES DERROTAS GOLES AMARILLAS ROJAS
do

id=$(echo "$EQUIPO" | sed 's/ /-/g')

cat reporte_jugador.data | grep -E "$EQUIPO" |  sort -k 3 -t"," -r --sort=general-numeric > "$id.data"
	
cat <<EOF>> index.html
	        <a id="$id" class="collapse-item">$EQUIPO</a>
EOF
done <  equipos.data


cat <<EOF>> index.html
                    </div>
                </div>
            </li>
		</ul>
        <!-- End of Sidebar -->
EOF

cat <<EOF>> index.html

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
		    <!-- Main Content -->
            <div id="content">
			    <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

				</nav>
EOF

cat <<EOF>> index.html		
                <!-- /.container-fluid -->
                <!-- Begin Page Content -->
                <div id="minutos" class="container-fluid">
                    <!-- Page Heading -->

                    <h1 id="equipo-dashboard" class="h3 mb-2 text-gray-800">Selecione un equipo en el menú.</h1>
                    <!-- Content Row -->
                    <!-- Goles Chart -->
                    <div class="card shadow mb-4">
						<!-- Card Header -->
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Goles Marcados</h6>
                        </div>
						<!-- Card Body -->
						<div class="card-body">
							<div id="canvas" class="chart-area">
								<canvas id="myAreaChart"></canvas>
							</div>
						</div>
                    </div>

                    <!-- Goles Encajados Chart -->
                    <div class="card shadow mb-4">
						<!-- Card Header -->
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Goles Encajados</h6>
                        </div>
						<!-- Card Body -->
						<div class="card-body">
							<div id="canvasEncajados" class="chart-area">
								<canvas id="encajadosChart"></canvas>
							</div>
						</div>
                    </div>
                    <!-- Tarjetas Chart -->
                    <div class="card shadow mb-4">
						<!-- Card Header -->
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Tarjetas Recividas</h6>
                        </div>
						<!-- Card Body -->
						<div class="card-body">
							<div id="canvasTarjetas" class="chart-area">
								<canvas id="tarjetasChart"></canvas>
							</div>
						</div>
                    </div>
					
                </div>
                <!-- /.container-fluid -->
EOF

cat <<EOF>> index.html
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
					<h1 id="equipo-tabla" class="h3 mb-2 text-gray-800">Selecione un equipo en el menú.</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary"></h6>
                        </div>
EOF

while read EQUIPO VICTORIAS EMPATES DERROTAS GOLES AMARILLAS ROJAS
do
id=$(echo "$EQUIPO" | sed 's/ /-/g')
cat <<EOF>> index.html
                        <div id="jugadores-$id" class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>JUGADOR</th>
                                            <th>GOLES</th>
                                            <th>AMARILLAS</th>
                                            <th>ROJAS</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>JUGADOR</th>
                                            <th>GOLES</th>
                                            <th>AMARILLAS</th>
                                            <th>ROJAS</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
EOF

while read TEAM PLAYER GOAL YELLOW RED
do
cat <<EOF>> index.html
                                        <tr>
                                            <td>$PLAYER</td>
                                            <td>$GOAL</td>
                                            <td>$YELLOW</td>
                                            <td>$RED</td>
                                        </tr>
EOF
done <  "$id.data"

cat <<EOF>> index.html
                                    </tbody>
                                </table>
                            </div>
                        </div>
EOF
done <  reporte_equipo.data

cat <<EOF>> index.html
						<div id="jugadores-All" class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable-equipo" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>EQUIPO</th>
                                            <th>VICTORIAS</th>
                                            <th>EMPATES</th>
                                            <th>DERROTAS</th>
                                            <th>GOLES</th>
                                            <th>AMARILLAS</th>
                                            <th>ROJAS</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>EQUIPO</th>
                                            <th>VICTORIAS</th>
                                            <th>EMPATES</th>
                                            <th>DERROTAS</th>
                                            <th>GOLES</th>
                                            <th>AMARILLAS</th>
                                            <th>ROJAS</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
EOF

while read EQUIPO VICTORIAS EMPATES DERROTAS GOLES AMARILLAS ROJAS
do
cat <<EOF>> index.html
                                        <tr>
                                            <td>$EQUIPO</td>
                                            <td>$VICTORIAS</td>
                                            <td>$EMPATES</td>
                                            <td>$DERROTAS</td>
                                            <td>$GOLES</td>
                                            <td>$AMARILLAS</td>
                                            <td>$ROJAS</td>
                                        </tr>
EOF
done <  reporte_equipo.data

cat <<EOF>> index.html
                                    </tbody>
                                </table>
                            </div>
                        </div>
EOF

cat <<EOF>> index.html
                    </div>
                </div>
            </div>
            <!-- End of Main Content --

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->
EOF


while read TEAM QUINCE TREINTA CUARENTA_Y_CINCO SESENTA SETENTA_Y_CINCO NOVENTA
do
datos=$(echo "$TEAM" | sed 's/ /-/g')
cat <<EOF>> index.html
	<input hidden id="goles-$datos" type="text" value="$QUINCE, $TREINTA, $CUARENTA_Y_CINCO, $SESENTA, $SETENTA_Y_CINCO, $NOVENTA"/> 
EOF
done <  reporte_goles_minutos.data

while read TEAM QUINCE TREINTA CUARENTA_Y_CINCO SESENTA SETENTA_Y_CINCO NOVENTA
do
datos=$(echo "$TEAM" | sed 's/ /-/g')
cat <<EOF>> index.html
	<input hidden id="encajados-$datos" type="text" value="$QUINCE, $TREINTA, $CUARENTA_Y_CINCO, $SESENTA, $SETENTA_Y_CINCO, $NOVENTA"/> 
EOF
done <  reporte_goles_encajados_minutos.data

while read TEAM QUINCE TREINTA CUARENTA_Y_CINCO SESENTA SETENTA_Y_CINCO NOVENTA
do
datos=$(echo "$TEAM" | sed 's/ /-/g')
cat <<EOF>> index.html
	<input hidden id="tarjetas-$datos" type="text" value="$QUINCE, $TREINTA, $CUARENTA_Y_CINCO, $SESENTA, $SETENTA_Y_CINCO, $NOVENTA"/> 
EOF
done <  reporte_tarjetas_minutos.data


cat <<EOF>> index.html	
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
EOF

cat <<EOF>> index.html

    <!-- Bootstrap core JavaScript
    <script src="view/js/jquery.min.js"></script>
	 <script src="view/js/bootstrap.bundle.min.js"></script>
	-->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-
    <script src="view/js/jquery.easing.min.js"></script>
	-->
	
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	
	<!-- dataTables plugin JavaScript-->
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap4.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="view/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins 
    <script src="view/js/Chart.min.js"></script>
	Chart.js v2.9.4
	https://www.chartjs.org/docs/2.9.4/getting-started/
	-->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>

    <!-- Page level custom scripts -->
    <script src="view/js/app.js"></script>
</body>

</html>
EOF

echo "Fichero generado index.html"
IFS=$OLDIFS