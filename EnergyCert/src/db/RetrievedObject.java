package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class RetrievedObject {
	private Connection conn;
	private Statement stmt;
	private ResultSet rs;

	public RetrievedObject(Connection c, Statement s, ResultSet r) {
		conn = c;
		stmt = s;
		rs = r;
	}

	public Connection getConnection() {
		return conn;
	}

	public void setConnection(Connection c) {
		conn = c;
	}

	public Statement getStatement() {
		return stmt;
	}

	public void setStatement(Statement s) {
		stmt = s;
	}

	public ResultSet getResultSet() {
		return rs;
	}

	public void setResultSet(ResultSet r) {
		rs = r;
	}

	public void close() {
		ConnectionManager.close(conn, stmt, rs);
	}
}
