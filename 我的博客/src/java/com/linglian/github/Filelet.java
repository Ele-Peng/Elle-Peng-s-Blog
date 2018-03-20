package com.linglian.github;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/page/doDownload")
public class Filelet extends HttpServlet {

    private HttpServletRequest request;
    private HttpServletResponse response;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("path") != null) {
            String path = request.getParameter("path");
            this.request = request;
            this.response = response;
            download(path, request.getServletContext().getRealPath("") + "/text/" + path);
        }
    }

    /**
     *
     * @param fileName 指文件名，例如：fdfd.txt, qwqw.doc
     * @param absolutePath 指相对于系统磁盘的绝对路径
     * @return 是否下载完成
     */
    private void download(String fileName, String absolutePath) throws UnsupportedEncodingException, FileNotFoundException, IOException {
        response.setContentType("application/octet-stream; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(fileName.substring(fileName.lastIndexOf('/') + 1, fileName.length()), "UTF-8"));
        io(new FileInputStream(absolutePath), response.getOutputStream());
    }

    public static void io(Reader in, Writer out) throws IOException {
        char[] bt = new char[1024];
        int len;
        while ((len = in.read(bt)) !=  -1) {
            out.write(bt, 0, len);
        }
    }
    private void io(InputStream in, OutputStream out) throws IOException {
        byte[] bt = new byte[1024];
        int len;
        while ((len = in.read(bt)) != -1) {
            out.write(bt, 0, len);
        }
    }
}
