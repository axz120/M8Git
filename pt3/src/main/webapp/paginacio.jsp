<%@ page import="java.util.Arrays,java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Mi mazo</title>
 <link rel="stylesheet" href="css/style.css" type="text/css" />
</head>
<h1 class="titol">Mi mazo</h1>
<a href="index.jsp"><button class="button">Inici</button></a>
<a href="form.jsp"><button class="button">Crear carta</button></a>

<br><br>
<%//  variables per fer la connexio:
	String user="usr_generic";
	String password="Thico@2020";
	String host="localhost";
	String db = "M8cards";
	String url = "jdbc:mysql://"+host+"/"+db;
	Connection conn = null;
	Statement statement = null;
	Statement num_registres=null;
	ResultSet rs = null;
	ResultSet num_reg=null;
	int inicio;
	
	//Limito la busqueda
	int TAMANO_PAGINA = 4;

	//examino la página a mostrar y el inicio del registro a mostrar
	
	String pag = request.getParameter("pagina");
	//int pagina =0;
	int pagina=Integer.parseInt(pag);
	if (pagina==0) {
	   	inicio = 0;
	    pagina=1;
	}
	else {
	    inicio = (pagina - 1) * TAMANO_PAGINA;
	}

	/**
	//miro a ver el número total de campos que hay en la tabla con esa búsqueda
**/
Class.forName("com.mysql.jdbc.Driver").newInstance ();
conn = DriverManager.getConnection(url, user, password);
num_registres = conn.createStatement();
//inmediatamente hacemos una consulta sencilla
//creamos la consulta
num_reg = num_registres.executeQuery("SELECT * FROM tbl_cartas");
int num_total_registros=0;
while(num_reg.next()) {
	num_total_registros++;
}

//calculo el total de páginas
int total_paginas = (int)Math.ceil(((double)num_total_registros/ TAMANO_PAGINA));

//pongo el número de registros total, el tamaño de página y la página que se muestra

out.print("Cartas totales:"+num_total_registros+"<br>");
out.print("Es mostren pàgines de "+TAMANO_PAGINA+" registres cadascuna<br>");
out.print("Mostrant la pàgina "+pagina+" de "+total_paginas+"<br>");




//out.print("<a href=VisualitzarCartes.jsp?pagina=2>"+2+"</a> ");
if (total_paginas > 1){
    for (int i=1;i<=total_paginas;i++){
       if (pagina == i)
          //si muestro el índice de la página actual, no coloco enlace
          out.print(pagina);
       else
          //si el índice no corresponde con la página mostrada actualmente, coloco el enlace para ir a esa página
          out.print(" <a href=paginacio.jsp?pagina="+i+">"+i+"</a> ");
    }
}
out.print("<br>");
try{

	Class.forName("com.mysql.jdbc.Driver").newInstance ();
	conn = DriverManager.getConnection(url, user, password);
	statement = conn.createStatement();
	//inmediatamente hacemos una consulta sencilla
	//creamos la consulta
	String sentence="SELECT * from tbl_cartas limit "+inicio+","+TAMANO_PAGINA;
	rs = statement.executeQuery(sentence);
	//leemos la consulta
	int count=0;
	while(rs.next()) {
	//mostramos los resultados obtenidos
	//out.println(rs.getString("ID_carta"));
	//String nom=request.getParameter("nom");
	if(count%2==0){
	%>
	<div style="float:left; margin-right: 50px; margin-top:20px;">
	<table class="tgPa">
	<thead>
		<tr>
			<td class="tg-0pky" colspan="3"><img
				src="img/<%out.print(rs.getString("imagen"));%>.png" height="220"
				width="150" align="center"></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="tg-0lax" colspan="3" style="text-align: center; font-weight:bold;">
				<%
				out.print(rs.getString("nombre").toUpperCase());
				%>
			</td>
		</tr>
		<tr>
			<td class="tg-0pky">RAZA</td>
			<td class="tg-0pky" colspan="2">
				<%
				out.print(rs.getString("raza"));
				%>
			</td>
		</tr>
		<tr>
			<td class="tg-0pky">PV(<%
			out.print(rs.getString("pv"));
			%>)
			</td>
			<td class="tg-0pky" colspan="2"><table id="barraPV"
					width="<%out.print(rs.getString("pv"));%>px"></table></td>
		</tr>
		<tr>
			<td class="tg-0pky">PM(<%
			out.print(rs.getString("pm"));
			%>)
			</td>
			<td class="tg-0pky" colspan="2" style="width: 160px;"><table
					id="barraPM" width="<%out.print(rs.getString("pm"));%>px"></table></td>
		</tr>
		<tr>
			<td class="tg-0pky">FUE:<%
			out.print(rs.getString("fuerza"));
			%></td>
			<td class="tg-0pky" style="width: 90px;"></td>
			<td class="tg-0pky">INT:<%
			out.print(rs.getString("inteligencia"));
			%></td>
		</tr>
		<tr>
			<td class="tg-0pky">DES:<%
			out.print(rs.getString("destreza"));
			%></td>
			<td class="tg-0pky"></td>
			<td class="tg-0pky">SAB:<%
			out.print(rs.getString("sabiduria"));
			%></td>
		</tr>
		<tr>
			<td class="tg-0pky">CON:<%
			out.print(rs.getString("constitucion"));
			%></td>
			<td class="tg-0pky"></td>
			<td class="tg-0pky">CAR:<%
			out.print(rs.getString("carisma"));
			%></td>
		</tr>
	</tbody>
</table>
</div>

<% 
	}else{%>
	<div class="divCartas" style="margin-top:20px;">
	<table class="tgPa">
	<thead>
		<tr>
			<td class="tg-0pky" colspan="3"><img
				src="img/<%out.print(rs.getString("imagen"));%>.png" height="220"
				width="150"></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="tg-0lax" colspan="3" style="text-align: center; font-weight:bold;">
				<%
				out.print(rs.getString("nombre").toUpperCase());
				%>
			</td>
		</tr>
		<tr>
			<td class="tg-0pky">RAZA</td>
			<td class="tg-0pky" colspan="2">
				<%
				out.print(rs.getString("raza"));
				%>
			</td>
		</tr>
		<tr>
			<td class="tg-0pky">PV(<%
			out.print(rs.getString("pv"));
			%>)
			</td>
			<td class="tg-0pky" colspan="2"><table id="barraPV"
					width="<%out.print(rs.getString("pv"));%>px"></table></td>
		</tr>
		<tr>
			<td class="tg-0pky">PM(<%
			out.print(rs.getString("pm"));
			%>)
			</td>
			<td class="tg-0pky" colspan="2" style="width: 160px;"><table
					id="barraPM" width="<%out.print(rs.getString("pm"));%>px"></table></td>
		</tr>
		<tr>
			<td class="tg-0pky">FUE:<%
			out.print(rs.getString("fuerza"));
			%></td>
			<td class="tg-0pky" style="width: 90px;"></td>
			<td class="tg-0pky">INT:<%
			out.print(rs.getString("inteligencia"));
			%></td>
		</tr>
		<tr>
			<td class="tg-0pky">DES:<%
			out.print(rs.getString("destreza"));
			%></td>
			<td class="tg-0pky"></td>
			<td class="tg-0pky">SAB:<%
			out.print(rs.getString("sabiduria"));
			%></td>
		</tr>
		<tr>
			<td class="tg-0pky">CON:<%
			out.print(rs.getString("constitucion"));
			%></td>
			<td class="tg-0pky"></td>
			<td class="tg-0pky">CAR:<%
			out.print(rs.getString("carisma"));
			%></td>
		</tr>
	</tbody>
</table>
</div>
	
	<%}
count++;
	}
	//cerramos la conexión
	rs.close();
	}catch(SQLException error) {
	out.print("Error de Conexión : "+error.toString());
	}  

	%>
