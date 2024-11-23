package org.example.jspcruddb.dao;

import org.example.jspcruddb.bean.BoardVO;
import org.example.jspcruddb.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    private final String BOARD_INSERT = "insert into BOARD (title, writer, content, filename) values (?, ?, ?, ?)";
    private final String BOARD_UPDATE = "update BOARD set title = ?, writer = ?, content = ?, filename = ? where seq = ?";
    private final String BOARD_DELETE = "delete from BOARD where seq = ?";
    private final String BOARD_GET = "select * from BOARD where seq = ?";
    private final String BOARD_LIST = "select * from BOARD order by seq desc";
    private final String COUNT_UPDATE = "update BOARD set cnt = cnt + 1 where seq = ?";

    public int insertBoard(BoardVO vo) {
        System.out.println("===> JCBC로 insertBoard() 기능 처리");
        int result = 0;
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(BOARD_INSERT);
            ps.setString(1, vo.getTitle());
            ps.setString(2, vo.getWriter());
            ps.setString(3, vo.getContent());
            ps.setString(4, vo.getFilename());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public int updateBoard(BoardVO vo) {
        System.out.println("===> JCBC로 updateBoard() 기능 처리");
        int result = 0;
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(BOARD_UPDATE);
            ps.setString(1, vo.getTitle());
            ps.setString(2, vo.getWriter());
            ps.setString(3, vo.getContent());
            ps.setString(4, vo.getFilename());
            ps.setInt(5, vo.getSeq());
            result = ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return result;
    }

    public void deleteBoard(int seq) {
        System.out.println("===> JCBC로 deleteBoard() 기능 처리");
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(BOARD_DELETE);
            ps.setInt(1, seq);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public BoardVO getBoard(int seq) {
        BoardVO vo = new BoardVO();
        System.out.println("===> JCBC로 getBoard() 기능 처리");
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(BOARD_GET);
            ps.setInt(1, seq);
            rs = ps.executeQuery();
            if (rs.next()) {
                vo.setSeq(rs.getInt("seq"));
                vo.setTitle(rs.getString("title"));
                vo.setWriter(rs.getString("writer"));
                vo.setContent(rs.getString("content"));
                vo.setFilename(rs.getString("filename"));
                vo.setCnt(rs.getInt("cnt"));
            }
            rs.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return vo;
    }

    public List<BoardVO> getBoardList() {
        List<BoardVO> list = new ArrayList<>();
        System.out.println("===> JCBC로 getBoardList() 기능 처리");
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(BOARD_LIST);
            rs = ps.executeQuery();
            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setSeq(rs.getInt("seq"));
                vo.setTitle(rs.getString("title"));
                vo.setWriter(rs.getString("writer"));
                vo.setContent(rs.getString("content"));
                vo.setCnt(rs.getInt("cnt"));
                vo.setRegdate(rs.getTimestamp("regdate"));
                vo.setUpdatedate(rs.getTimestamp("updatedate"));
                vo.setFilename(rs.getString("filename"));
                list.add(vo);
            }
            rs.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<BoardVO> searchBoardList(String search, String searchBy) {
        List<BoardVO> list = new ArrayList<>();
        String sql = "SELECT * FROM BOARD WHERE ";

        if ("title".equals(searchBy)) {
            sql += "title LIKE ?";
        } else if ("writer".equals(searchBy)) {
            sql += "writer LIKE ?";
        } else {
            sql += "title LIKE ? OR writer LIKE ?";
        }
        sql += " ORDER BY seq DESC"; // 최신순으로 정렬

        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");

            if ("title".equals(searchBy) || "writer".equals(searchBy)) {
                // 단일 검색 기준
                ps.setString(1, "%" + search + "%");
            } else {
                // 제목 또는 내용에서 검색
                ps.setString(2, "%" + search + "%");
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setSeq(rs.getInt("seq"));
                vo.setTitle(rs.getString("title"));
                vo.setWriter(rs.getString("writer"));
                vo.setContent(rs.getString("content"));
                vo.setCnt(rs.getInt("cnt"));
                vo.setRegdate(rs.getTimestamp("regdate"));
                vo.setUpdatedate(rs.getTimestamp("updatedate"));
                vo.setFilename(rs.getString("filename"));
                list.add(vo);
            }
            rs.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<BoardVO> getBoardList(String orderBy) {
        List<BoardVO> list = new ArrayList<>();
        String sql = "SELECT * FROM BOARD";

        if (orderBy != null && !orderBy.trim().isEmpty()) {
            if (orderBy.equals("title")) {
                sql += " ORDER BY title";
            } else if (orderBy.equals("regdate")) {
                sql += " ORDER BY regdate DESC";
            }
        }

        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setSeq(rs.getInt("seq"));
                vo.setTitle(rs.getString("title"));
                vo.setWriter(rs.getString("writer"));
                vo.setContent(rs.getString("content"));
                vo.setCnt(rs.getInt("cnt"));
                vo.setRegdate(rs.getTimestamp("regdate"));
                vo.setUpdatedate(rs.getTimestamp("updatedate"));
                vo.setFilename(rs.getString("filename"));
                list.add(vo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 조회수 증가 메서드
    public void incrementHit(int seq) {
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement(COUNT_UPDATE);

            ps.setInt(1, seq);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
