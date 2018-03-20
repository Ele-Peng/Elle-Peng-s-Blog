<%-- 
    Document   : index
    Created on : 2017-5-29, 15:08:55
    Author     : lol
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.linglian.github.BlogDoc"%>
<%@page import="com.linglian.github.GetLianXiFangShi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="index.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="layui/css/layui.css" media="all">
        <link rel="stylesheet" href="css/layer.css">
        <title>Ele_Peng's Blog</title>
        <script src="js/jquery.min.js"></script>
        <script src="layer/layer.js"></script>
        <script>
            /*layer.msg('<hello~!', function () {
             //关闭后的操作
             });*/
        </script>
        <script>
            var mousePos;
            function sOrHi(str) {
                var target = document.getElementById(str);
                if (target.style.display == "block") {
                    target.style.display = "none";
                } else {
                    target.style.display = "block";
                }
            }
            // 开启悬浮窗
            function showDiv(str) {
                var div = document.getElementById("div");
                div.innerHTML = str;
                var w = 25;
                if (str.length < 25) {
                    w = str.length;
                }
                div.style.width = 18 * w + "px";
                div.style.height = (str.length / 25 + 1) * 15 + "px";
                div.style.top = mousePos.y + 5 + "px";
                div.style.left = mousePos.x + 15 + "px";
            }
            // 关闭悬浮窗
            function closeDiv() {
                var div = document.getElementById("div");
                div.innerHTML = "";
                div.style.width = 0;
                div.style.height = 0;
            }
            // 获得鼠标坐标
            function mouseMove(ev)
            {
                Ev = ev || window.event;
                mousePos = mouseCoords(ev);
            }
            function mouseCoords(ev)
            {
                if (ev.pageX || ev.pageY) {
                    return {x: ev.pageX, y: ev.pageY};
                }
                return{
                    x: ev.clientX + document.body.scrollLeft - document.body.clientLeft,
                    y: ev.clientY + document.body.scrollTop - document.body.clientTop
                };
            }
            document.onmousemove = mouseMove;</script>
            <%!String str = "网络连接失败", str2 = "网络连接失败";%>
            <%
                try {
                    str = GetLianXiFangShi.get("关于");
                    str2 = GetLianXiFangShi.get("联系方式");
                } catch (Exception ex) {
                    out.println("<script>alert(" + ex.getMessage() + ")</script>");
                }
            %>
    </head>
    <body>

        <div id="templatemo_menu_wrapper">
            <div id="templatemo_menu_panel">
                <ul>
                    <li><a href="index.jsp"  class="current">首页</a></li>
                    <li><a href="#">图片</a></li>
                    <li><a href="#">视频</a></li>
                    <li><a href="md.jsp">发表</a></li>  
                    <li><a href="#" onmousemove="showDiv('<%= str%>')" onmouseout="closeDiv()" >关于</a></li> 
                    <li><a href="#" onmousemove="showDiv('<%= str2%>')" onmouseout="closeDiv()" class="last">联系</a></li>                     
                </ul> 
            </div>
        </div>

        <div id="templatemo_header_wrapper">
            <div id="templatemo_header_panel">        
                <div class="templatemo_header"></div>        

                <div class="templatemo_header_right_section">
                    <div class="rss_twitter_section">
                        <div class="rss_twitter_box">
                            关注公众号 <img src="images/xyxd2.png" onmousemove="showDiv('<%= str%>')" onmouseout="closeDiv()" alt="向阳小队" />
                        </div>
                    </div>
                </div>

            </div> <!-- end of header panel -->
            <div class=" cleaner">&nbsp;</div>
        </div> <!-- end of header wrapper -->

        <div id="templatemo_content_panel">
            <div id="templatemo_content_wrapper">

                <div id="templatemo_content">

                    <div id="content_left">
                        <jsp:include page="test.jsp" flush="true" />
                    </div> <!-- end of content left -->

                    <div id="content_right">

                        <div class="ads_250_250">
                            <img src="images/touxiang.jpg"   onmousemove="showDiv('我最爱的蜡笔小新')" onmouseout="closeDiv()" alt="蜡笔小新" />
                        </div>

                        <div class="cleaner_h30">&nbsp;</div>

                        <div class="content_right_section">
                            <div class="content_right_titile_01">文件存档</div>
                            <jsp:include page="fileList.jsp" flush="true" />
                            <!-- 文章存档 -->
                        </div> 

                        <div class="cleaner_h30">&nbsp;</div>

                        <div class="content_right_section">
                            <div class="content_right_titile_01">最近图片</div>
                            <!-- 最近图片 -->
                            <%
                            
                            %>
                        </div>

                        <div class="cleaner_h30">&nbsp;</div>


                        <div class="cleaner">&nbsp;</div>
                    </div> <!-- end of content right -->           				
                    &nbsp;
                    <div class="cleaner">&nbsp;</div>        
                </div>    <!-- end of content -->

                <div id="templatemo_content_bottom">&nbsp;</div>
                <div class="cleaner">&nbsp;</div>
            </div> <!-- end of content wrapper -->
        </div> <!-- end of content panel -->





        <div id="div" style="font-size: 17px;position: absolute; buttom: 0px; right: 0px; color:  #cccccc; width: 0px; height: 0px; background-color: rgba(1,1,1, 0.25);"></div> 
        <form id="upload-form" action="updataFile.jsp" method="post" enctype="multipart/form-data">
　　　<input type="file" id="upload" name="upload"/> <br />
　　　<input type="submit" value="Upload" />
        </form>
    </body>
</html>

