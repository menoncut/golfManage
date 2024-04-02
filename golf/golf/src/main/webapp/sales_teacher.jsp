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
<title>sales_teacher</title>
</head>
<body>
<jsp:include page="header.jsp" />
	
<section style="position: fixed;
	top: 80px;
	width: 100%;
	height: 100%;
	background-color: lightgray;">
	
<h2 style="text-align: center">강사매출현황</h2><br>
<form style="display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;">
<table border="1">
	<tr>
		<th>강사코드</th>
		<th>강의명</th>
		<th>강사명</th>
		<th>총매출</th>
	</tr>
<%

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		con = DBCon.getConnection();
		String query = "SELECT a.TEACHER_CODE, a.CLASS_NAME, a.TEACHER_NAME, SUM(b.TUITION) as 총매출 ";
			   query += "FROM tbl_teacher_202201 a, tbl_class_202201 b ";
			   query += "WHERE a.TEACHER_CODE = b.TEACHER_CODE ";
			   query += "GROUP BY a.TEACHER_CODE, a.CLASS_NAME, a.TEACHER_NAME ";
			   query += "ORDER BY a.TEACHER_CODE";
				
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
		
		while (rs.next()) { 
			//String dateStr = rs.getString(1);
			//String year = dateStr.substring(0, 4);
			//String month = dateStr.substring(4, 6);
			//String day = dateStr.substring(6, 8);
			//String fDate = year + "년" + month + "월";
%>
			<tr>
				<td style="width: 90px"><%=rs.getString(1) %></td>
				<td style="width: 80px"><%=rs.getString(2) %></td>
				<td style="text-align: right; width: 90px"><%=rs.getString(3) %></td>
				<td style="text-align: right; width: 100px">￦<%=String.format("%,d", rs.getInt(4)) %></td>
			</tr>
<%
		}
	} catch (Exception e){
		System.out.println("강사매출조회 중 예외 발생");
		e.printStackTrace();
	}
%>
</table>
</form>
</section>

<jsp:include page="footer.jsp" />	
</body>
</html>