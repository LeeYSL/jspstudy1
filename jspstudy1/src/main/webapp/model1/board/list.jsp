<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.Board"%>
<%@page import="java.util.List"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /jspstudy1/src/main/webapp/model1/board/list.jsp
   1. 한페이지당 10건의 게시물을 출력하기.
      pageNum 파라미터값을 저장 => 없는 경우는 1로 설정하기.
   2. 최근 등록된 게시물이 가장 위에 배치함.
   3. db에서 해당 페이지에 출력될 내용을 조회하여 화면에 출력.
           게시물을 출력부분.
           페이지 구분 출력 부분
   4. 페이지별 게시물번호 출력하기(boardnum)
   5. 첨부파일이 있는 경우 @ 표시하기           
--%>
<%
	if (request.getParameter("boardid") != null) {
	  //session에 게시판 종류 정보 등록	
	  session.setAttribute("boardid",request.getParameter("boardid"));
	  session.setAttribute("pageNum", "1"); //현재페이지 번호
 	}
	String boardid = (String) session.getAttribute("boardid");
	if (boardid == null) boardid = "1"; 
	int pageNum = 1;
    try {
	   pageNum = Integer.parseInt(request.getParameter("pageNum"));
    } catch (NumberFormatException e) {}
    
    int limit = 10;  //한페이지에 보여질 게시물 건수
    BoardDao dao = new BoardDao();
    //boardcount : 게시물종류별 게시물 등록건수
    int boardcount = dao.boardCount(boardid); //게시판 종류별 전체 게시물등록 건수 리턴
    //list : 현재 페이지에 보여질 게시물 목록. 
    List<Board> list = dao.list(boardid,pageNum,limit); 
    /*
       maxpage:필요한 페이지 갯수.
       게시물건수  필요한 페이지
          3        1
               3.0/10 => 0.3+0.95=>(int)1.25 => 1
         10        1
               10.0/10 => 1.0+0.95=>(int)1.95 => 1
         11        2
               11.0/10 => 1.1+0.95=>(int)2.05 => 2
        500        50
               500.0/10 => 50.0+0.95=>(int)50.95 => 50
        501        51
               501.0/10 => 50.1+0.95=>(int)51.05 => 51
    */
    int maxpage = (int)((double)boardcount/limit + 0.95);
    /*
     startpage: 화면에 출력될 시작 페이지 
      현재페이지    시작페이지
          1          1
            1/10.0 => 0.1 + 0.9 => 1.0 -1 => 0 *10 + 1 => 1
         10          1
            10/10.0 => 1.0 + 0.9 => (int)(1.9 -1) => 0 *10 + 1 => 1
         11         11
            11/10.0 => 1.1 + 0.9 => (int)(2.0 -1) => 1 *10 + 1 => 11
         505        501
           505/10.0 => 50.5 + 0.9 => (int)(51.4 -1) => 50 *10 + 1 => 501
    */
    int startpage=((int)(pageNum/10.0 + 0.9) - 1) * 10 + 1;
    /*
       endpage : 화면에 출력할 마지막 페이지 번호. 한 화면에 10개의 페이지를 보여줌
    */
    int endpage = startpage + 9; 
    if(endpage > maxpage) endpage = maxpage;
    //boardName : 게시판 이름 화면에 출력
    String boardName = "공지사항";
    switch (boardid) {
	  case "2":
		boardName = "자유게시판";	break;
	  case "3":
		boardName = "QNA"; break;
	}
    int boardnum = boardcount - (pageNum - 1) * limit;
    
    //날짜 비교 부분
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sf.format(new Date()); //"2023-04-07"
    SimpleDateFormat todayf = new SimpleDateFormat("HH:mm:ss");
    SimpleDateFormat otherf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>     
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>게시물 목록 보기</title>
</head><body>
<table><caption><%=boardName %></caption>
 <% if(boardcount == 0) {%> 
 <tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
 <% }  else {  //등록된 게시글이 있는 경우 %>
<tr><td colspan="5" style="text-align:right">글개수:<%=boardcount%></td></tr>
<tr><th width="8%">번호</th><th width="50%">제목</th>
    <th width="14%">작성자</th><th width="17%">등록일</th>
    <th width="11%">조회수</th></tr>
<% for(Board b : list) { // 게시글 조회 시작%>
<%--
   화면에 출력할 조회번호 수정하기 
   boardnum 변수 사용.
      1페이지 : boardcount 시작. 레코드 출력마다 -1씩 해서 출력
               boardcount - (pageNum - 1) * limit
      2페이지 : boardcount-10
      3페이지 : boardcount-20
 --%>
 <tr><td><%=boardnum--%></td>
 <td style="text-align: left">

 <%-- 첨부파일 @로 표시하기 --%>
  <% if (b.getFile1() != null && !b.getFile1().trim().equals("")){%>
    <a href="file/<%=b.getFile1()%>">@</a>
  <%} else {%>&nbsp;&nbsp;&nbsp;<%}%>
  
  
 <%-- 답글의 level 만큼 들여쓰기 --%>
 <%   if(b.getGrplevel()>0) {
	 for(int i=1; i<b.getGrplevel(); i++) { %>
	         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% }%> └ <%--ㅂ한자 --%>
<%}%>

  <a href="info.jsp?num=<%=b.getNum()%>"><%=b.getTitle() %></a></td>
 <td><%=b.getWriter() %></td>
 
<%-- 오늘 등록된 게시물 날짜 format대로 출력하기 --%> 
 <td><% if (today.equals(sf.format(b.getRegdate()))) { //당일등록게시물%>
	 <%=todayf.format(b.getRegdate()) %>
 <% } else {  //당일 등록게시물이 아님%>
    <%=otherf.format(b.getRegdate()) %>
   <% } %></td>
    
 <td><%=b.getReadcnt() %></td></tr>    
<% } //for 구문 끝 %>
<%-- 페이지 처리하기 --%>
 <tr><td colspan="5">
      <% if (pageNum <= 1) {%>[이전] <% } else { //하이퍼링크 처리 안함%> 
      <a href="list.jsp?pageNum=<%=pageNum - 1%>">[이전]</a><% } %>
      <% for (int a=startpage; a<=endpage;a++) {%>
         <% if (a==pageNum) {%>[<%=a %>] <%} else { %>
           <a href="list.jsp?pageNum=<%=a %>">[<%=a %>]</a>
         <% } 
       } %>
      <% if (pageNum >= maxpage) {%>[다음] <% } else { %>
      <a href="list.jsp?pageNum=<%=pageNum + 1%>">[다음]</a><% } %>
 </td></tr>  
<% } //게시물이 존재하는 경우 끝 %>
  <tr><td colspan="5" style="text-align:right">
<% String login = (String)session.getAttribute("login");
if (!boardid.equals("1") || (login != null && login.equals("admin"))){%> 
		<p align="right"><a href="writeForm.jsp">[글쓰기]</a></p>
<% } %></td></tr>
</table></body></html>