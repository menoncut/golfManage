<%@page import="java.sql.PreparedStatement"%>
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
<title>register</title>
</head>
<body>
<jsp:include page="header.jsp" />
	
<section style="position: fixed;
	top: 80px;
	width: 100%;
	height: 100%;
	background-color: lightgray;">
	
<h2 style="text-align: center">수강신청</h2><br>

<form style="display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;"
	name="regiForm" method="post" action="action.jsp">
<table border="1">
	<tr>
		<th>수강월</th>
		<td colspan="3" style="text-align: left;">
			<input type="text" name="registMonth" />2022년03월 예)202203
		</td>
	</tr>
	<tr>
		<th>회원명</th>
		<td colspan="3" style="text-align: left;">
			<select name="c_name" onchange="nameChange();">
				<option value="">회원명</option>	
				<option value="10001">홍길동</option>
				<option value="10002">장발장</option>
				<option value="10003">임꺽정</option>
				<option value="20001">성춘향</option>
				<option value="20002">이몽룡</option>
			</select>
		</td>
	</tr>
	<%--<%
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String c_name = request.getParameter("c_name");
		String c_no = null;
		
		try {
			con = DBCon.getConnection();
			
			String query = "SELECT C_NO FROM TBL_MEMBER_202201 WHERE C_NAME=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, c_name);
			System.out.println(c_name);
			System.out.println("hi");
			rs = psmt.executeQuery();
			rs.next();
			c_no = rs.getString(1);
			
			
			if(rs.next()) {
				c_no = rs.getString("c_no");
			}
		} catch(Exception e){
			System.out.println("회원번호 조회 중 예외 발생");
			e.printStackTrace();
		}		
	--%>
	<tr>
		<th>회원번호</th>
		<td colspan="3" style="text-align: left;">
			<input type="text" name="c_no" readonly/>예)10001
		</td>
	</tr>
	<tr>
		<th>강의장소</th>
		<td colspan="3">
			<input type="radio" name="class_area" value="서울본원"/>서울본원
			<input type="radio" name="class_area" value="성남분원"/>성남분원
			<input type="radio" name="class_area" value="대전분원"/>대전분원
			<input type="radio" name="class_area" value="부산분원"/>부산분원
			<input type="radio" name="class_area" value="대구분원"/>대구분원
		</td>
	</tr>
	<tr>
		<th>강의명</th>
		<td colspan="3" style="text-align: left;">
			<select name="class_name" onchange="classChange();">
				<option value="">강의신청</option>
				<option value="100">초급반</option>
				<option value="200">중급반</option>
				<option value="300">고급반</option>
				<option value="400">심화반</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>수강료</th>
		<td colspan="3" style="text-align: left;">
			<input type="text" name="tuition" value=""/>원
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<input type="button" value="수강신청" onclick="regiCheck();"/>
			<input type="button" value="다시쓰기" onclick="frmReset();" />
		</td>
	</tr>		
</table>
</form>
</section>

<jsp:include page="footer.jsp" />	
</body>
<script type="text/javascript">
	function nameChange() {
		let frm = document.regiForm;
		frm.tuition.value = "";
		frm.class_name.options[0].selected = true;
		
		frm.c_no.value = frm.c_name.value;
	}
	
	function classChange() {
		let frm = document.regiForm;
		let price = frm.class_name.value * 1000;
		let c_no = frm.c_no.value;
		if(c_no >= 20000) {
			price *= 0.5;
		}
		frm.tuition.value = price;
	}
	
	function regiCheck() {
		let frm = document.regiForm;
		
		if(frm.registMonth.value === "") {
			alert("수강월을 입력해주세요!");
			frm.registMonth.focus();
			return false;
		}
		
		if(frm.c_name.value === "") {
			alert("회원명을 선택해주세요!");
			frm.c_name.focus();
			return false;
		}
		
		if(frm.class_area.value === "") {
			alert("강의장소를 선택해주세요!");
			frm.class_area.focus();
			return false;
		}
		
		if(frm.class_name.value === "") {
			alert("강의명을 선택해주세요!");
			frm.class_name.focus();
			return false;
		}
		
		frm.submit();
	}
	
	function frmReset() {
		if(confirm("정보를 지우고 처음부터 다시 입력합니다!")) {
			location = "register.jsp";
		}
	}
</script>
</html>