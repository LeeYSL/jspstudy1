<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
    1.파라미터 정보 저장
    2.로그인 정보 검증
       -로그아웃 상태: 로그인 하세요 메세지 출력 후 loginForm.jsp 페이지 이동
       -다른사람 탈퇴(관리자 제외) : 본인만 탈퇴 가능 메세지 출력 후 main.jsp 페이지로 이동
    3.관리자 탈퇴는 검증
       -관리자 정보 탈퇴: 관리자는 탈퇴 불가 list.jsp 페이지로 이동
    4.비밀번호 검증
       -로그인 정보로 비밀번호 검증
         비밀번호 불일치 : 비밀번호 오류 출력 후 delectForm.jsp 페이지로 이동
    5.db에서 delete 실행
        boolean MemberDao.delete(id)
        탈퇴성공 
        - 일반 사용자 : 로그아웃 실행. 탈퇴 완료 메세지 출력 후 loginForm.jsp 페이지로 이동
        - 관리자가 다른 사람 탈퇴 : 탈퇴 성공 메세지 출력 후 list.jsp 페이지로 이동 
        탈퇴실패
        - 일반 사용자 : 탈퇴 실패 메세지 출력 후 info.jsp 페이지로 이동
        - 관리자가 다른 사람 탈퇴 : 탈퇴 실패 메세지 출력 후 list.jsp 페이지로 이동              
     --%>
<% //1.파라미터 정보 저장
   String id = request.getParameter("id");
   String pass =request.getParameter("pass");
   //2.로그인 정보 검증
   String login = (String)session.getAttribute("login");
   String msg =null;
   String url=null;
     if(login==null){
      msg = "로그인 하세요";
      url ="loginForm.jsp";
      }else if(!id.equals(login) && !login.equals("admin")) { ///?
        msg="본인만 탈퇴 가능합니다.";
        url="main.jsp";
      }else if(id.equals("admin")){
			 msg="관리자는 탈퇴 불가능 합니다.";
			 url="list.jsp";  
	  }else {//탈퇴 가능 상태
	 //4.비밀번호 검증
	 MemberDao dao = new MemberDao();
	 Member dbMem = dao.selectOne(login); //dbmem 로그인한 사용자의 정보 조회
	 if(pass.equals(dbMem.getPass())) {
		//pass : 입력한 비밀번호
		//dbMem.getPass : db에 저장 된 비밀번호
		  if(dao.delete(id)) { //탈퇴성공
			   msg=id +"고객 탈퇴 성공";
			   if(login.equals("admin")) {
				   url ="list.jsp";	 
			  }else { //일반 사용자
				  session.invalidate(); //세션 종료
			      url ="loginForm.jsp";
			  }
		  }else{//탈퇴실패
			  msg=id +"고객 탈퇴시 오류 발생.탈퇴 실패";
 		      if(login.equals("admin")){
			    url ="list.jsp";
		      }else {//일반사용자
			   url ="info.jsp?id="+id;
		      }
		  }
	 } else { //비밀번호 오류
		msg = "비밀번호 오류";
	    url ="deleteForm.jsp?id=" +id;
	    		
	 }
  }
%>
<script type="text/javascript">
  alert("<%=msg%>")
  location.href ="<%=url%>"
</script>

