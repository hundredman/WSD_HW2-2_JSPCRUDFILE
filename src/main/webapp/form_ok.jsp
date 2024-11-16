<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Form Submission Result</title>
</head>
<body>
<h2>입력하신 데이터</h2>
<p>이름: <%= request.getParameter("name") %></p>
<p>이메일: <%= request.getParameter("email") %></p>
<p>성별: <%= request.getParameter("gender") %></p>
<p>관심사: <%= request.getParameterValues("interest") != null ? String.join(", ", request.getParameterValues("interest")) : "없음" %></p>
<p>도시: <%= request.getParameter("city") %></p>

<a href="form.html">돌아가기</a>
</body>
</html>
