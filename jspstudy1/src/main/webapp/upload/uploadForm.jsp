<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%--
      1.파일 다운로드 : http://servlets.com/cos/
      2. cos-22.05.zip 다운 받고 압출 풀기
      3.압출 풀고 lib 폴더의 cos.jar 파일 복사 하여 WEB-INF/lib/ 붙여 넣기
      --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 예제</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
<!--
  enctype="multipart/form-data" : 파일 업로드를 위한 설정.
                                  파라미터와 업로드할 파일의 내용까지 서버로 전송
    1. <input type="file"...> 태그가 존재해야됨 존재 시 => 선택된 파일의 내용까지 서버로 전송
    2. method는 반드시 "post"
    3. upload.jsp 페이지는 request 객체 직접 사용 불가.
                                    
-->
<form action="upload.jsp" method="post" enctype="multipart/form-data"> 
<table><tr><th>올린사람</th><td><input type="text" name="name"></td></tr>
<tr><th>제목</th><td><input type="text" name="title"></td></tr>
<tr><th>파일</th><td><input type="file" name="filel"></td></tr>
<tr><td colspan="2"><input type="submit" value="전송"></td></tr>
</table></form></body></html>     