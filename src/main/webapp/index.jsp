<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.jspcruddb.dao.BoardDAO" %>
<%@ page import="org.example.jspcruddb.bean.BoardVO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <!-- Header -->
    <%@include file="inc/top.jsp" %>

    <!-- nav bar -->
    <nav class="navbar navbar-expand-md navbar-light rounded m-3">
        <a class="navbar-brand" href="#">자유게시판</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09"
                aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExample09">
            <form class="d-flex my-2 my-md-0" method="get" action="index.jsp">
                <select class="custom-select d-block rounded-pill me-2 p-2 border-gray-custom" name="searchBy"
                        required="">
                    <option value="">Search by ...</option>
                    <option value="title">Title</option>
                    <option value="writer">Writer</option>
                </select>


                <input class="form-control bd-round-left" type="text" name="search" aria-label="Search">
                <button class="btn btn-primary me-1 bd-round-right" type="submit">Search</button>
            </form>


            <a class='btn btn-primary rounded-pill' href='write.jsp' role='button'>Add</a>
        </div>
    </nav>

    <!-- Product list -->
    <div class="table-responsive small m-2 rounded" id="list">
        <table class="table table-sm">
            <thead>
            <tr class="table-primary">
                <th scope="col" class="text-center">#</th>
                <th scope="col">title</th>
                <th scope="col">writer</th>
                <th scope="col">hit</th>
                <th scope="col">created_date</th>
                <th scope="col">edited_date</th>
                <th scope="col">Menu</th>
            </tr>
            </thead>
            <tbody>
            <%
                String search = request.getParameter("search");
                String searchBy = request.getParameter("searchBy");

                BoardDAO dao = new BoardDAO();
                List<BoardVO> boardList;

                if (search != null && !search.trim().isEmpty()) {
                    boardList = dao.searchBoardList(search, searchBy);
                } else {
                    boardList = dao.getBoardList();
                }

                for (BoardVO board : boardList) {
            %>
            <tr>
                <td class="text-center"><%= board.getSeq() %>
                </td>
                <td><a class='nav-link text-body' href='view.jsp?id=<%= board.getSeq() %>'><%= board.getTitle() %>
                </a></td>
                <td><%= board.getWriter() %>
                </td>
                <td><%= board.getCnt() %>
                </td>
                <td><%= board.getRegdate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(board.getRegdate()) : "N/A" %>
                </td>
                <td><%= board.getUpdatedate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(board.getUpdatedate()) : "N/A" %>
                </td>
                <td>
                    <div class="d-flex">
                        <a class='text-dark' href='edit.jsp?id=<%= board.getSeq() %>'>
                            <i class="bi bi-pencil-square me-2 fs-6"></i>
                        </a>
                        <span><i onclick="delete_item(<%= board.getSeq() %>)"
                                 class="bi bi-trash fs-6 cursor-pointer"></i></span>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <a href="write.jsp" class="btn btn-primary">새 글 쓰기</a>

    <!-- list page button -->
    <div class="row justify-content-center">
        <div class="col-auto mb-5    M">
            <div class="btn-group btn-group-sm border" role="group" aria-label="First group">
                <button type="button" class="btn">&#60;</button>
                <button type="button" class="btn">1</button>
                <button type="button" class="btn fw-bold"><a class='text-body' href='index.jsp'>2</a></button>
                <button type="button" class="btn">&#62;</button>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@include file="inc/bottom.jsp" %>

    <script src="js/script.js"></script>
</div>
</body>
</html>
