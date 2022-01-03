// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTable-equipo').dataTable({
		searching: false, 
		paging: false, 
		info: false
	});
	
  $("[id*=jugadores-]").hide();
  $("#minutos").hide();
  $("[id*=jugadores-All]").show();
  $("[id*=equipo-]").text("General");
		
  $('#dataTable').dataTable({
		searching: false, 
		paging: false, 
		info: false,
		ordering: false
	});
	
	

	//$( "#dataTable tbody" ).on( "click", "tr", function() { console.log( $( this ).text() ); });
	
	$( "#Graficos" ).on( "click", "a", function() {
		$("[id*=jugadores-]").hide();
		$("[id*=jugadores-All]").show();
		$("#minutos").hide();
		$("[id*=equipo-]").text("General");
	});
	
	$( "#collapseTwo div" ).on( "click", "a", function() { 

		$("#minutos").show();
		var id = $(this).attr('id');
		var valor = $(this).text();

		  $("[id*=jugadores-]").hide();
		  $("#jugadores-"+ id).show();
		  $("[id*=equipo-]").text(valor);
		  //var grapharea = document.querySelector("#chart-area").innerHTML = '<canvas id="myAreaChart"></canvas>';
		  //grapharea.destroy();
		  
		  //$('#myAreaChart').remove(); // this is my <canvas> element
		  //$('#chart-area').append('<canvas id="myAreaChart"><canvas>');
  
  
		  //console.log( $( this ).text() ); 
				
		$("#canvas").empty()
		$("#canvas").append("<canvas id='myAreaChart'></canvas>");
		
		// Area Chart Example
		var ctx = document.getElementById("myAreaChart");

		var splitResearchArea = []; 
		var textInput = document.getElementById("goles-"+ id).value; 
		var splitTextInput = textInput.split(",");
		
		var config = {
		  type: 'bar',
		  data: {
			labels: ["0-15", "15-30", "30-45+", "45-60", "60-75", "75-90+"],
			datasets: [{
			  label: "Goles",
			  lineTension: 0.3,
			  backgroundColor: "rgba(51, 255, 149, 0.50)",
			  borderColor: "rgba(51, 255, 149, 1)",
			  pointRadius: 3,
			  pointBackgroundColor: "rgba(51, 255, 149, 1)",
			  pointBorderColor: "rgba(51, 255, 149, 1)",
			  pointHoverRadius: 3,
			  pointHoverBackgroundColor: "rgba(51, 255, 149, 1)",
			  pointHoverBorderColor: "rgba(51, 255, 149, 1)",
			  pointHitRadius: 10,
			  pointBorderWidth: 2,
			  data: splitTextInput,
			}],
		  },
		  tooltips: {
			  backgroundColor: "rgb(255,255,255)",
			  bodyFontColor: "#858796",
			  titleMarginBottom: 10,
			  titleFontColor: '#6e707e',
			  titleFontSize: 14,
			  borderColor: '#dddfeb',
			  borderWidth: 1,
			  xPadding: 15,
			  yPadding: 15,
			  displayColors: false,
			  intersect: false,
			  mode: 'index',
			  caretPadding: 10,
			  callbacks: {
				label: function(tooltipItem, chart) {
				  var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
				  return datasetLabel + ': ' + number_format(tooltipItem.yLabel);
				}
			  }
			},
		  options: {
			maintainAspectRatio: false,
			layout: {
			  padding: {
				left: 10,
				right: 25,
				top: 25,
				bottom: 0
			  }
			},
			legend: {
			  display: false,
			  animation: false,
			  showTooltips: false
			},
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			}
		  }
		}


		var chart = new Chart(ctx, config);


		$("#canvasEncajados").empty()
		$("#canvasEncajados").append("<canvas id='encajadosChart'></canvas>");
		var ctxTarjetas = document.getElementById("encajadosChart");

		var splitResearchArea = []; 
		var textInput = document.getElementById("encajados-"+ id).value; 
		var splitEncajados = textInput.split(",");
		
		var configEncajados = {
		  type: 'bar',
		  data: {
			labels: ["0-15", "15-30", "30-45+", "45-60", "60-75", "75-90+"],
			datasets: [{
			  label: "Goles Encajados",
			  lineTension: 0.3,
			  backgroundColor: "rgba(255, 51, 51, 0.50)",
			  borderColor: "rgba(228, 255, 51, 1)",
			  pointRadius: 3,
			  pointBackgroundColor: "rgba(255, 51, 51, 1)",
			  pointBorderColor: "rgba(255, 51, 51, 1)",
			  pointHoverRadius: 3,
			  pointHoverBackgroundColor: "rgba(255, 51, 51, 1)",
			  pointHoverBorderColor: "rgba(255, 51, 51, 1)",
			  pointHitRadius: 10,
			  pointBorderWidth: 2,
			  data: splitEncajados,
			}],
		  },
		  tooltips: {
			  backgroundColor: "rgb(255,255,255)",
			  bodyFontColor: "#858796",
			  titleMarginBottom: 10,
			  titleFontColor: '#6e707e',
			  titleFontSize: 14,
			  borderColor: '#dddfeb',
			  borderWidth: 1,
			  xPadding: 15,
			  yPadding: 15,
			  displayColors: false,
			  intersect: false,
			  mode: 'index',
			  caretPadding: 10,
			  callbacks: {
				label: function(tooltipItem, chart) {
				  var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
				  return datasetLabel + ': ' + number_format(tooltipItem.yLabel);
				}
			  }
			},
		  options: {
			maintainAspectRatio: false,
			layout: {
			  padding: {
				left: 10,
				right: 25,
				top: 25,
				bottom: 0
			  }
			},
			legend: {
			  display: false,
			  animation: false,
			  showTooltips: false
			},
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			}
		  }
		}
		var chartTarjetas = new Chart(ctxTarjetas, configEncajados);
		
		
		$("#canvasTarjetas").empty()
		$("#canvasTarjetas").append("<canvas id='tarjetasChart'></canvas>");
		var ctxTarjetas = document.getElementById("tarjetasChart");

		var splitResearchArea = []; 
		var textInput = document.getElementById("tarjetas-"+ id).value; 
		var splitTarjetas = textInput.split(",");
		
		var configTarjetas = {
		  type: 'bar',
		  data: {
			labels: ["0-15", "15-30", "30-45+", "45-60", "60-75", "75-90+"],
			datasets: [{
			  label: "Tarjetas",
			  lineTension: 0.3,
			  backgroundColor: "rgba(228, 255, 51, 0.50)",
			  borderColor: "rgba(228, 255, 51, 1)",
			  pointRadius: 3,
			  pointBackgroundColor: "rgba(228, 255, 51, 1)",
			  pointBorderColor: "rgba(228, 255, 51, 1)",
			  pointHoverRadius: 3,
			  pointHoverBackgroundColor: "rgba(228, 255, 51, 1)",
			  pointHoverBorderColor: "rgba(228, 255, 51, 1)",
			  pointHitRadius: 10,
			  pointBorderWidth: 2,
			  data: splitTarjetas,
			}],
		  },
		  tooltips: {
			  backgroundColor: "rgb(255,255,255)",
			  bodyFontColor: "#858796",
			  titleMarginBottom: 10,
			  titleFontColor: '#6e707e',
			  titleFontSize: 14,
			  borderColor: '#dddfeb',
			  borderWidth: 1,
			  xPadding: 15,
			  yPadding: 15,
			  displayColors: false,
			  intersect: false,
			  mode: 'index',
			  caretPadding: 10,
			  callbacks: {
				label: function(tooltipItem, chart) {
				  var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
				  return datasetLabel + ': ' + number_format(tooltipItem.yLabel);
				}
			  }
			},
		  options: {
			maintainAspectRatio: false,
			layout: {
			  padding: {
				left: 10,
				right: 25,
				top: 25,
				bottom: 0
			  }
			},
			legend: {
			  display: false,
			  animation: false,
			  showTooltips: false
			},
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			}
		  }
		}
		var chartTarjetas = new Chart(ctxTarjetas, configTarjetas);

		});


});



