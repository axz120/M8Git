<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">

<title>Form</title>
</head>
<%!
	public int genValorBase() {

		int[] dados = { 0, 0, 0, 0 };
		for (int i = 0; i < 4; i++) {
			dados[i] = (int) (Math.random() * 6)+1; //d6
		}
		Arrays.sort(dados); //ordena de pequeño a grande
		int suma = 0;
		for (int o = 1; o < dados.length; o++) {
			suma += dados[o];
		}
		return suma;
	}
	String nomPJ="";
	public int[] raza(int nRaza) {
		
		switch (nRaza) {
		case 0: //elfs
			int[] elfs = {0, 0, +2, -2, +2, 0, 0 };
			nomPJ = "Elf";
			return elfs;
		case 1: //nans
			int[] nans = {1, 0, 0, +2, 0, +2, -2 };
			nomPJ = "Nan";
			return nans;
		case 2: //gnoms
			int[] gnoms = {2, -2, 0, +2, 0, 0, +2 };
			nomPJ = "Gnom";
			return gnoms;
		case 3: //mitjans
			int[] mitjans = {3, -2, +2, 0, 0, 0, 0 };
			nomPJ = "Mitja";
			return mitjans;
		case 4: //semiorcs
			int[] semiorcs = {4, +2, 0, 0, -2, 0, -2 };
			nomPJ = "Semiorc";
			return semiorcs;
		default: //humans
			int[] humans = {5, 0, 0, 0, 0, 0, 0 };
			nomPJ = "Humà";
			return humans;
		}
	}
	%>
	<%
	int[] saveVB = { 0, 0, 0, 0, 0, 0 };
	int[] saveMod = { 0, 0, 0, 0, 0, 0, 0 };	//tambien guardo la raza en la primera posicion		
	int[] saveVF = { 0, 0, 0, 0, 0, 0 };
	
	for (int i = 0; i < saveVB.length; i++) {
		saveVB[i] = genValorBase();
	}
		
	int random = (int)(Math.random()*6); //d5
	
	int[] razaRandom=raza(random);
	for(int o=0;o<saveMod.length;o++){
		saveMod[o] = razaRandom[o];
	}
	
	for(int j=0;j<saveVF.length;j++){
		saveVF[j] = saveVB[j]+saveMod[j+1];
	}
	
	int PV = ((int)(Math.random()*8)+1)*saveVF[2]; //d8
	int PM = ((int)(Math.random()*4)+1)*((saveVF[3]+saveVF[4])/2); //d4	
%>
<body>

<a href="index.jsp"><button class="button">Inici</button></a>
<form action="insert_bd.jsp" method="POST">
	
	<label>Nombre de la carta:</label>
	<input type="text" name="nombre" required><br>
		<%
		out.print("<label>Valors generats: </label>");
		for(int i=0;i<saveVF.length;i++){
			out.print("<label>"+saveVB[i]+" </label>"); /*Printar los datos finales*/
		}
		%>
	<h3><%=nomPJ%></h3>
	<input type="hidden" name="race" value=<%=nomPJ%>>
	<input type="hidden" name="imagen" value=<%=saveMod[0]%>>
	
	<table class="tgForm">
		<tbody>
			<tr>
				<td class="th-0pky" rowspan="9"><img src="img/<%= saveMod[0]%>.png"></td>
				<td class="th-0pky">Características</td>
				<td class="th-0pky">Valor Base</td>
				<td class="th-0pky">Mod.</td>
				<td class="th-0pky">Valor Final</td>
			</tr>

			<tr>
				<td class="tg-0pky">FUERZA:</td>
				<td class="tg-0pky"><select id="fuerza" style=" width: 100%; ">
	<option value="default" selected disabled></option>
		<%
		for(int i=0;i<saveVF.length;i++){
			out.print("<option id=\"tdVB"+i+"\" value="+saveVB[i]+">"+saveVB[i]+"</option>");
		}
		%>
	</select></td>
				<td class="tg-0pky" id="tdModF"><%=saveMod[1]%></td>
				
				<td class="tg-0pky" id="tdVFF"></td>
				
			</tr>
			<tr>
				<td class="tg-0pky">DESTREZA:</td>
				<td class="tg-0pky"><select id="destreza" style=" width: 100%; ">
	<option value="default" selected disabled></option>
		<%
		for(int i=0;i<saveVF.length;i++){
			out.print("<option id=\"tdVB"+i+"\" value="+saveVB[i]+">"+saveVB[i]+"</option>");
		}
		%>
	</select></td>
				<td class="tg-0pky" id="tdModD"><%=saveMod[2]%></td>
				<td class="tg-0pky"  id="tdVFD"></td>
			</tr>
			<tr>
				<td class="tg-0pky">CONSTITUCIÓN:</td>
				<td class="tg-0pky"><select id="constitucion" style=" width: 100%; ">
	<option value="default" selected disabled></option>
		<%
		for(int i=0;i<saveVF.length;i++){
			out.print("<option value="+saveVB[i]+">"+saveVB[i]+"</option>");
		}
		%>
	</select></td>
				<td class="tg-0pky" id="tdModCo"><%=saveMod[3]%></td>
				<td class="tg-0pky" id="tdVFCo"></td>
			</tr>
			<tr>
				<td class="tg-0pky">INTELIGENCIA:</td>
				<td class="tg-0pky"><select id="inteligencia" style=" width: 100%; ">
	<option value="default" selected disabled></option>
		<%
		for(int i=0;i<saveVF.length;i++){
			out.print("<option value="+saveVB[i]+">"+saveVB[i]+"</option>");
		}
		%>
	</select></td>
				<td class="tg-0pky" id="tdModI"><%=saveMod[4]%></td>
				<td class="tg-0pky" id="tdVFI"></td>
			</tr>
			<tr>
				<td class="tg-0pky">SABIDUŔIA:</td>
				<td class="tg-0pky"><select id="sabiduria" style=" width: 100%; ">
	<option value="default" selected disabled></option>
		<%
		for(int i=0;i<saveVF.length;i++){
			out.print("<option value="+saveVB[i]+">"+saveVB[i]+"</option>");
		}
		%>
	</select></td>
				<td class="tg-0pky" id="tdModS"><%=saveMod[5]%></td>
				<td class="tg-0pky" id="tdVFS"></td>
			</tr>
			<tr>
				<td class="tg-0pky">CARISMA:</td>
				<td class="tg-0pky"><select id="carisma" style=" width: 100%; ">
	<option value="default" selected disabled></option>
		<%
		for(int i=0;i<saveVF.length;i++){
			out.print("<option value="+saveVB[i]+">"+saveVB[i]+"</option>");
		}
		%>
	</select></td>
				<td class="tg-0pky" id="tdModCa"><%=saveMod[6]%></td>
				<td class="tg-0pky" id="tdVFCa"></td>
			</tr>
			<tr>
				<td class="tg-0pky" id="PVF"></td> <!-- Vida maxima 8*20=160 -->
				<td class="tg-0pky" colspan="3">
				<table id="barraPV"></table>
				</td>
			</tr>
			<tr>
				<td class="tg-0pky" id="PMF"></td>
				<td class="tg-0pky" colspan="3">
					<table id="barraPM"></table>
				</td>
			</tr>

		</tbody>
	</table>
	
	<input type="submit" class="button" value="Guardar Carta" style="
    float: left;">
</form>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<script type="text/javascript">
/* $('select').on('change', function() {
	  $('option').prop('disabled', false); 
	  $('select').each(function() { 
	    var val = this.value;
	    $('select').not(this).find('option').filter(function() { 
	      return this.value == val;
	    }).prop('disabled', true); 
	}).change();  */
	// Si hay dos valores iguales, deshabilita los dos
</script>
<button class="button2" onClick="recargar()">Calcular estadisticas</button>
<input type="button" class="button" value="Roll Carta" onclick="location.reload()"/>
<script type="text/javascript">
	function recargar() {
	    let valorBaseF =document.getElementById("fuerza").value;
	    let intVBF=parseInt(valorBaseF);
	    let modF = document.getElementById("tdModF").textContent;
	    let intModF =parseInt(modF);
	    let sumaF = intVBF + intModF;
	    document.getElementById("tdVFF").innerHTML = "<input type=\"hidden\" name=\"fuerza\" value="+sumaF+">"+sumaF;
	    
	    let valorBaseD =document.getElementById("destreza").value;
	    let intVBD=parseInt(valorBaseD);
	    let modD = document.getElementById("tdModD").textContent;
	    let intModD =parseInt(modD);
	    let sumaD = intVBD + intModD;
	    document.getElementById("tdVFD").innerHTML = "<input type=\"hidden\" name=\"destreza\" value="+sumaD+">"+sumaD;
	    
	    let valorBaseCo =document.getElementById("constitucion").value;
	    let intVBCo=parseInt(valorBaseCo);
	    let modCo = document.getElementById("tdModCo").textContent;
	    let intModCo =parseInt(modCo);
	    let sumaCo = intVBCo + intModCo;
	    document.getElementById("tdVFCo").innerHTML = "<input type=\"hidden\" name=\"constitucion\" value="+sumaCo+">"+sumaCo;
	    
	    let valorBaseI =document.getElementById("inteligencia").value;
	    let intVBI=parseInt(valorBaseI);
	    let modI = document.getElementById("tdModI").textContent;
	    let intModI =parseInt(modI);
	    let sumaI = intVBI + intModI;
	    document.getElementById("tdVFI").innerHTML = "<input type=\"hidden\" name=\"inteligencia\" value="+sumaI+">"+sumaI;
	    
	    let valorBaseS =document.getElementById("sabiduria").value;
	    let intVBS=parseInt(valorBaseS);
	    let modS = document.getElementById("tdModS").textContent;
	    let intModS =parseInt(modS);
	    let sumaS = intVBS + intModS;
	    document.getElementById("tdVFS").innerHTML = "<input type=\"hidden\" name=\"sabiduria\" value="+sumaS+">"+sumaS;

	    let valorBaseCa =document.getElementById("carisma").value;
	    let intVBCa=parseInt(valorBaseCa);
	    let modCa = document.getElementById("tdModCa").textContent;
	    let intModCa =parseInt(modCa);
	    let sumaCa = intVBCa + intModCa;
	    document.getElementById("tdVFCa").innerHTML = "<input type=\"hidden\" name=\"carisma\" value="+sumaCa+">"+sumaCa;
	    
	    let PV =(Math.round((Math.random()*8)+1))*sumaCo;
	    let intPV =parseInt(PV);
	    document.getElementById("PVF").innerHTML = "<input type=\"hidden\" name=\"pv\" value="+intPV+"> P.V("+intPV+")";
	    document.getElementById("barraPV").setAttribute("width", intPV);
	    let PM =(Math.round((Math.random()*4)+1))*((sumaI+sumaS)/2);
	    let intPM =parseInt(PM);
	    document.getElementById("PMF").innerHTML = "<input type=\"hidden\" name=\"pm\" value="+intPM+">P.M("+intPM+")";
	    document.getElementById("barraPM").setAttribute("width", intPM);
	};
</script>

</body>
</html>