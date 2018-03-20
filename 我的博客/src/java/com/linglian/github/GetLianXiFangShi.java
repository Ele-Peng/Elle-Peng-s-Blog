package com.linglian.github;


import db.DBMan;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author lol
 */
public class GetLianXiFangShi {

    public static String get(String target) throws IOException {
        String str = GetLianXiFangShi.class.getResource("").toString();
        str = str.substring(str.indexOf("file:") + 6, str.indexOf("WEB-INF"));
        System.out.println(str);
        File f = new File(str + "text/联系方式.properties");
        InputStream in = new FileInputStream(f);
        Properties pro = new Properties();
        pro.load(in);
        return pro.getProperty(target);
    }
}
