<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%

String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");

Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db01";
String passwd = "12345";

Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();

mySQL="select s_id from students where s_id='" + userID + "'and s_pwd='" + userPassword + "'";
ResultSet myResultSet = stmt.executeQuery(mySQL);

if(myResultSet.next()){ 
	session.putValue("user", userID);
	response.sendRedirect("main.jsp");
}
else {
	%>
		<script>
			alert("사용자아이디 혹은 암호가 틀렸습니다.");
			location.href="login.jsp";
		</script>
	<%
}

stmt.close();
myConn.close();
%>