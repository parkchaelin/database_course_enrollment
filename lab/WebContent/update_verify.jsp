<%@ page language="java" contentType="text/html; charset=EUC-KR"   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
<title>수강신청 사용자 정보 수정 </title>
</head>
<body>
<% 
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;

	PreparedStatement pstmt = null;
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";	
	String user = "db01";
	String password = "12345";
	
	String formId = request.getParameter("id");
	String formPass = request.getParameter("password");
	String confirmPass = request.getParameter("passwordConfirm");

	if(!formPass.equals(confirmPass)) {
		%><script> 
		alert("비밀번호를 다시 확인해주세요."); 
		location.href="update.jsp";  
		</script><%
	}
	else {
		String str = "";
		try{
			
			myConn = DriverManager.getConnection(dburl, user, password);
		
			String sql = "UPDATE students SET s_pwd=? WHERE s_id=?";   
			pstmt = myConn.prepareStatement(sql);
			pstmt.setString(1,formPass);
			pstmt.setString(2,formId);	
						
			pstmt.executeUpdate();	
						
			%><script> 
			alert("성공적으로 수정했습니다."); 
			location.href="main.jsp";  
		</script><%		
		}
		catch(SQLException ex){
			String sMessage="";
			if (ex.getErrorCode() == 20002) sMessage = "암호는 4자리 이상 이어야 합니다";
			else if(ex.getErrorCode()== 20003) sMessage = "암호에 공란은 입력되지 않습니다. ";
			else sMessage = "잠시 후 다시 시도하십시오";
			out.println("<script>");
			out.println("alert('"+sMessage+"');");
			out.println("location.href='update.jsp';");
			out.println("</script>");
			out.flush();
		}finally{
			if(pstmt != null) try{pstmt.close();}catch(SQLException e){}
			if(myConn != null) try{myConn.close();}catch(SQLException e){}
		}
}
%>


</body>
</html>