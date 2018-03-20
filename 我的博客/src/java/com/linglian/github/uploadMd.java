/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.linglian.github;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lol
 */
@WebServlet("/uploadMd.do")
public class uploadMd extends HttpServlet {

    public static String getEncoding(String str) {
        String encode[] = new String[]{
            "UTF-8",
            "ISO-8859-1",
            "GB2312",
            "GBK",
            "GB18030",
            "Big5",
            "Unicode",
            "ASCII"
        };
        for (int i = 0; i < encode.length; i++) {
            try {
                if (str.equals(new String(str.getBytes(encode[i]), encode[i]))) {
                    return encode[i];
                }
            } catch (Exception ex) {
            }
        }

        return "";
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String str = req.getParameter("test-markdown-doc");
        str = new String(str.getBytes(getEncoding(str)), "UTF-8");
        if (str == null) {
            resp.sendRedirect(req.getSession().getServletContext().getContextPath() + "/index.jsp");
        } else {
            int end = str.indexOf('\n');
            if (end == -1) {
                end = str.length();
            }
            String title = str.substring(str.indexOf('#') + 1, end);
            title = title.trim();
            File file = new File(req.getSession().getServletContext().getRealPath("") + "/text/" + title + ".md");
            PrintWriter out = new PrintWriter(file, "UTF-8");
            out.print(str);
            out.close();
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }

}
