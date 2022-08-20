package repository;

import java.sql.*;
import java.util.*;

import vo.Notice;

public class NoticeDao {
	// 공지사항 추가
	public int insertNotice(Connection conn, Notice notice) throws Exception {
		// 리턴할 변수 선언
		int row = 0;
		// DB자원
		String sql = "INSERT INTO notice (notice_title, notice_content, update_date, create_date) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			// 디버깅
			System.out.println(stmt + "<-- insertNotice stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 공지사항 수정
	public int updateNotice(Connection conn, Notice notice) throws Exception {
		// 리턴할 변수 선언
		int row = 0;
		// DB자원
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ? WHERE  notice_no = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			stmt.setInt(3, notice.getNoticeNo());
			// 디버깅
			System.out.println(stmt + "<-- updateNotice stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 공지사항 삭제
	public int deleteNotice(Connection conn, int noticeNo) throws Exception {
		// 리턴할 변수 선언
		int row = 0;
		// DB자원
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			// 디버깅
			System.out.println(stmt + "<-- updateNotice stmt");
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 공지사항 total
	public int selectNoticeCount(Connection conn) throws Exception {
		// 리턴할 변수 선언
		int totalRow = 0;
		// DB 자원
		String sql = "SELECT COUNT(*) count FROM notice";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if (rs.next()) {
				totalRow = rs.getInt("count");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalRow;
	}

	// 공지사항 리스트
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// List 객체 생성
		List<Notice> list = new ArrayList<Notice>();
		// DB 자원
		String sql = "SELECT  notice_no noticeNo,  notice_title noticeTitle, create_date createDate FROM notice ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectNoticeList stmt");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Notice nt = new Notice();
				nt.setNoticeNo(rs.getInt("noticeNo"));
				nt.setNoticeTitle(rs.getString("noticeTitle"));
				nt.setCreateDate(rs.getString("createDate"));
				list.add(nt);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// 공지사항 상세보기
	public Notice selectNoticeOne(Connection conn, int noticeNo) throws Exception {
		// 리턴할 객체 생성
		Notice notice = new Notice();
		// DB 자원
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate, create_date createDate FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			// 디버깅
			System.out.println(stmt + "<-- selectNoticeOne stmt");
			rs = stmt.executeQuery();
			if (rs.next()) {
				notice.setNoticeNo(rs.getInt("noiceNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setUpdateDate(rs.getString("updateDate"));
				notice.setCreateDate(rs.getString("createDate"));
			}
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return notice;
	}

}
