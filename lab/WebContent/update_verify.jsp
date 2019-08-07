<%@ page language="java" contentType="text/html; charset=EUC-KR"   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
<title>������û ����� ���� ���� </title>
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
		alert("��й�ȣ�� �ٽ� Ȯ�����ּ���."); 
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
			alert("���������� �����߽��ϴ�."); 
			location.href="main.jsp";  
		</script><%		
		}
		catch(SQLException ex){
			String sMessage="";
			if (ex.getErrorCode() == 20002) sMessage = "��ȣ�� 4�ڸ� �̻� �̾�� �մϴ�";
			else if(ex.getErrorCode()== 20003) sMessage = "��ȣ�� ������ �Էµ��� �ʽ��ϴ�. ";
			else sMessage = "��� �� �ٽ� �õ��Ͻʽÿ�";
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