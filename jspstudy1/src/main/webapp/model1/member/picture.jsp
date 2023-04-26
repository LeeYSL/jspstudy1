<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 //path : 파일 업로드 위치 현재폴더 : model1/member/+picture/폴더
    String path = application.getRealPath("") + "model1/member/picture/";
    String fname = null;
    File f = new File(path);
    if(!f.exists()) { f.mkdirs();  } //업로드 폴더가 없는 경우 폴더 생성
    MultipartRequest multi = new MultipartRequest 
    		                      (request,path,10*1024*1024,"UTF-8");
    fname = multi.getFilesystemName("picture"); //업로드된 파일의 이름
 %>   
 <script type="text/javascript">
    //opener : 현재 window를 open한 window 값 =>joinForm.jsp
    img = opener.document.getElementById("pic");//id 속성값이 pic라는 태그 선택
    //img 태그의 src 속성 이 순간 joinForm.jsp 페이지에 이미지 보여짐 
    img.src = "picture/<%=fname%>"; 
   //<input type="hidden" name ="picture" value="">
    opener.document.f.picture.value="<%=fname%>";
    self.close(); //현재 창 닫기
 </script>
    
 