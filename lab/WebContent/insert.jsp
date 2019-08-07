<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head> <title>수강신청 입력</title> </head>
<link rel="stylesheet" href="css/bootstrap.css">
<body>
<%@ include file="top.jsp" %>
<%   if (session_id==null) response.sendRedirect("login.jsp");  %>
<table class="table table-striped">
<br>
<tr><th class="text-center">과목번호</th><th class="text-center">분반</th><th class="text-center">과목명</th><th class="text-center">학점</th><th class="text-center">요일</th><th class="text-center">시간</th><th class="text-center">담당교수</th><th class="text-center">여석</th><th class="text-center">수강신청</th></tr>
<%   
   Connection myConn = null; 
   Statement stmt = null;
   Statement stmt2 = null;
   ResultSet myResultSet = null;
   ResultSet myResultSet2 = null;
   String mySQL = "";
   String dbdriver = "oracle.jdbc.driver.OracleDriver";
   String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
   String user = "db01";
   String passwd = "12345";
   
   try {
      Class.forName(dbdriver);
      myConn =  DriverManager.getConnection (dburl, user, passwd);
      stmt = myConn.createStatement();
      stmt2 = myConn.createStatement();
    } catch(SQLException ex) {
        System.err.println("SQLException: " + ex.getMessage());
   }
   mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_year, t.t_semester, t.t_day, t.t_max,t_time, p_name from course c, teach t where c.c_id = t.c_id and c.c_id_no = t.c_id_no and (c.c_id, c.c_id_no) not in (select c_id, c_id_no from enroll where s_id='" + session_id + "')";
   myResultSet = stmt.executeQuery(mySQL);

   if (myResultSet != null) {
      while (myResultSet.next()) {
         String c_id = myResultSet.getString("c_id");
         int c_id_no = myResultSet.getInt("c_id_no");         
         String c_name = myResultSet.getString("c_name");
         int c_unit = myResultSet.getInt("c_unit");
         int t_year = myResultSet.getInt("t_year");
         int t_semester = myResultSet.getInt("t_semester");
         String t_day = myResultSet.getString("t_day");
         int t_max = myResultSet.getInt("t_max");
         int t_time = myResultSet.getInt("t_time");
         String p_name = myResultSet.getString("p_name");
         int count = 0;
         String id = null;
         myResultSet2 = stmt2.executeQuery("select count(*) from enroll where c_id ='"+c_id+"'and c_id_no ='"+c_id_no+"'and e_year='"+t_year+"'and e_semester='"+t_semester+"'");
         if (myResultSet2 != null){
            while (myResultSet2.next()){
               count = Integer.parseInt(myResultSet2.getString("count(*)"));
            }
         }
         if (t_year == 2019 && t_semester == 2)      
{%>
<tr>
  <td align="center"><%= c_id %></td>
  <td align="center"><%= c_id_no %></td> 
  <td align="center"><%= c_name %></td>
  <td align="center"><%= c_unit %></td>
  <td align="center"><%= t_day %></td>
  <td align="center"><%= t_time %></td>
  <td align="center"><%= p_name %></td>
  <td align="center"><%= t_max-count %></td>
  <td align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>&t_day=<%= t_day %>">신청</a></td>
</tr>
<%}
      }
   }
   stmt.close(); 
   stmt2.close(); 
   myConn.close();
%>
</table></body></html>