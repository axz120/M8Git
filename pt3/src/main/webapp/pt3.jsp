<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Juegos de cartas</title>
<link rel="stylesheet" href="css/style.css">
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
<div>
	<h1>Juegos de cartas</h1>	
	<h3><%=nomPJ%></h3>
	<table class="tg">
		<tbody>
			<tr>
				<td class="th-0pky" rowspan="9"><img src="img/<%= saveMod[0]%>.png"></td>
				<td class="th-0pky">Carac.</td>
				<td class="th-0pky">Valor Base</td>
				<td class="th-0pky">Mod.</td>
				<td class="th-0pky">Valor Final</td>
			</tr>

			<tr>
				<td class="tg-0pky">FUEZA:</td>
				<td class="tg-0pky"><%=saveVB[0]%></td>
				<td class="tg-0pky"><%=saveMod[1]%></td>
				<td class="tg-0pky"><%=saveVF[0]%></td>
			</tr>
			<tr>
				<td class="tg-0pky">DESTREZA:</td>
				<td class="tg-0pky"><%=saveVB[1]%></td>
				<td class="tg-0pky"><%=saveMod[2]%></td>
				<td class="tg-0pky"><%=saveVF[1]%></td>
			</tr>
			<tr>
				<td class="tg-0pky">CONSTITUCIÓN:</td>
				<td class="tg-0pky"><%=saveVB[2]%></td>
				<td class="tg-0pky"><%=saveMod[3]%></td>
				<td class="tg-0pky"><%=saveVF[2]%></td>
			</tr>
			<tr>
				<td class="tg-0pky">INTELIGENCIA:</td>
				<td class="tg-0pky"><%=saveVB[3]%></td>
				<td class="tg-0pky"><%=saveMod[4]%></td>
				<td class="tg-0pky"><%=saveVF[3]%></td>
			</tr>
			<tr>
				<td class="tg-0pky">SABIDUŔIA:</td>
				<td class="tg-0pky"><%=saveVB[4]%></td>
				<td class="tg-0pky"><%=saveMod[5]%></td>
				<td class="tg-0pky"><%=saveVF[4]%></td>
			</tr>
			<tr>
				<td class="tg-0pky">CARISMA:</td>
				<td class="tg-0pky"><%=saveVB[5]%></td>
				<td class="tg-0pky"><%=saveMod[6]%></td>
				<td class="tg-0pky"><%=saveVF[5]%></td>
			</tr>
			<tr>
				<td class="tg-0pky">P.V (<%=PV%>)</td> <!-- Vida maxima 8*20=160 -->
				<td class="tg-0pky" colspan="3">
				<table class="barraPV" width="<%=PV%>px"></table>
				</td>
			</tr>
			<tr>
				<td class="tg-0pky">P.M (<%=PM%>)</td>
				<td class="tg-0pky" colspan="3">
					<table class="barraPM" width="<%=PM%>px"></table>
				</td>
			</tr>
		</tbody>
	</table>
	<a href="form.jsp"><button class="button">Guardar</button></a>
</div>
</body>
</html>