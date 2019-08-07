<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 입력 </title></head>
<body>
<%	String s_id = (String)session.getAttribute("user");
	String c_id = request.getParameter("c_id").trim();
	String t_day = request.getParameter("t_day").trim();
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no").trim());
		
	Connection myConn = null;    	
	String	result = null;
	String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user="db01";
	String passwd="12345";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	try {
		Class.forName(dbdriver);
	    	myConn =  DriverManager.getConnection (dburl, user, passwd);
    } catch(SQLException ex) {
	     System.err.println("SQLException: " + ex.getMessage());	}
	CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?,?)}");
	cstmt.setString(1, s_id);
	cstmt.setString(2, c_id);
	cstmt.setInt(3,c_id_no);
	cstmt.setString(4,t_day);
	cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);	
	try  {  
		cstmt.execute();
		result = cstmt.getString(5);
	%>
	<script>
		alert("<%= result %>");
		location.href = "insert.jsp";
	</script>
	<%	
	} catch(SQLException ex) {		
		 System.err.println("SQLException: " + ex.getMessage());}
	finally {
	    if (cstmt != null) 
            try { myConn.commit(); cstmt.close();  myConn.close();}
			catch(SQLException ex) { }
    }
%>
</body>
</html>