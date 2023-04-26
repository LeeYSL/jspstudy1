<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
 1.id 파라미터 값을 조회
 2.로그인상태 검증
     --로그아웃 상태 : "로그인 하세요" 메세지 출력 후 loginForm.jsp 페이지 호출
     --로그인 상태 
        -다른 id (관리자 제외) : "내 정보만 수정이 가능합니다." 메세지 출력 후 main.jsp 호출

3.db에서 id에 해당하는 데이터 조회
4.조회된 내용 화면에 출력하기 => 이전 데이터를 화면 출력. 수정전 화면 출력
--%>    
<%
 String id =request.getParameter("id");
 String login = (String)session.getAttribute("login");
 if(login == null) { %>
 <script>
    alert("로그인하세요")
    location.href = "loginForm.jsp"
 </script>
<%
 } else if(!id.equals(login) && !login.equals("admin")) {	
%>	
<script> 
 alert("내 정보만 조회 가능합니다.")
 location.href = "main.jsp"
 </script>
<% } else {
	Member mem = new MemberDao().selectOne(id);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
   function inputcheck(f) {
	   if(f.pass.value == '') {
		   alert("비밀번호를 입력하세요");
		   f.pass.fouse();
		   return false;
	   }
   }
  function win_passchg() {
	  var op ="width=500, height=250, left=50,top=150";
	  open("passwordForm.jsp" ,"",op);
}
  function win_upload() {
	  var op ="width=500, height=150, left=50,top=150";
	  open("pictureForm.jsp" ,"",op);
	
}
</script>
</head><body>
<form action="update.jsp" name="f" method="post"
       onesubmit="return inputcheck(this)"> <!-- this => form -->
<input type="hidden" name="picture" value="<%=mem.getPicture()%>">
<table><caption>회원정보 수정</caption>
<tr><td rowspan="4" valign="bottom">
 <img src="picture/<%=mem.getPicture() %>"
     width="100" height="120" id="pic"><br>
     <font size="1"><a href="javascript:win_upload()">사진수정</a></font>
     </td><th>아이디</th>
     <td><input type="text" name="id" readonly value="<%=mem.getId()%>"></td></tr> <!--readonly : 입력이 안 됨 -->
     <tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
     <tr><th>이름</th>
     <td><input type="text" name="name" value="<%=mem.getName()%>"></td></tr>
     <tr><th>성별</th>
     <td><input type="radio" name="gender" value="1"
     <%=mem.getGender()==1?"checked":""%>>남
        <input type="radio" name="gender" value="2"
     <%=mem.getGender()==2?"checked":""%>>여</td></tr>
     <tr><th>전화번호</th><td colspan="2"><input type="text" name="tel"
     value="<%=mem.getTel()%>"></td></tr>
     <tr><th>이메일</th><td colspan="2"><input type="text" name="email"
     value="<%=mem.getEmail()%>"></td></tr>
     <tr><td colspan="3"><input type="submit" value="회원수정">
     <% if(id.equals(login)) { %>
     <input type="button" value="비밀번호 수정" onclick="win_passchg()">
     <% } %></td></tr>
    
</table>        
</from>
</body>
</html>
<%}%>