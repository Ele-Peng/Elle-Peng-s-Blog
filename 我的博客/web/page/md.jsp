<!DOCTYPE html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html lang="zh">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>在线编辑器</title>
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="../css/editormd.css" />  
        <link href="index.css" rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" href="css/layer.css">
        <link rel="stylesheet" href="layui/css//layui.css">

        <script>
            var mousePos;
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
            document.onmousemove = mouseMove;
        </script>
    </head>
    <body>
        <div id="layout">
            <header>
                <h1>markdown编辑器</h1>
            </header>
            <div class="btns">
                <button id="show-btn">显示编辑器</button>
                <button id="hide-btn">隐藏编辑器</button>
                <button id="get-md-btn">获得Markdown</button>
                <button id="get-html-btn">获得HTML</button>
                <button id="watch-btn">显示预览</button>
                <button id="unwatch-btn">关闭预览</button>
                <button id="preview-btn">转换为HTML显示</button>
                <button id="fullscreen-btn">全屏显示</button>
                <button id="show-toolbar-btn">显示横条</button>
                <button id="close-toolbar-btn">隐藏横条</button>
                <button id="shangchuan">保存上传</button>
            </div>
            <div id="test-editormd"></div>
        </div>
        <script src="js/jquery.min.js"></script>
        <script src="layer/layer.js"></script>
        <script src="layui/layui.js"></script>
        <script src="../editormd.js"></script>   
        <script type="text/javascript">
            var testEditor;

            $(function () {

                $.get('test.md', function (md) {
                    testEditor = editormd("test", {
                        width: "90%",
                        height: 740,
                        path: '../lib/',
                        theme: "dark",
                        previewTheme: "dark",
                        editorTheme: "pastel-on-dark",
                        markdown: md,
                        codeFold: true,
                        //syncScrolling : false,
                        saveHTMLToTextarea: true, // 保存 HTML 到 Textarea
                        searchReplace: true,
                        //watch : false,                // 关闭实时预览
                        htmlDecode: "style,script,iframe|on*", // 开启 HTML 标签解析，为了安全性，默认不开启    
                        //toolbar  : false,             //关闭工具栏
                        //previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
                        emoji: true,
                        taskList: true,
                        tocm: true, // Using [TOCM]
                        tex: true, // 开启科学公式TeX语言支持，默认关闭
                        flowChart: true, // 开启流程图支持，默认关闭
                        sequenceDiagram: true, // 开启时序/序列图支持，默认关闭,
                        //dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
                        //dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
                        //dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
                        //dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
                        //dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff
                        imageUpload: true,
                        imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
                        imageUploadURL: "./php/upload.php",
                        onload: function () {
                            console.log('onload', this);
                            //this.fullscreen();
                            //this.unwatch();
                            //this.watch().fullscreen();

                            //this.setMarkdown("#PHP");
                            //this.width("100%");
                            //this.height(480);
                            //this.resize("100%", 640);
                        }
                    });
                });


                $("#show-btn").bind('click', function () {
                    testEditor.show();
                });

                $("#hide-btn").bind('click', function () {
                    testEditor.hide();
                });

                $("#get-md-btn").bind('click', function () {
                    showDiv(testEditor.getMarkdown());
                });

                $("#get-html-btn").bind('click', function () {
                    alert(testEditor.getHTML());
                });

                $("#watch-btn").bind('click', function () {
                    testEditor.watch();
                });

                $("#unwatch-btn").bind('click', function () {
                    testEditor.unwatch();
                });

                $("#preview-btn").bind('click', function () {
                    testEditor.previewing();
                });

                $("#fullscreen-btn").bind('click', function () {
                    testEditor.fullscreen();
                });

                $("#show-toolbar-btn").bind('click', function () {
                    testEditor.showToolbar();
                });

                $("#close-toolbar-btn").bind('click', function () {
                    testEditor.hideToolbar();
                });
                $("#shangchuan").bind('click', function () {
                    /*
                    layer.open({
                        title: 
                        type: 2,
                        area: ['100%', '100%'],
                        content: './index.jsp' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    });*/
                    layer.confirm('你是否确认提交这片文章', {
                        title: '',
                        align: 'center',
                        btn: ['确认', '取消'] //按钮
                    }, function () {
                        document.mdForm.submit();
                    }, function () {
                    });
                });
                /*
                 $("#toc-menu-btn").click(function () {
                 testEditor.config({
                 tocDropdown: true,
                 tocTitle: "目录 Table of Contents",
                 });
                 });
                 
                 $("#toc-default-btn").click(function () {
                 testEditor.config("tocDropdown", false);
                 });
                 */
            });
        </script>

        <form name = "mdForm" action = "../uploadMd.do" method = "POST">
            <div id="test">
                <textarea style="display:none;">
                    
                </textarea>
            </div>
        </form>


        <div id="div" style="font-size: 17px;position: absolute; buttom: 0px; right: 0px; color:  #cccccc; width: 0px; height: 0px; background-color: rgba(1,1,1, 0.25);"></div> 

    </body>
</html>