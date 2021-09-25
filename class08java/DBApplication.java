package com.ddit401.Bus_login.Console;

import oracle.jdbc.pool.OracleDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.jdbc.datasource.embedded.DataSourceFactory;

import java.sql.SQLException;

public class DBApplication {
    private static MemberVO session = new MemberVO();
    private static JdbcTemplate template = new JdbcTemplate();

    public static MemberVO getSession() {
        return session;
    }
    public static JdbcTemplate getTemplate() {
        try {
            OracleDataSource dataSource = new OracleDataSource();
            dataSource.setURL("jdbc:oracle:thin:@112.220.114.130:1521:xe");
            dataSource.setUser("team5_20210809s");
            dataSource.setPassword("java");
            template.setDataSource(dataSource);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return template;
    }
}
