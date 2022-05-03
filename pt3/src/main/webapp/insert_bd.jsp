<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays,java.util.List"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insertar BBDD</title>
 <link rel="stylesheet" href="css/styles.css" type="text/css" />
</head>
<body>
<%// variables per fer la connexio:
	String user="usr_generic";
	String password="Thico@2020";
	String host="localhost";
	String db = "M8cards";
	String url = "jdbc:mysql://"+host+"/"+db;
	Connection conn = null;
	Statement statement = null;
	ResultSet rs = null;
	
	
	// recollim valors formulari:
	String nom=request.getParameter("nombre");
	String race=request.getParameter("race");
	String picture=request.getParameter("imagen");
	
	String fue=request.getParameter("fuerza");
	int nfue=Integer.parseInt(fue);
	String des=request.getParameter("destreza");
	int ndes=Integer.parseInt(des);
	String con=request.getParameter("constitucion");
	int ncon=Integer.parseInt(con);
	String intt=request.getParameter("inteligencia");
	int nint=Integer.parseInt(intt);
	String sab=request.getParameter("sabiduria");
	int nsab=Integer.parseInt(sab);
	String car=request.getParameter("carisma");
	int ncar=Integer.parseInt(car);
	String pv=request.getParameter("pv");
	int npv=Integer.parseInt(pv);
	String pm=request.getParameter("pm");
	int npm=Integer.parseInt(pm);

try{

	Class.forName("com.mysql.jdbc.Driver").newInstance ();
		conn = DriverManager.getConnection(url, user, password);
		statement = conn.createStatement();
		//inmediatamente hacemos un insert amb les dades
		//creamos la consulta
int i=statement.executeUpdate("insert into tbl_cartas(nombre,fuerza,destreza,constitucion,inteligencia,sabiduria,carisma,pv,pm,raza,imagen)values('"+nom+"',"+nfue+","+ndes+","+ncon+","+nint+","+sab+","+car+","+pv+","+pm+",'"+race+"','"+picture+"')");
out.println("Data is successfully inserted! <a href=\"index.jsp\"><button class=\"button\">Inici</button></a>");
}catch(SQLException error) {
out.print("Error de Conexión : "+error.toString());
} %>
