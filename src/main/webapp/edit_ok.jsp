<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcruddb.dao.BoardDAO" %>
<%@ page import="org.example.jspcruddb.bean.BoardVO" %>
<%@ page import="org.example.jspcruddb.common.FileUpload" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <title>수정 완료</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <%@include file="inc/top.jsp"%>

    <%
        String msg;
        BoardVO vo = null;
        try {
            FileUpload fileUpload = new FileUpload();
            vo = fileUpload.uploadFile(request);  // 파일 업로드 처리 후 BoardVO 객체 반환

            // 수정 작업 실행
            BoardDAO dao = new BoardDAO();
            int result = dao.updateBoard(vo);  // **updateBoard 메서드 호출**

            msg = (result > 0) ? "데이터 수정 성공!" : "[에러] 데이터 수정 실패";

        } catch (Exception e) {
            e.printStackTrace();
            msg = "[에러] 처리 중 문제가 발생했습니다.";
        }

        // 결과 출력용 데이터
        int seq = vo != null ? vo.getSeq() : 0;
        String title = vo != null ? vo.getTitle() : "N/A";  // vo 객체에서 값 가져옴
        String writer = vo != null ? vo.getWriter() : "N/A";
        String content = vo != null ? vo.getContent() : "N/A";
        String filename = vo != null ? vo.getFilename() : "";  // 업로드된 이미지 이름 가져오기
    %>

    <h2><%= msg %></h2>
    <p>번호: <%= seq %></p>
    <p>제목: <%= title %></p>
    <p>작성자: <%= writer %></p>
    <p>내용: <%= content %></p>

    <%
        if (filename != null && !filename.isEmpty()) {  // 이미지 파일이 존재하는 경우
    %>
    <p>현재 이미지: <img src="upload/<%= filename %>" alt="Current Image" width="100"></p>
    <%
    } else {
    %>
    <p>업로드된 이미지가 없습니다.</p>
    <%
        }
    %>

    <a href="index.jsp" class="btn btn-primary">목록으로 돌아가기</a>

    <%@include file="inc/bottom.jsp"%>
</div>
</body>
</html>
