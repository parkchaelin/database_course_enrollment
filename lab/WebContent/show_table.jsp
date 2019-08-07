<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head><title>강의시간표 조회</title></head>
<link rel="stylesheet" href="css/bootstrap.css">
<body>
<%@ include file="top.jsp" %>
<%  
	if (session_id==null)
		response.sendRedirect("login.jsp"); 

	int year = Integer.parseInt(request.getParameter("year"));
	int semester = Integer.parseInt(request.getParameter("semester"));
	String yearSelect = request.getParameter("year");
	String semesterSelect = request.getParameter("semester");
	
	Connection myConn = null;
	Statement stmt = null;
	ResultSet myResultSet = null;
	String mySQL = "";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String passwd = "12345";
%>
<div id="containerwrap">
	<div id="container">
<table class="table table-striped"><form method="post" id="year_semester" action="show_table.jsp?">
	<tr><td>연도:</td><td> <select type="hidden" name="yearSelect" id="yearSelect">
					<option value="2019"<%=yearSelect.equals("2019")?"selected":""%>>2019학년도</option>
					<option value="2018"<%=yearSelect.equals("2018")?"selected":""%>>2018학년도</option>
					<option value="2017"<%=yearSelect.equals("2017")?"selected":""%>>2017학년도</option>
					<option value="2016"<%=yearSelect.equals("2016")?"selected":""%>>2016학년도</option></select></td>
		<td>학기:</td><td><select type="hidden" name="semesterSelect" id="semesterSelect">
							<option value="2"<%=semesterSelect.equals("2")?"selected":""%>>2학기</option>
							<option value="1"<%=semesterSelect.equals("1")?"selected":""%>>1학기</option></select></td>
		<td><button type="button" onClick="button_clicked();" class="btn">검색</button></td><td width="50%"></td></tr></form></table>
<script>
	function button_clicked(){
		year = document.getElementById("yearSelect").value;
		semester = document.getElementById("semesterSelect").value;
		location.href="show_table.jsp?year="+year+"&semester="+semester;
	}
</script>
		<table class="table table-striped"><tr><th class="text-center">과목번호</th><th class="text-center">분반</th><th class="text-center">과목명</th><th class="text-center">학점</th><th class="text-center">요일</th><th class="text-center">시간</th></tr>
<%   
	try {
		Class.forName(dbdriver);
		myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();
		} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		//mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_year, t.t_semester, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no = t.c_id_no and c.c_id not in (select c_id from enroll where s_id='" + session_id + "')";
		mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_year, t.t_semester, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no = t.c_id_no";
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
		         String t_time = myResultSet.getString("t_time");
		         if (t_year == year && t_semester == semester){
%>
			<tr>
				<td align="center"><%= c_id %></td>
				<td align="center"><%= c_id_no %></td>
				<td align="center"><%= c_name %></td>
				<td align="center"><%= c_unit %></td>
				<td align="center"><%= t_day %></td>
				<td align="center"><%= t_time %></td>
			</tr>
<%
				}
			} 
		}
	stmt.close();  
	myConn.close();
%>
</table></div></div></body></html>