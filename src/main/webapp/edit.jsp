<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcruddb.dao.BoardDAO" %>
<%@ page import="org.example.jspcruddb.bean.BoardVO" %>
<!DOCTYPE html>
<html>
<head>
    <title>글 수정</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <%@include file="inc/top.jsp"%>

    <h1>글 수정</h1>

    <%
        int seq = Integer.parseInt(request.getParameter("id"));
        BoardDAO dao = new BoardDAO();
        BoardVO board = dao.getBoard(seq);
    %>

    <form action="edit_ok.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= seq %>">
        <input type="hidden" name="currentPhoto" value="<%= board.getFilename() %>"> <!-- 기존 파일명 전달 -->

        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="<%= board.getTitle() %>" required>
        </div>

        <div class="mb-3">
            <label for="writer" class="form-label">작성자</label>
            <input type="text" class="form-control" id="writer" name="writer" value="<%= board.getWriter() %>" required>
        </div>

        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="content" rows="5" required><%= board.getContent() %></textarea>
        </div>

        <div class="mb-3">
            <label for="photo" class="form-label">첨부 사진</label>
            <% String currentImage = board.getFilename(); %>
            <% if (currentImage != null && !currentImage.isEmpty()) { %>
            <p>현재 이미지: <img src="upload/<%= currentImage %>" alt="Current Image" width="100"></p>
            <% } %>
            <input type="file" class="form-control" id="photo" name="photo">
        </div>

        <button type="submit" class="btn btn-primary">수정</button>
        <a href="index.jsp" class="btn btn-secondary">취소</a>
    </form>

    <%@include file="inc/bottom.jsp"%>
</div>
</body>
</html>
