<%-- 

작성자 : 유범석
작성일 : 2023.02.16
버전 정보 : V1.0

 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행전우리교회</title>
<%@ include file="/include/header.jsp" %>
<!-- lightbox2 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.css" integrity="sha512-Woz+DqWYJ51bpVk5Fv0yES/edIMXjj3Ynda+KWTIkGoynAMHrqTcDUQltbipuiaD5ymEo9520lyoVOo9jCQOCA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
.photo-gallery {
  color:#313437;
  background-color:#fff;
}

.photo-gallery h2 {
  font-weight:bold;
  margin-bottom:40px;
  padding-top:40px;
  color:inherit;
}

@media (max-width:767px) {
  .photo-gallery h2 {
    margin-bottom:25px;
    padding-top:25px;
    font-size:24px;
  }
}

.photo-gallery .photos {
  padding-bottom:20px;
}

.photo-gallery .item {
  padding-bottom:30px;
}
</style>

<style>
.bd-placeholder-img {
  font-size: 1.125rem;
  text-anchor: middle;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
}

@media (min-width: 768px) {
  .bd-placeholder-img-lg {
    font-size: 3.5rem;
  }
}
</style>
</head>
<body>
<%@ include file="/include/navbar.jsp" %>
<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>


<!-- 게시판 영역 -->
<div class="container">
	<div class="photo-gallery container mb-3">
		<div class="row justify-content-center">
			<h2 class="sticky-md-top">갤러리</h2>
			<div class="col-3 d-none d-lg-block">
				<%@ include file="/include/sidebar4.jsp" %>
			</div>
			<div class="col-9">
				<div class="row">
					<div class="col-6">
						<select class="form-select w-50" id="selectAmount">
				       		<option value="8" selected>8</option>
				       		<option value="16">16</option>
				       		<option value="24">24</option>
				        </select>
			        </div>
					<div class="col-6 text-end">
						<button class="btn btn-outline-secondary" type="button" onclick="regPhoto()">사진 등록</button>
					</div>
		        </div>
				
				<hr class="my-4">
				
				<div class="row photos" id="imgList"></div>
				
				<hr class="my-4">
				<div class="row">
					<div class="col-8">
						<ul class="pagination justify-content-center" id="pagination">
						
						</ul>
					</div>
					<div class="col-4">
						<div class="d-flex text-end">
						  <select class="form-select" id="selectType">
				       		<option value="T" selected>제목</option>
				       		<option value="F">파일명</option>
				       		<option value="E">이메일</option>
				       		<option value="TF">제목/파일명</option>
				       		<option value="TE">제목/이메일</option>
				       		<option value="TFE">제목/파일명/이메일</option>
				          </select>
					      <input class="form-control" type="search" placeholder="검색어" aria-label="" id="keyword">
					      <button class="btn btn-outline-success" type="button" id="searchBtn">검색</button>
					    </div>
				    </div>
		        </div>
			</div>
		</div>
	</div>
</div>






<%@ include file="/include/footer.jsp" %>
<!-- 등록 모달 -->
<div class="modal fade" id="uploadModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="msgModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="msgModalLabel">사진 등록</h1>
      </div>
      <div class="modal-body" id="msgModalBody">
		<form action="/4/post/postAddCheck.jsp" method="post" enctype="multipart/form-data" id="imgForm">
			<label class="form-label" for="ptitle">제목</label>
			<input class="form-control mb-3" type="text" name="ptitle" id="ptitle">
			<label class="form-label" for="post">주보 선택</label>
			<input class="form-control" type="file" name="post" id="post" onchange="PreviewImage();">
		</form>
    
	    <div style="clear:both">
	       <iframe id="viewer" frameborder="0" scrolling="no" width="300" height="200"></iframe>
	    </div>
		
      </div>
      <div class="modal-footer" id="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		<button type="button" class="btn btn-warning" data-bs-dismiss="modal" id="doneBtn">등록</button>
      </div>
    </div>
  </div>
</div>
<!-- lightbox2 js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js" integrity="sha512-k2GFCTbp9rQU412BStrcD/rlwv1PYec9SNrkbQlo6RZCf75l6KcC3UwDY8H5n5hl4v77IDtIPwOk9Dqjs/mMBQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/resources/js/page.js"></script>

<script>
/*
[form id 이걸로 하셈]

검색 버튼 : searchBtn
검색 입력 인풋 : keyword
검색 선택 셀렉트 : selectType
게시글 표시 갯수 셀렉트 : selectAmount
*/

/* 전체 게시물 수 가져오기 위해 처리한 jsp URL 입력해주세요 */
function getTotalCountUrl() {
	return '/4/post/totalNumProc.jsp'
}
/* 게시물 가져오기 위해 처리한 jsp URL 입력해주세요 */
function getListUrl() {
	return '/4/post/photoListProc.jsp'
}
function printList(data) {
	//TODO: 리스트 출력 처리 하세요
	var imgHTML = '';
	for (var i = 0; i < data.length; i++) {
		var img = data[i].pupfolder + '/' +data[i].puuid + '_' + data[i].pfilename;
		var pno = data[i].pno;
		var ptitle = data[i].ptitle;
		
		imgHTML += ''
			+ '<div class="postDiv col-sm-6 col-md-4 col-lg-3 item h-100">'
			+	 '<a class="col-lg-4 col-md-12 mb-4 mb-lg-0" data-title="'+ ptitle +'" data-lightbox="photos"'
			+	'href="postView.jsp?pno=' + pno + '">'
			+	'	<div>' + ptitle + 	'</div>'
			+ 	'<canvas id="the-canvas' + pno
			+ 	'" style="border:1px solid black" class="the-canvas"></canvas>'
			+ 	'</a>'
			+ '</div>'
			
	}
	$('#imgList').html(imgHTML);
	showPDF(img, pno);
}


function PreviewImage() {
    pdffile=document.getElementById("post").files[0];
    pdffile_url=URL.createObjectURL(pdffile);
    $('#viewer').attr('src',pdffile_url);
}
function showPDF(path, pno) {
	//If absolute URL from the remote server is provided, configure the CORS
	//header on that server.
	var url = path;
	
	//Loaded via <script> tag, create shortcut to access PDF.js exports.
	var pdfjsLib = window['pdfjs-dist/build/pdf'];
	
	//The workerSrc property shall be specified.
	pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';
	
	//Asynchronous download of PDF
	var loadingTask = pdfjsLib.getDocument(url);
	loadingTask.promise.then(function(pdf) {
	
	// Fetch the first page
	var pageNumber = 1;
	pdf.getPage(pageNumber).then(function(page) {
	 
	 var scale = 1.5;
	 var viewport = page.getViewport({scale: scale});
	
	 // Prepare canvas using PDF page dimensions
	 var canvas = document.getElementById('the-canvas'+pno);
	 var context = canvas.getContext('2d');
	 canvas.height = viewport.height;
	 canvas.width = viewport.width;
	
	 // Render PDF page into canvas context
	 var renderContext = {
	   canvasContext: context,
	   viewport: viewport
	 };
	 var renderTask = page.render(renderContext);
	 renderTask.promise.then(function () {
	 });
	});
	}, function (reason) {
	// PDF loading error
	console.error(reason);
	});
}















lightbox.option({
    resizeDuration: 200,
    wrapAround: false,
    disableScrolling: true,
    fitImagesInViewport: true
});

function regPhoto(){
	$('#uploadModal').modal('show');
}

$('#doneBtn').on('click', function(){
	if ($('#ptitle').val() != '' && $('#post').val() != '') {
		$('#imgForm').submit();
	} else {
		popModal('사진 등록 실패', '입력 값이 없는 항목이 있습니다.')
	}
});
</script>
</body>
</html>