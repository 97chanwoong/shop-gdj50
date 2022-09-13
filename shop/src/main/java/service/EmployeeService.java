package service;

import java.sql.*;
import java.util.*;

import repository.CustomerDao;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	private DBUtil dbutil;
	private EmployeeDao employeeDao;

	// 회원가입 addEmployeeAction.jsp 호출
	public boolean addEmployee(Employee paramEmployee) {
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.employeeDao = new EmployeeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- addEmployee conn");

			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			// 메서드 실행
			if (this.employeeDao.insertEmployee(conn, paramEmployee) != 1) {
				throw new Exception(); // 예외처리
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}

	// Employee 로그인
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		// 리턴값
		Employee employee = null;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.employeeDao = new EmployeeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getEmployeeByIdAndPw conn");
			// 메서드실행
			employee = this.employeeDao.selectEmployeeLoginByIdAndPw(conn, paramEmployee);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return employee;
	}

	// Employee 탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeEmployee(Employee paramEmployee) {
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.employeeDao = new EmployeeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- removeEmployee conn");

			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			if (this.employeeDao.deleteEmployee(conn, paramEmployee) != 1) { // 1)
				throw new Exception();
			}
			OutIdDao OutIdDao = new OutIdDao();
			if (OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
				throw new Exception();
			} // 2)

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			return false; // 탈퇴 실패
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true; // 탈퇴 성공
	}

	// 사원관리 리스트
	public List<Employee> getEmployeeList(final int rowPerPage, final int currentPage) {
		// 리턴값
		List<Employee> list = new ArrayList<Employee>();
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.employeeDao = new EmployeeDao();

		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getEmployeeList conn");

			// 자동 commit 해제
			conn.setAutoCommit(false);

			// 메서드실행
			list = this.employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);
			if (list == null) {
				throw new Exception(); // 예외처리
			}
			// 완료되었다면 commit
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 완료되지 않았다면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	// 사원관리리스트 라스트페이지 구하기
	public int getEmployeeLastPage(int rowPerPage) {
		// 리턴값
		int lastPage = 0;
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.employeeDao = new EmployeeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- getEmployeeLastPage conn");
			// 메서드실행
			int totalRow = this.employeeDao.selectEmployeeCount(conn);
			lastPage = (int) Math.ceil(totalRow / (double) rowPerPage);
			if (lastPage == 0) {
				throw new Exception(); // 예외처리
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 실패라면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lastPage;
	}

	// Employee 사원active 권한변경
	public boolean modifyEmployeeActiveById(String employeeId, String active) {
		// 초기화
		Connection conn = null;

		this.dbutil = new DBUtil();
		this.employeeDao = new EmployeeDao();

		try {
			conn = this.dbutil.getConnection();
			// 디버깅
			System.out.println(conn + "<-- modifyEmployeeActiveById conn");

			// 메서드실행
			if (this.employeeDao.updateEmployeeActiveById(conn, employeeId, active) != 1) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}

}
