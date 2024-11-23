package org.example.jspcruddb.bean;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class BoardVO {
    private int seq;
    private String title;
    private String writer;
    private String content;
    private Timestamp regdate;
    private Timestamp updatedate;
    private int cnt;
    private String filename;

    public BoardVO(String title, String writer, String content, String filename) {
        this.title = title;
        this.writer = writer;
        this.content = content;
        this.filename = filename;
    }
}