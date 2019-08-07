<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String session_id = (String) session.getAttribute("user");
String log;
int year0 = 2019, semester0 = 2;
if (session_id == null)
	log = "<a href=login.jsp>로그인</a>";
else
	log = "<a href=logout.jsp>로그아웃</a>"; 
%>
<table class="table table-bordered">
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="update.jsp">사용자 정보 수정</b></td>
<td align="center"><b><a href="show_table.jsp?year=<%= year0 %>&semester=<%= semester0 %>">강의시간표 조회</b></td>
<td align="center"><b><a href="insert.jsp">수강신청 입력</b></td>
<td align="center"><b><a href="delete.jsp">수강신청 삭제</b></td>
<td align="center"><b><a href="select.jsp?year=<%= year0 %>&semester=<%= semester0 %>">수강신청 조회</b></td>
</tr>
</table>
