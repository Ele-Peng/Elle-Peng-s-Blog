<%-- 
    Document   : fileList
    Created on : 2017-6-3, 18:57:41
    Author     : lol
--%>

<%@page import="com.linglian.github.BlogDoc"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>下载文件</title>
    </head>
    <body>
        <%!
            String Realpath;
        %>
        <%!
            void readDoc(JspWriter out, LinkedList list, String left) throws IOException {
                out.print("<ul id = 'text/" + left + "' ");
                if (!left.equals("")) {
                    out.print("style = 'display: none;'");
                }
                out.print(">");
                for (Object o : list) {
                    if (o instanceof String) {
                        out.println("<li style = 'list-style-type: circle;'><a href=doDownload?path=" + left + o.toString() + " target='_blank' >" + o.toString() + "</a></li>");
                    } else if (o instanceof LinkedList) {
                        LinkedList l = (LinkedList) o;
                        String s = (String) l.pop();
                        out.println("<li style = 'list-style-type: disc;' onClick=sOrHi('text/" + left + s + "/')><a style='color:yellow'>" + s + "(" + l.size() + ")</a></li>");
                        readDoc(out, l, left + s + "/");
                    }
                }
                out.println("</ul>");
            }
        %>
        <%
            Realpath = request.getServletContext().getRealPath("") + "/text";
            LinkedList list = BlogDoc.getAllFile(Realpath);
            readDoc(out, list, "");
        %>
    </body>
</html>
