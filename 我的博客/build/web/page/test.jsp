<%-- 
    Document   : test
    Created on : 2017-5-29, 20:42:32
    Author     : lol
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.StringReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.linglian.github.Filelet"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (request.getParameter("test-markdown-doc") == null && request.getParameter("test-path") == null ) {
%> 
<jsp:include page="mdList.jsp" flush="true" />
<%
} else {
%>
<link rel="stylesheet" href="../css/editormd.preview.css" />
<style>            
    .editormd-html-preview {
        width: 97%;
        margin: 0 auto;
    }
    .editormd-html-preview {
        color: #ccc;
        background:#2C2827;
    }

    .editormd-html-preview .editormd-toc-menu > .markdown-toc {
        background:#fff;
        border:none;
    }

    .editormd-html-preview .editormd-toc-menu > .markdown-toc h1{
        border-color:#ddd;
    }

    .editormd-html-preview .markdown-body h1,
    .editormd-html-preview .markdown-body h2,
    .editormd-html-preview .markdown-body hr {
        border-color: #222;
    }

    .editormd-html-preview .editormd-preview-container  blockquote {
        color: #555;
        border-color: #333;
        background: #222;
        padding: 0.5em;
    }

    .editormd-html-preview .editormd-preview-container abbr {
        background:#ff9900;
        color: #fff;
        padding: 1px 3px;
        border-radius: 3px; 
    }

    .editormd-html-preview .editormd-preview-container code {
        background: #5A9600;
        color: #fff;
        border: none;
        padding: 1px 3px;
        border-radius: 3px; 
    }

    .editormd-html-preview .editormd-preview-container table {
        border: none;
    }

    .editormd-html-preview .editormd-preview-container .fa-emoji {
        color: #B4BF42;
    }

    .editormd-html-preview .editormd-preview-container .katex {
        color: #FEC93F;
    }

    .editormd-html-preview [class*=editormd-logo] {
        color: #2196F3;
    }

    .editormd-html-preview .sequence-diagram text {
        fill: #fff;
    }

    .editormd-html-preview .sequence-diagram rect, 
    .editormd-html-preview .sequence-diagram path {
        color:#fff;
        fill : #64D1CB;
        stroke : #64D1CB;
    }

    .editormd-html-preview .flowchart rect, 
    .editormd-html-preview .flowchart path {
        stroke : #A6C6FF;
    }

    .editormd-html-preview .flowchart rect {
        fill: #A6C6FF;
    }

    .editormd-html-preview .flowchart text {
        fill: #5879B4;
    }

</style>

<div>
    <div id="markdown-test" >
        <textarea id="append-test" style="display:none; color: black;">
            <%
                out.println();
                if (request.getParameter("test-markdown-doc") != null) {
                    out.println(request.getParameter("test-markdown-doc"));
                } else if (request.getParameter("test-path") != null) {
                    String path = request.getServletContext().getRealPath("") + "/text/" + request.getParameter("test-path");
                    System.out.println(path);
                    System.out.println("-----" + request.getParameter("test-path"));
                    File f = new File(path);
                    InputStreamReader in = new InputStreamReader(new FileInputStream(f), "UTF-8");
                    Filelet.io(in, out);
                    in.close();
                }
                //out.print(request.getParameter("test-html-code"));
            %>
        </textarea>
    </div>
</div>
<script src="js/jquery.min.js"></script>
<script src="../lib/marked.min.js"></script>
<script src="../lib/prettify.min.js"></script>

<script src="../lib/raphael.min.js"></script>
<script src="../lib/underscore.min.js"></script>
<script src="../lib/sequence-diagram.min.js"></script>
<script src="../lib/flowchart.min.js"></script>
<script src="../lib/jquery.flowchart.min.js"></script>

<script src="../editormd.js"></script>
<script type="text/javascript">
    $(function () {
        // You can custom Emoji's graphics files url path
        editormd.emoji = {
            path: "https://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/",
            ext: ".png"
        };

        // Twitter Emoji (Twemoji)  graphics files url path    
        editormd.twemoji = {
            path: "https://github.com/twitter/twemoji/tree/gh-pages/72x72/",
            ext: ".png"
        };
        editormd.markdownToHTML("markdown-test", {
            id: "markdown-test",
            //htmlDecode      : true,       // 开启 HTML 标签解析，为了安全性，默认不开启
            htmlDecode: "style,script,iframe", // you can filter tags decode
            //toc             : false,
            tocm: true, // Using [TOCM]
            emoji: true,
            theme: "dark",
            previewTheme: "dark",
            taskList: true,
            tex: true, // 默认不解析
            flowChart: true, // 默认不解析
            sequenceDiagram: true, // 默认不解析
        });

    });

</script>
<%
    }
%>