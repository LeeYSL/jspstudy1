<%@page import="model.BoardDao"%>
<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--
    1.파라미터 값을 Board 객체에 저장하기
        원글 정보 : num,grp,grplevel,gepstep,boardid
        답글 정보 : writer, pass, title, content = > 등록정보
    2.같은 grp 값을 사용하는 게시물의 grpstep 값을 1 증가 하기.
      void BoardDao.grpStrpAdd(grp,grpstep)
    3.Board 객체를 db에 insert 하기
        num : maxnum +1
        grp : 원글과 동일
        grplevel : 원글 +1
        grpstep  : 원글 +1
        boardid :  원글과 동일
     4.등록 성공 시 :list.jsp 페이지 이동
       등롤 실패 시 :"답변 등록시 오류 발생" 메세지지 출력 후 replyForm.jsp 페이지로 이동 
    
    --%>
    
    <% //1
     request.setCharacterEncoding("UTF-8");
     Board b = new Board(); // 답글에 저장될
     b.setWriter(request.getParameter("writer"));
     b.setPass(request.getParameter("pass"));
     b.setTitle(request.getParameter("title"));
     b.setContent(request.getParameter("content"));
     b.setBoardid(request.getParameter("boardid"));
     b.setGrp(Integer.parseInt(request.getParameter("grp")));
     b.setGrplevel(Integer.parseInt(request.getParameter("grplevel")));
     b.setGrpstep(Integer.parseInt(request.getParameter("grpstep")));
     //2
     BoardDao dao = new BoardDao();
     dao.grpStepAdd(b.getGrp(),b.getGrpstep());//grpstep 변경
     //3 답글 등록
     int grplevel = b.getGrplevel();
     int grpstep = b.getGrpstep();
     int num = dao.maxnum(); 
     String msg = "답변 등록시 오류 발생";
     String url = "replyForm.jsp?num="+b.getNum();
     b.setNum(++num);// 답글에 대한 정보 
     b.setGrplevel(grplevel +1);//원글 grplevel 보다 하나 더 커야 함 => 답글 데이터
     b.setGrpstep(grpstep +1);//원글 grpstep 보다 하나 더 커야 됨 => 답글 데이터
     if(dao.insert(b)) { // b라는 객체 만들어서 insert
    	 response.sendRedirect("list.jsp?boardid="+b.getBoardid()); //응답이 있으면 응답 객체의 list.jsp로 보내
     }else {%>
     <script>
     alert("<%=msg%>");
     location.href="<%=url%>";
     </script>
   <%} %>
       

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>