package repository;

import java.sql.*;

import vo.GoodsImg;

public class GoodsImgDao {
	//  이미지 추가
	public int insertGoodsImg(Connection conn,  GoodsImg goodsImg) throws Exception {
		int row = 0;
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date)" 
				+"VALUES(?,?,?,?,NOW())";
		
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsImg.getGoodsNo());
		stmt.setString(2, goodsImg.getFileName());
		stmt.setString(3, goodsImg.getOriginFileName());
		stmt.setString(4, goodsImg.getContentType());
		// 디버깅
		System.out.println(stmt + "<-- GoodsImgDao insertGoodsImg stmt");
		row = stmt.executeUpdate();
		
		if(stmt != null) {
			stmt.close();
		}
		return row;
	}
	// 이미지 수정
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		int row = 0;
		String sql = "UPDATE goods_img SET filename = ?, origin_filename = ?, content_type = ? WHERE goods_no = ?";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goodsImg.getFileName());
			stmt.setString(2, goodsImg.getOriginFileName());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsNo());
			// 디버깅
			System.out.println(stmt + "<-- stmt");
			row = stmt.executeUpdate();
			if(row == 0) {
				throw new Exception(); // 예외처리
			}
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
