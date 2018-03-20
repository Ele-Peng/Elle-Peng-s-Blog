<%-- 
    Document   : fileList
    Created on : 2017-6-3, 18:57:41
    Author     : lol
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.linglian.github.uploadMd"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.linglian.github.BlogDoc"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>文档</title>
    </head>
    <body>
        <%!
            String Realpath;
            String data;
            HttpServletRequest req;
            HttpServletResponse res;
        %>
        <%!
            void readDoc(JspWriter out, LinkedList list, String left) throws IOException {
                for (Object o : list) {
                    if (o instanceof String) {
                        String path = Realpath + "\\" + left + o.toString();
                        File file = new File(path);
                        data = "";
                        Scanner in = new Scanner(new FileInputStream(file), "UTF-8");
                        for (int i = 0; i < 5 && in.hasNextLine(); i++) {
                            String str = in.nextLine();
                            str = str.replaceAll("[#`]*", "");
                            if (i != 0 && str.length() != 0) {
                                data += str + "<br>";
                            } else if (str.length() == 0) {
                                i--;
                            }
                        }
                        data = data.replaceAll("[#`]*", "");
                        in.close();
                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        out.println("<div class='post_section'><div class='post_header'><div class='post_title_info'><div class='post_title'>");
                        out.println(o.toString().substring(0, o.toString().lastIndexOf('.')) + "</div><div class='post_info'>"); // 标题
                        out.println(format.format(file.lastModified()) + "</div></div>"); // 时间
                        out.println("</div>"); // 点击次数
                        out.println("<div class='post_content'>");
                        out.println("<p>");
                        out.println(data);
                        out.println("</p>");
                        out.println("<div class='link_button'><a href='");
                        out.println("?test-path=" + left +  o.toString()); // 全文链接
                        out.println("' >阅读全文</a></div></div></div><div class='cleaner'>&nbsp;</div><div class='cleaner'>&nbsp;</div>");
                    } else if (o instanceof LinkedList) {
                        LinkedList l = (LinkedList) o;
                        String s = (String) l.pop();
                        readDoc(out, l, left + s + "/");
                    }
                }
            }
        %>
        <%
            req = request;
            res = response;
            Realpath = request.getServletContext().getRealPath("") + "/text";
            LinkedList list = BlogDoc.getAllMd(Realpath);
            readDoc(out, list, "");
        %>
    </body>
</html>
