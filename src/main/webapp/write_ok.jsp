<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcruddb.dao.BoardDAO" %>
<%@ page import="org.example.jspcruddb.bean.BoardVO" %>
<%@ page import="org.example.jspcruddb.common.FileUpload" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <title>글 저장</title>
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
        try {
            FileUpload fileUpload = new FileUpload();
            BoardVO vo = fileUpload.uploadFile(request);

            BoardDAO dao = new BoardDAO();
            int result = dao.insertBoard(vo);

            msg = (result > 0) ? "데이터 추가 성공!" : "[에러] 데이터 추가 실패";

        } catch (Exception e) {
            e.printStackTrace();
            msg = "[에러] 처리 중 문제가 발생했습니다.";
        }
    %>

    <script>
        alert('<%= msg %>');
        location.href = 'index.jsp';
    </script>

    <%@include file="inc/bottom.jsp"%>
</div>
</body>
</html>
