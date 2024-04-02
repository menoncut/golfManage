<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dbpkg.DBCon" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info_member</title>
</head>
<body>
<jsp:include page="header.jsp" />
	
<section style="position: fixed;
	top: 80px;
	width: 100%;
	height: 100%;
	background-color: lightgray;">
	
<h2 style="text-align: center">회원정보조회</h2><br>
<form style="display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;">
<table border="1">
	<tr>
		<th>수강월</th>
		<th>회원번호</th>
		<th>회원명</th>
		<th>강의명</th>
		<th>강의장소</th>
		<th>수강료</th>
		<th>등급</th>
	</tr>
<%

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		con = DBCon.getConnection();
		String query = "SELECT a.REGIST_MONTH, b.C_NO, b.C_NAME, c.CLASS_NAME, ";
			   query+= "a.CLASS_AREA, a.TUITION, b.GRADE ";
			   query+= "FROM tbl_class_202201 a, tbl_member_202201 b, tbl_teacher_202201 c ";
			   query+= "WHERE a.C_NO = b.C_NO AND a.TEACHER_CODE = c.TEACHER_CODE";
				
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
		
		while (rs.next()) { 
			String dateStr = rs.getString(1);
			String year = dateStr.substring(0, 4);
			String month = dateStr.substring(4, 6);
			//String day = dateStr.substring(6, 8);
			String fDate = year + "년" + month + "월";
		%>
			<tr>
				<td style="width: 150px"><%=fDate %></td>
				<td style="width: 90px"><%=rs.getString(2) %></td>
				<td style="width: 90px"><%=rs.getString(3) %></td>
				<td style="width: 90px"><%=rs.getString(4) %></td>
				<td style="width: 90px"><%=rs.getString(5) %></td>
				<td style="width: 150px">￦<%=String.format("%,d", rs.getInt(6)) %></td>
				<td style="width: 90px"><%=rs.getString(7) %></td>
			</tr>
<%			
		}
	} catch (Exception e){
		System.out.println("회원정보조회 중 예외 발생");
		e.printStackTrace();
	}
%>
</table>
</form>
</section>

<jsp:include page="footer.jsp" />	
</body>
</html>