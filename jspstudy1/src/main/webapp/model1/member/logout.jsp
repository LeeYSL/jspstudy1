<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- 
    1.session의 로그인 정보 제거
    2. 로그아웃 메세지 출력 후 loginForm.jsp 페이지로 이동 --%>

<meta charset="UTF-8">

<% session.removeAttribute("login");
   session.invalidate(); //새로운 session 객체로 변경. 이전 속성들이 전부 제거
//   response.sendRedirect("loginForm.jsp"); 메세지 출력 없이 하는 거 안에 내용이 있더라도 무시하고 페이지 이동만 한다.
   %>
   
<script>
   alert("로그아웃 되었습니다.")
     location.href="loginForm.jsp"
 
</script>