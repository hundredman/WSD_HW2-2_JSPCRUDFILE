function delete_item(id) {
    if (confirm("게시물을 삭제할까요?")) {
        location.href='delete_ok.jsp?id=' + id;
    } else {
        alert("게시물 삭제 취소.");
    }
}

function validateForm() {
    let title = document.getElementById("title").value;
    let content = document.getElementById("content").value;
    if (title === "" || content === "") {
        alert("모든 필드를 채워주세요.");
        return false;
    }
    return true;
}
