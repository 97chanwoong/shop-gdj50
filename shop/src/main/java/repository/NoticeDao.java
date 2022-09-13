package repository;

import java.sql.*;
import java.util.*;

import vo.Notice;

public class NoticeDao {
	
	// 공지사항 리스트
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		// 리턴값
		List<Notice> list = new ArrayList<Notice>();
		// 쿼리
		String sql = "SELECT  notice_no noticeNo,  notice_title noticeTitle, create_date createDate FROM notice ORDER BY create_date DESC LIMIT ?,?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println(stmt + "<-- selectNoticeList stmt");
			// 쿼리실행
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
	
	// 공지사항 total
		public int selectNoticeCount(Connection conn) throws Exception {
			// 리턴값
			int totalRow = 0;
			// 쿼리
			String sql = "SELECT COUNT(*) count FROM notice";
			// 초기화
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				// 쿼리담기
				stmt = conn.prepareStatement(sql);
				// 디버깅
				System.out.println(stmt + "<-- selectNoticeCount stmt");
				// 쿼리실행
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

	// 공지사항 상세보기
	public Map<String,Object> selectNoticeOne(Connection conn, int noticeNo) throws Exception {
		// 리턴값
		Map<String,Object> map = null;
		// 쿼리
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate, create_date createDate FROM notice WHERE notice_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			// 디버깅
			System.out.println(stmt + "<-- selectNoticeOne stmt");
			// 쿼리실행
			rs = stmt.executeQuery();
			if (rs.next()) {
				map = new HashMap<>();
				map.put("noticeNo", rs.getInt("noticeNo"));
				map.put("noticeTitle", rs.getString("noticeTitle"));
				map.put("noticeContent", rs.getString("noticeContent"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
			}
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return map;
	}
	
	// 공지사항 추가
	public int insertNotice(Connection conn, Notice notice) throws Exception {
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "INSERT INTO notice (notice_title, notice_content, update_date, create_date) VALUES (?, ?, NOW(), NOW())";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			// 디버깅
			System.out.println(stmt + "<-- insertNotice stmt");
			// 쿼리실행
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
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, update_date = NOW() WHERE  notice_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			stmt.setInt(3, notice.getNoticeNo());
			// 디버깅
			System.out.println(stmt + "<-- updateNotice stmt");
			// 쿼리실행
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
		// 리턴값
		int row = 0;
		// 쿼리
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		// 초기화
		PreparedStatement stmt = null;
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			// 디버깅
			System.out.println(stmt + "<-- deleteNotice stmt");
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

}
