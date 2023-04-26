<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--1.로그인 여부 검증
       로그인 상태: 현재 화면
       로그아웃 상태 :로그인이 필요한 화면입니다. 메세지 출력 후 loginForm.jsp 페이지로 이동 --%>	
 
<%
   //로그인 정보
   String login=(String)session.getAttribute("login"); //login.jsp페이지에서 넣어놨음
   if(login !=null){ // 로그인 된 상태
	   
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body>
<h3><%=login %>로 로그인 되었습니다.</h3>
<h3><a href="logout.jsp">로그아웃</a></h3>
<h3><a href="info.jsp?id=<%=login %>">회원정보보기</a></h3>
<% if(login.equals("admin")){// 관리자만 회원 목록 보기 추가 기능 %> 
 <h3><a href="list.jsp">회원목록 보기</a></h3>
<% } %>
</body></html>
<% } // if(login !=null){ 끝
   else { //로그 아웃 상태 %> 
<script type="text/javascript">
   alert("로그인이 필요합니다.")
   location.href="loginForm.jsp"
</script>
<%}%>