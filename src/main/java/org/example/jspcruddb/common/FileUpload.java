package org.example.jspcruddb.common;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.example.jspcruddb.bean.BoardVO;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUpload {
    public BoardVO uploadFile(HttpServletRequest request) throws IOException {

        // 업로드 파일 크기 제한 설정 (15MB)
        int sizeLimit = 15 * 1024 * 1024;

        // 업로드 파일이 저장될 실제 경로 가져오기
        String realPath = request.getServletContext().getRealPath("upload");

        // 경로에 해당하는 디렉토리가 존재하지 않으면 생성
        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        // 게시글 데이터를 저장할 VO 객체 생성
        BoardVO vo = new BoardVO();
        try {
            // MultipartRequest 객체를 생성하여 파일 업로드 처리
            MultipartRequest multi = new MultipartRequest(
                    request,                    // 요청 객체
                    realPath,                   // 파일 저장 경로
                    sizeLimit,                  // 파일 크기 제한
                    "utf-8",                    // 인코딩 방식
                    new DefaultFileRenamePolicy() // 중복 파일명 처리 정책
            );

            // 사용자가 입력한 파라미터 값을 VO 객체에 설정
            vo.setTitle(multi.getParameter("title"));   // 게시글 제목
            vo.setWriter(multi.getParameter("writer")); // 작성자
            vo.setContent(multi.getParameter("content")); // 게시글 내용

            // 업로드된 새로운 파일 확인
            String newFile = multi.getFilesystemName("photo");

            if (newFile != null) {
                // 새 파일이 업로드된 경우 해당 파일명을 VO 객체에 설정
                vo.setFilename(newFile);
            } else {
                // 새 파일이 없으면 기존 파일명을 유지
                vo.setFilename(multi.getParameter("currentPhoto"));
            }

            // Hidden input으로 전달된 게시글 ID 값 설정
            vo.setSeq(Integer.parseInt(multi.getParameter("id")));
        } catch (Exception e) {
            // 파일 업로드 또는 데이터 처리 중 예외 발생 시 스택 트레이스 출력
            e.printStackTrace();
        }
        // 파일 업로드 처리 후 VO 객체 반환
        return vo;
    }
}
