<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %><%@ page import="java.io.*" %><%@ page import="java.util.Date" %>
<html>
<head><title>수강신청 사용자 정보 수정 </title>
<link rel="stylesheet" href="css/bootstrap.css">

<body>
<%@include file="top.jsp"%>

<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;
	
	String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user="db01";
	String passwd="12345";	
	
	String userPwd="";
	
	Statement stmt = null;	
	String mySQL = null;
	ResultSet myResultSet = null;
	//String major = null;
%>
</head>
<%
if (session_id==null) {
	response.sendRedirect("login.jsp");
}
else{
	try{
		myConn=DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		
		mySQL = "select s_pwd from students where s_id='"+ session_id + "'";
		myResultSet = stmt.executeQuery(mySQL);	
	}
	catch(SQLException e){
		out.println(e);
		e.printStackTrace();
	}finally{
		if(myResultSet != null){
			if(myResultSet.next())
				userPwd = myResultSet.getString("s_pwd");		
		}
	}
%>

<form method ="post" action="update_verify.jsp">
<div class="form-group">
<table class="table">
<tr>
			  <td id="update_td">아이디</td>
			  <td colspan="3"><input id="update_id_in" type="text" name="id" size="50" style="text-align: center;" value="<%=session_id%>" readonly></td>
			</tr>
			<tr>  
			  <td id="update_td">비밀번호</td>
			  <td><input id="update_pw_in" type="password" name="password" size="10" value=<%=userPwd%>></td>
			  <td id="update_td">확인입력</td>
			  <td><input id="update_pw_in" type="password" name="passwordConfirm" size="10" ></td>
			</tr>			
			
			<tr>
			  <td colspan="4" align="center">
			  <input id="update_btn" type="submit" value="수정 완료" class="btn">
			  <input id="update_btn" type="reset" value="초기화" class="btn">
			</tr>
			</table>
			</div>
			</form>
<%
			stmt.close(); 
			myConn.close();
}
%>
	</body></html>