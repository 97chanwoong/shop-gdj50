package repository;

import java.sql.*;

import vo.GoodsImg;

public class GoodsImgDao {
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
}
