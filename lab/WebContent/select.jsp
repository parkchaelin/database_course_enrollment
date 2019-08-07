<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<head>
  <title>강의 조회</title>
  <link rel="stylesheet" href="css/bootstrap.css">
</head>
<%@ include file="top.jsp" %>
<%
	int year = Integer.parseInt(request.getParameter("year"));
	int semester = Integer.parseInt(request.getParameter("semester"));
	
	String yearSelect = request.getParameter("year");
	String semesterSelect = request.getParameter("semester");
	
   String dbdriver = "oracle.jdbc.driver.OracleDriver";
   Class.forName(dbdriver);
   Connection myConn = null;
   
   String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
   String user="db01";
   String passwd="12345";   

  if (session_id == null) {
%>
<script>
  alert("로그인이 필요합니다.");
  location.href = "login.jsp";
</script>
<%
} else {
%>
<div id="containerwrap">
  <div id="container">

    </div>
<table class="table table-striped"><form method="post" id="year_semester" action="select.jsp?"><div class="form-group">
	<tr><td>연도: <select type="hidden" name="yearSelect" id="yearSelect">
					<option value="2019"<%=yearSelect.equals("2019")?"selected":""%>>2019학년도</option>
					<option value="2018"<%=yearSelect.equals("2018")?"selected":""%>>2018학년도</option>
					<option value="2017"<%=yearSelect.equals("2017")?"selected":""%>>2017학년도</option>
					<option value="2016"<%=yearSelect.equals("2016")?"selected":""%>>2016학년도</option></select></td>
		<td>학기:	<select type="hidden" name="semesterSelect" id="semesterSelect" style="width:80px;">
							<option value="2"<%=semesterSelect.equals("2")?"selected":""%>>2학기</option>
							<option value="1"<%=semesterSelect.equals("1")?"selected":""%>>1학기</option></select></td>
		<td><button type="button" onClick="button_clicked();" class="btn">검색</button></td><td width="50%"></td></tr></div></form></table>
<script>
	function button_clicked(){
		year = document.getElementById("yearSelect").value;
		semester = document.getElementById("semesterSelect").value;
		location.href="select.jsp?year="+year+"&semester="+semester;
	}
</script>
    <table class="table table-striped"><br/>
      <tr style="background: lightgrey"><th class="text-center">과목번호</th><th class="text-center">분반</th><th class="text-center">과목명</th><th class="text-center">학점</th><th class="text-center">요일</th><th class="text-center">시간</th></tr>
      <%
        CallableStatement stmt = null;
        ResultSet myResultSet = null;
        myConn =  DriverManager.getConnection (dburl, user, passwd);
        String mySQL = "{call SelectTimeTable(?,?,?,?,?,?)}";
        stmt = myConn.prepareCall(mySQL);
        stmt.setString(1, session_id);
        stmt.setInt(2, year);
        stmt.setInt(3, semester);
        stmt.registerOutParameter(4, oracle.jdbc.OracleTypes.CURSOR);
        stmt.registerOutParameter(5, oracle.jdbc.OracleTypes.NUMBER);
        stmt.registerOutParameter(6, oracle.jdbc.OracleTypes.NUMBER);
        stmt.execute();
        myResultSet = (ResultSet) stmt.getObject(4);
        int sumCourse = stmt.getInt(5);
        int sumUnit = stmt.getInt(6);
		
        while (myResultSet.next()) {
          String c_id = myResultSet.getString("c_id");
          int c_id_no = myResultSet.getInt("c_id_no");
          String c_name = myResultSet.getString("c_name");
          int c_unit = myResultSet.getInt("c_unit");
          int t_time = myResultSet.getInt("t_time");
          String t_day = myResultSet.getString("t_day");
	%>
      <tr>
        <td align="center"><%=c_id%></td><td align="center"><%=c_id_no%></td><td align="center"><%=c_name%></td><td align="center"><%=c_unit%></td>
        <td align="center"><%=t_day%></td><td align="center"><%=t_time%></td>
      </tr>
    <%}
        
    %>
    </table>
    <h3 align="center" style="margin: 3em;">
      총
      <%=sumCourse%>
      과목,
      <%=sumUnit%>
      학점 신청하셨습니다.
    </h3>
  </div>
</div>

<%
    stmt.close();
    myConn.close();
	}
%>