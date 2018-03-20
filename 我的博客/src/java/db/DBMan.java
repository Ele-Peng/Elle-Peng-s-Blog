package db;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Properties;
import java.util.Set;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextField;

public class DBMan {

    private String drivers;
    private String url;
    private String user;
    private String passwd;

    private Connection conn;
    private PreparedStatement stmt;
    private ResultSet rs;

    private static DBMan instance;

    private DBMan() throws IOException {
        reload();
    }

    public void reload() throws IOException {
        InputStream in = DBMan.class.getResourceAsStream("./数据库链接信息.properties");
        Properties pro = new Properties();
        pro.load(in);
        drivers = pro.getProperty("drivers");
        url = pro.getProperty("url");
        user = pro.getProperty("user");
        passwd = pro.getProperty("passwd");
    }

    public static DBMan getInstance() throws IOException {
        if (instance == null) {
            instance = new DBMan();
        }
        return instance;
    }

    public void display(DBMap map, PrintStream out, String... str) {
        if (map == null) {
            return;
        }
        LinkedList[] q = new LinkedList[map.size()];
        int col = str.length;
        String temp = new String();
        // 打印表头，并决定要输出的数据是那些。
        if (col == 0) {
            Set<String> set = map.keySet();
            for (String s : set) {
                q[col++] = map.get(s);
                temp += s + "\t";
            }
        } else {
            for (int i = 0; i < col; i++) {
                q[i] = map.get(str[i]);
                temp += str[i] + "\t";
            }
        }
        int row = q[0].size();
        out.println(temp);
        for (int i = 0; i < row; i++) {
            temp = new String();
            for (int j = 0; j < col; j++) {
                temp += q[j].get(i) + "\t";
            }
            out.println(temp);
        }
    }

    public synchronized DBMap query(String sql, Object... obj) throws SQLException {
        DBMap map = new DBMap();
        open();
        stmt = conn.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            stmt.setObject(i + 1, obj[i]);
        }
        rs = stmt.executeQuery();
        LinkedList<String> list = new LinkedList();// 存储表头名称
        int col = rs.getMetaData().getColumnCount();// 获取列数
        // 根据表头名称建立键值对
        for (int i = 0; i < col; i++) {
            LinkedList<Object> tList = new LinkedList();
            list.add(rs.getMetaData().getColumnName(i + 1));
            map.put(list.getLast(), tList);
        }
        while (rs.next()) {
            for (int i = 0; i < col; i++) {
                LinkedList<Object> tList = map.get(list.get(i));
                tList.add(rs.getObject(i + 1));
            }
        }
        close();
        return map;
    }

    public synchronized boolean update(String sql, Object... obj) throws SQLException {
        open();
        stmt = conn.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            stmt.setObject(i + 1, obj[i]);
        }
        stmt.executeUpdate();
        close();
        return true;
    }

    private synchronized void open() {
        try {
            Class.forName(drivers);
        } catch (ClassNotFoundException e) {
            System.err.println(e.getMessage());
        }
        try {
            conn = DriverManager.getConnection(url, user, passwd);
            conn.setAutoCommit(true);
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
    }

    private synchronized void close() {
        try {
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
        }
    }
}
