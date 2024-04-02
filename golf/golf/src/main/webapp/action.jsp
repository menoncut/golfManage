<%@page import="dbpkg.DBCon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>action</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement psmt = null;
int result = 0;

String regi_month = request.getParameter("registMonth");
String c_no = request.getParameter("c_no").trim();
String class_area = request.getParameter("class_area");
String tuition = request.getParameter("tuition");
String teacher_code = request.getParameter("class_name");

try {
	con = DBCon.getConnection();
	String query = "INSERT INTO TBL_CLASS_202201 ";
		   query += "VALUES(?,?,?,?,?)";
	psmt = con.prepareStatement(query);
	psmt.setString(1, regi_month);
	psmt.setString(2, c_no);
	psmt.setString(3, class_area);
	psmt.setInt(4, Integer.parseInt(tuition));
	psmt.setString(5, teacher_code);
	result = psmt.executeUpdate();
	System.out.println(c_no);
	
	con.close();
	psmt.close();
} catch (Exception e) {
	System.out.println("수강신청 DB 저장 중 예외 발생");
	e.printStackTrace();
}
if(result == 1){
%>
	<script>
		alert("수강신청이 정상적으로 완료되었습니다.");
		location="index.jsp";
	</script>
<%	
}else {
%>
	<script>
		alert("수강신청에 실패하였습니다.");
		location="index.jsp";
	</script>
<%	
}
%>
</body>
</html>