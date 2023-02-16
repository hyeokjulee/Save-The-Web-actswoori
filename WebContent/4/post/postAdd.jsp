<!-- 
최초작성자 : 김지수 (jisukim.fb@gmail.com)
최초작성일 : 2023/02/15

버전  기록 : 0.1(시작 23/02/15) 
       0.5(기본작업 23/02/16) 
       0.7(추가 디자인 23/02/16)
       1.0(1차 완성 23/02/16)
--> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/include/header.jsp" %> 
<div class="container">
<form action="postAddCheck.jsp" name=f1 method=post enctype="multipart/form-data">
	제목 : <input type="text" name="ptitle"><br>
    <input id="uploadPDF" type="file" name="post"/>&nbsp;<br>
    
    <input type="button" value="미리보기" onclick="PreviewImage();" />

    <button type="submit" name="submit" class="btn btn-success btn-sm">
      <i class="fa fa-dot-circle-o"></i> 등록
    </button>&emsp;
    
    <div style="clear:both">
       <iframe id="viewer" frameborder="0" scrolling="no" width="300" height="200"></iframe>
    </div>
</form>
</div>


 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script>
function PreviewImage() {
    pdffile=document.getElementById("uploadPDF").files[0];
    pdffile_url=URL.createObjectURL(pdffile);
    $('#viewer').attr('src',pdffile_url);
}
</script>

<%@ include file="/include/footer.jsp" %>   
</body>
</html>