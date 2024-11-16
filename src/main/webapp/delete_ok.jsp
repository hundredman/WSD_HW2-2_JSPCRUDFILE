<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcruddb.dao.BoardDAO" %>

<html>
<head>
    <title>삭제 완료</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <%@ include file="inc/top.jsp"%>

    <%
        // 요청 파라미터에서 seq 값을 받아옴
        String seqParam = request.getParameter("id");

        if (seqParam != null) {
            try {
                int seq = Integer.parseInt(seqParam);  // id 값을 정수로 변환

                // BoardDAO 객체를 사용하여 삭제 기능 실행
                BoardDAO dao = new BoardDAO();
                dao.deleteBoard(seq);  // 해당 seq 값을 이용하여 게시글 삭제

                // 삭제 완료 메시지 출력
    %>
    <h2>글이 성공적으로 삭제되었습니다.</h2>
    <%
    } catch (NumberFormatException e) {
    %>
    <h2>잘못된 게시글 ID입니다.</h2>
    <%
        }
    } else {
    %>
    <h2>게시글 ID가 존재하지 않습니다.</h2>
    <%
        }
    %>

    <a href="index.jsp" class="btn btn-primary">목록으로 돌아가기</a>

    <%@ include file="inc/bottom.jsp"%>
</div>
</body>
</html>
