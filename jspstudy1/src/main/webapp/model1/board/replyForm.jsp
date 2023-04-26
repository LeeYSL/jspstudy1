<%@page import="model.BoardDao"%>
<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--
      1.원글의 num을 파라미터 저장 : num 원글의 게시물 번호
      2.db에서 num의 게시물을 조회하여 원글의 num,grp,grplevel,gepstep
           정보를 저장
      3.입력 화면 표시    
    
     --%>
     <% 
      int num = Integer.parseInt(request.getParameter("num"));//파라미터 값 읽기
       BoardDao dao = new BoardDao();
       Board board = dao.selectOne(num); //원글 정보 %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<title>게시판 답글 쓰기</title></head>
<body><form action="reply.jsp" method="post" name="f">
<input type="hidden" name="num" value="<%=board.getNum()%>">
<input type="hidden" name="grp" value="<%=board.getGrp()%>">
<input type="hidden" name="grplevel" value="<%=board.getGrplevel()%>">
<input type="hidden" name="grpstep" value="<%=board.getGrpstep()%>">
<input type="hidden" name="boardid" value="<%=board.getBoardid()%>">
<table><caption>게시판 답글 등록</caption>
<tr><th>글쓴이</th><td><input type="text" name="name"></td></tr>
<tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
<tr><th>제목</th><td><input type="text" name="title"
           value="RE:<%=board.getTitle() %>"></td></tr>
           <tr><th>내용</th>
           <td><textarea name="content" rows="15"></textarea></td></tr>
           <tr><td colspan="2">
           <a href="javascript:document.f.submit()">[답변글등록]</a></td></tr>
</table>
</form></body></html>