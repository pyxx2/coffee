<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加商品</title>
    <link href="//unpkg.com/layui@2.9.18/dist/css/layui.css" rel="stylesheet">
</head>
<body>


<div class="form-container">
    <form class="layui-form layui-form-pane" action="AddGoodsServlet" method="POST" enctype="multipart/form-data">
        <div class="layui-form-item">
            <label class="layui-form-label">商品名称</label>
            <div class="layui-input-block">
                <input type="text" name="goodsname" autocomplete="off" placeholder="请输入商品名称" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">价格</label>
            <div class="layui-input-block">
                <input type="text" name="price" autocomplete="off" placeholder="请输入价格" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">库存数量</label>
            <div class="layui-input-block">
                <input type="number" name="num" autocomplete="off" placeholder="请输入库存数量" lay-verify="required" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">商品图片上传</label>
            <div class="layui-input-block">
                <button type="button" class="layui-btn" id="ID-upload-demo-btn">
                    <i class="layui-icon layui-icon-upload"></i> 单图片上传
                </button>
                <div style="width: 132px;">
                    <div class="layui-upload-list">
                        <img class="layui-upload-img" id="ID-upload-demo-img" style="width: 100%; height: 92px;">
                        <div id="ID-upload-demo-text"></div>
                    </div>
                    <input type="hidden" name="image" id="uploadedImagePath">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">商品描述</label>
            <div class="layui-input-block">
                <textarea name="message" placeholder="请输入商品描述" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn" lay-submit lay-filter="demo2">确认添加</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>

</div>

<script src="//unpkg.com/layui@2.9.18/dist/layui.js"></script>
<script>
    layui.use(function(){
        var upload = layui.upload;
        var layer = layui.layer;
        var element = layui.element;
        var $ = layui.$;

        // 单图片上传
        var uploadInst = upload.render({
            elem: '#ID-upload-demo-btn',
            url: 'UploadImageServlet', // 改成你的上传接口
            before: function(obj){
                // 预读本地文件
                obj.preview(function(index, file, result){
                    $('#ID-upload-demo-img').attr('src', result); // 显示图片
                });

                element.progress('filter-demo', '0%'); // 进度条复位
                layer.msg('上传中', {icon: 16, time: 0});
            },
            done: function(res){
                // 解析JSON响应并检查是否成功
                if(res.code === 0){ // code为0表示上传成功
                    $('#uploadedImagePath').val(res.data.src); // 保存图片路径到隐藏字段
                    layer.msg('上传成功');
                } else {
                    layer.msg('上传失败: ' + res.message);
                }
            },
            error: function(){
                var demoText = $('#ID-upload-demo-text');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            },
            progress: function(n, elem, e){
                element.progress('filter-demo', n + '%'); // 进度条更新
                if(n === 100){
                    layer.msg('上传完毕', {icon: 1});
                }
            }
        });
    });

</script>

</body>
</html>
