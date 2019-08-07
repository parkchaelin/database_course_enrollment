<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head> <title>수강신청 삭제</title> </head>
<link rel="stylesheet" href="css/bootstrap.css">
<body>
<%@ include file="top.jsp" %>
<%   if (session_id==null) response.sendRedirect("login.jsp");  %>
<table class="table table-striped">
<br>
<tr><th class="text-center">과목번호</th><th class="text-center">분반</th><th class="text-center">과목명</th><th class="text-center">학점</th><th class="text-center">요일</th><th class="text-center">수강취소</th></tr>
<%   
   Connection myConn = null; 
   Statement stmt = null;
   ResultSet myResultSet = null;
   String mySQL = "";
   String dbdriver = "oracle.jdbc.driver.OracleDriver";
   String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
   String user = "db01";
   String passwd = "12345";
   
   try {
      Class.forName(dbdriver);
       myConn =  DriverManager.getConnection (dburl, user, passwd);
      stmt = myConn.createStatement();   
    } catch(SQLException ex) {
        System.err.println("SQLException: " + ex.getMessage());
   }
   //mySQL = "select e.c_id, e.c_id_no, c.c_name,c.c_unit, e.e_year, e.e_semester, e.t_day from course c, enroll e where e.s_id='"+ session_id + "' and c.c_id=e.c_id";
   //mySQL = "select c_id, c_id_no, c_name, c_unit from course where c_id not in (select c_id from enroll where s_id='" + session_id + "')";
   mySQL = "select e.c_id, e.c_id_no, c.c_name,c.c_unit, e.e_year, e.e_semester, e.t_day from course c, enroll e where e.s_id='"+ session_id + "' and c.c_id=e.c_id and c.c_id_no=e.c_id_no";
   myResultSet = stmt.executeQuery(mySQL);

   if (myResultSet != null) {
      while (myResultSet.next()) {
         String c_id = myResultSet.getString("c_id");
         int c_id_no = myResultSet.getInt("c_id_no");         
         String c_name = myResultSet.getString("c_name");
         int c_unit = myResultSet.getInt("c_unit");
         int t_year = myResultSet.getInt("e_year");
         int t_semester = myResultSet.getInt("e_semester");
         String t_day = myResultSet.getString("t_day");
         if (t_year == 2019 && t_semester == 2)      
{%>
<tr>
  <td align="center"><%= c_id %></td>
  <td align="center"><%= c_id_no %></td> 
  <td align="center"><%= c_name %></td>
  <td align="center"><%= c_unit %></td>
  <td align="center"><%= t_day %></td>
  <td align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>&t_day=<%= t_day %>">삭제</a></td>
</tr>
<%}
      }
   }
   stmt.close(); 
   myConn.close();
%>
