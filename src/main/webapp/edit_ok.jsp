<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcruddb.dao.BoardDAO" %>
<%@ page import="org.example.jspcruddb.bean.BoardVO" %>
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
        // Get the post details from the form
        int seq = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");

        // Create a BoardVO object to update the database
        BoardVO board = new BoardVO();
        board.setSeq(seq);
        board.setTitle(title);
        board.setWriter(writer);
        board.setContent(content);

        // Create a BoardDAO object to perform the update
        BoardDAO dao = new BoardDAO();
        int result = dao.updateBoard(board);  // Update the post in the database

        String msg = "게시글 수정 성공!";
        if (result == 0) {
            msg = "[에러] 게시글 수정 실패";
        }
    %>

    <h2><%= msg %></h2>
    <p>제목: <%= title %></p>
    <p>작성자: <%= writer %></p>
    <p>내용: <%= content %></p>
    <a href="index.jsp" class="btn btn-primary">목록으로 돌아가기</a>

    <%@include file="inc/bottom.jsp"%>
</div>
</body>
</html>
