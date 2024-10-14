<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>招聘</title>
    <style>
        @font-face {
            font-family: "iconfont logo";
            src: url('https://at.alicdn.com/t/font_985780_km7mi63cihi.eot?t=1545807318834');
            src: url('https://at.alicdn.com/t/font_985780_km7mi63cihi.eot?t=1545807318834#iefix') format('embedded-opentype'),
            url('https://at.alicdn.com/t/font_985780_km7mi63cihi.woff?t=1545807318834') format('woff'),
            url('https://at.alicdn.com/t/font_985780_km7mi63cihi.ttf?t=1545807318834') format('truetype'),
            url('https://at.alicdn.com/t/font_985780_km7mi63cihi.svg?t=1545807318834#iconfont') format('svg');
        }
        .iconfont{
            font-family: "iconfont" !important;
            font-size: 16px;
            font-style: normal;
            color: #2d7bff;
        }
        .career-dot {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            overflow: hidden;
            border: none;
            background-color: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            margin-bottom: 10px; /* 添加外边距以避免按钮之间紧密贴合 */
        }
        .career-dot img {
            width: 120%;
            height: auto;
        }
        .career-dot p {
            color: #000000;
            font-size: 16px;
            margin-top: 100px;
        }
        #main {
            display: flex;
            width: 600px;
            flex-wrap: wrap; /* 允许换行 */
            justify-content: center; /* 水平居中 */
            margin-right: 25px;
        }
        h1 {
            margin: 0 0 20px; /* 可以调整h1标签的外边距 */
            text-align: center; /* 确保文本水平居中 */
        }
        h3{
            margin-left: 100px;
        }
        #content-wrapper {
            display: flex;
            justify-content: center; /* 水平居中 */
            width: 100%; /* 占满宽度 */
        }
        #main2 {
            position: relative; /* 允许绝对定位的子元素相对于它定位 */
            height: 600px;
            width: 600px;
            /* 其他样式保持不变 */
        }

        #jobApplicationForm {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgb(0, 101, 253);
        }

        #jobApplicationForm label,
        #jobApplicationForm input,
        #jobApplicationForm textarea,
        #jobApplicationForm select {
            width: 100%;
            margin-bottom: 10px;
        }

        #jobApplicationForm input,
        #jobApplicationForm select {
            padding: 10px;
            border: 1px solid #86d0f1;
            border-radius: 4px;
        }

        #jobApplicationForm textarea {
            resize: vertical;
            padding: 10px;
            border: 1px solid #86d0f1;
            border-radius: 4px;
        }

        #jobApplicationForm input[type="submit"],
        #jobApplicationForm input[type="reset"] {
            width: auto;
            padding: 10px 20px;
            margin-right: 10px;
            cursor: pointer;
            border: #0065fd;
            color: #86d0f1;
        }
        /* 其他样式... */

        #main2 {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 600px;
            height: 600px;
        }
        #greeting-content {
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('images/beijin2.jpg');
            background-size: cover; /* 使背景图片覆盖整个元素 */
            background-repeat: repeat; /* 背景图片不重复 */
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #close-form {
            position: absolute;
            top: 5px;
            right: 50px;
            z-index: 100;
        }
        #form-content {
            display: none; /* 初始时不显示表单 */
        }

        .close-icon {
            display: none; /* 初始时隐藏关闭按钮 */
        }
        #whole{
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                height: 100%;
                width: 100%;
        }
        body {
            background-image: url('images/beijin.png');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
    </style>
    <link rel="stylesheet" href="./fonts/fonts/iconfont.css">
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script type="text/javascript" src="canvasStar.js"></script>

</head>
<body>
<canvas id="canvas"></canvas>
<div id="whole">
    <div id="app">
        <el-carousel :interval="4000" type="card" height="300px">
            <el-carousel-item v-for="item in 4" :key="item">
                <img :src="getImageUrl(item)" style="width: 100%; height: 100%; object-fit: cover;">
            </el-carousel-item>
        </el-carousel>
    </div>
    <h1>您对那些职业感兴趣？</h1>
    <h3>请在下方点击查看您心仪的职位：</h3>
    <div id="content-wrapper">
        <div id="main">
            <button class="career-dot" id="second-panel-label1" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/paizhao.jpg"><br>

            </button>
            <button class="career-dot" id="second-panel-label2" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/baojie.jpg">
                <p>保洁</p>
            </button>
            <button class="career-dot" id="second-panel-label3" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="./images/anbao.jpg">
                <p>安保</p>
            </button>
            <button class="career-dot" id="second-panel-label4" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="./images/peiwan.png">
                <p>陪玩</p>
            </button>
            <button class="career-dot" id="second-panel-label5" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/renou.jpg">
                <p>人偶</p>
            </button>
            <button class="career-dot" id="second-panel-label6" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/sheshi.jpg">
                <p>设施维护</p>
            </button>
            <button class="career-dot" id="second-panel-label7" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/shoumai.jpg">
                <p>商品售卖</p>
            </button>
            <button class="career-dot" id="second-panel-label8" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/kefu.jpg">
                <p>客服</p>
            </button>
            <button class="career-dot" id="second-panel-label9" role="tab" aria-controls="second-panel" aria-expanded="false" aria-selected="false">
                <img alt="" src="images/jindian.jpg">
                <p>景点运营</p>
            </button>
        </div>
        <div id="main2" >
<%--            <img id="default-image" src="images/tiaotiaohu.png" style="width: auto; height: 600px;">--%>
<%--            <button id="close-form" style="position: absolute; top: 10px; right: 10px;">X</button>--%>
            <div id="form-content">
                <form id="jobApplicationForm" style="height: 600px;width: 500px" action="RecruitServlet" METHOD="post" accept-charset="UTF-8">
                    <label for="name" style="color: #2d7bff">您的姓名：</label>
                    <input type="text" id="name" name="name" required><br><br>

                    <label for="phone" style="color: #2d7bff">您的电话：</label>
                    <input type="tel" id="phone" name="phone" required><br><br>

                    <label for="email" style="color: #2d7bff">您的邮箱：</label>
                    <input type="email" id="email" name="email" required><br><br>

                    <label for="introduction" style="color: #2d7bff">自我介绍：</label>
                    <textarea id="introduction" name="introduction" rows="4" required></textarea><br><br>

                    <label for="position" style="color: #2d7bff">您的心仪职位：</label>
                    <select id="position" name="position">
                        <option value="" style="color: #2d7bff">请选择职位</option>
                        <option value="1" style="color: #2d7bff">跟拍摄影师</option>
                        <option value="2" style="color: #2d7bff">保安</option>
                        <option value="3" style="color: #2d7bff">保洁</option>
                        <option value="4" style="color: #2d7bff">客服</option>
                        <option value="5" style="color: #2d7bff">售卖员</option>
                        <option value="6" style="color: #2d7bff">设施维护员</option>
                        <option value="7" style="color: #2d7bff">景点运营员</option>
                        <option value="8" style="color: #2d7bff">私人导游</option>
                        <option value="9" style="color: #2d7bff">角色扮演者</option>
                    </select><br><br>

                    <input type="submit" value="提交" style="margin-left: 180px;color: #2d7bff">
                    <input type="reset" value="重置" style="color: #2d7bff">
                    <p style="color: #ff0700; text-align: center;">请确保电话或邮箱正确，我们将会尽快联系您！</p>
                </form>
                <div id="greeting-content" style="display: none; position: absolute;width: 540px; height: 640px;margin-left: 30px;margin-top: -20px">
                    <p id="carrer-name" style="font-size: 30px; color: #000000;left: 20px;top: 5px;right: 20px;margin-left: 20px;"></p>
                    <p id="greeting-text" style="font-size: 23px; color: #000000;left: 20px;top: 5px;right: 20px;margin-left: 20px"></p>
                    <p id="greeting-text2" style="font-size: 20px; color: #505050;left: 20px;top: 5px;right: 20px;margin-left: 20px"></p>
                    <p id="greeting-text3" style="font-size: 20px; color: #505050;left: 20px;top: 5px;right: 20px;margin-left: 20px"></p>
                    <p id="greeting-text4" style="font-size: 24px; color: #ff0700;left: 20px;top: 5px;right: 20px;margin-left: 20px"></p>
                </div>
                <span id="close-form" class="close-icon iconfont">&#xe622;</span>
            </div>

        </div>
    </div>

</div>
<script>
    new Vue({
        el: '#app',
        data() {
            return {
                images: [
                    'images/quan.jpg',
                    'images/quan2.jpg',
                    'images/quan3.jpg',
                    'images/quan4.jpg'
                ]
            };
        },
        methods: {
            getImageUrl(index) {
                return this.images[index - 1];
            }
        }
    });


    function showFormAndCloseIcon() {
        const formContent = document.getElementById('form-content');
        const closeForm = document.getElementById('close-form');
        formContent.style.display = 'block'; // 显示表单
        closeForm.style.display = 'none'; // 隐藏关闭按钮
    }
    // 隐藏表单和关闭按钮的函数
    function hideFormAndCloseIcon() {
        // const formContent = document.getElementById('form-content');
        const closeForm = document.getElementById('close-form');
        closeForm.style.display = 'inline'; // 显示关闭按钮

    }

    // 调用 showFormAndCloseIcon 函数来初始化页面
    showFormAndCloseIcon();

    document.addEventListener('DOMContentLoaded', function() {
        const buttons = document.querySelectorAll('#main .career-dot');
        const formContent = document.getElementById('form-content');
        const greetingContent = document.getElementById('greeting-content');
        const greetingText = document.getElementById('greeting-text');
        const greetingText2 = document.getElementById('greeting-text2');
        const greetingText3 = document.getElementById('greeting-text3');
        const greetingText4 = document.getElementById('greeting-text4');
        const careerName = document.getElementById('carrer-name');
        const closeForm = document.getElementById('close-form');

        buttons.forEach((button) => {
            button.addEventListener('click', function() {
                hideFormAndCloseIcon();
                const id=this.id;
                if(id=="second-panel-label1"){//跟拍摄影师
                    careerName.innerHTML="跟拍摄影师"
                    greetingText.innerHTML = '跟拍摄影师需要拥有专业的摄影技能和设备，能够捕捉高质量的照片和视频，记录下游客在乐园中的每一个精彩瞬间。';
                    greetingText2.innerHTML="要求：1.可以根据游客的需求，提供个性化的拍摄服务，比如特定的拍照地点、风格或者主题；"
                    greetingText3.innerHTML="     2.熟练使用PS对照片的后期编辑和处理，为游客提供更加完美的成片"
                    greetingText4.innerHTML="薪资：40000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label2"){//保洁工人
                    careerName.innerHTML="保洁"
                    greetingText.innerHTML = `迪士尼乐园中的每一位员工都是创造魔法的重要一员。现在，我们正在寻找热情、勤劳的保洁工人加入我们的队伍，一起为游客提供最干净、最安全的娱乐环境。`;
                    greetingText2.innerHTML="要求：1.负责乐园内指定区域的日常清洁和维护工作，确保所有公共区域和设施的清洁卫生达到最高标准。"
                    greetingText3.innerHTML="     2.与游客互动，提供友好、专业的服务。"
                    greetingText4.innerHTML="薪资：20000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label3"){//保安
                    careerName.innerHTML="保安"
                    greetingText.innerHTML = '成为乐园安全的守护者，一起保护游客的快乐。';
                    greetingText2.innerHTML="要求：1.监控乐园内的安全状况，预防和处理紧急事件,执行安全检查，确保游客和员工遵守安全规定。"
                    greetingText3.innerHTML="     2.与游客互动，提供必要的帮助和指引。"
                    greetingText4.innerHTML="薪资：20000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label4"){//陪玩
                    careerName.innerHTML="私人导游"
                    greetingText.innerHTML = ` 加入我们，成为游客魔法体验的私人向导`;
                    greetingText2.innerHTML="要求：1.作为游客的私人向导，陪同并协助他们在乐园中的活动,为游客提供个性化的游玩计划和建议，确保他们的时间得到最完美的安排。"
                    greetingText3.innerHTML="     2.解答游客咨询，提供乐园信息和游玩小贴士。确保游客的安全和满意度，及时响应他们的需求"
                    greetingText4.innerHTML="薪资：40000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label5"){//角色扮演者
                    careerName.innerHTML="角色扮演"
                    greetingText.innerHTML = `在迪士尼乐园，每个角色都是故事的核心。我们正在寻找充满活力、热爱表演的人偶角色扮演者，与我们一起创造难忘的魔法时刻。`;
                    greetingText2.innerHTML="要求：1.穿戴特制的迪士尼角色服装，进行角色扮演和互动。在乐园各区域与游客见面、合影，提供互动体验。"
                    greetingText3.innerHTML="     2.参与游行、表演和其他现场娱乐活动。维护角色的神秘性和魔法感，确保与角色性格相符的表现。"
                    greetingText4.innerHTML="薪资：50000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label6"){//设施维护员
                    careerName.innerHTML="设施维护"
                    greetingText.innerHTML = `在迪士尼乐园，我们的设施维护员是幕后英雄，确保乐园的每个角落都安全、运行顺畅。我们正在寻找细心、技术精湛的设施维护员，与我们一起守护这份魔法。`;
                    greetingText2.innerHTML="要求：1.定期检查乐园内的游乐设施和设备，确保它们安全、可靠。执行预防性维护和修复工作，减少故障风险。"
                    greetingText3.innerHTML="     2.快速响应紧急维护需求，进行现场故障排查和修复。记录维护活动和设备状态，确保符合乐园的安全标准。"
                    greetingText4.innerHTML="薪资：40000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label7"){//商店售卖员
                    careerName.innerHTML="商品售卖"
                    greetingText.innerHTML = `在迪士尼乐园，每一件商品和纪念品都是魔法的载体。我们正在寻找热情、友好的售卖员，与我们一起为游客创造难忘的购物体验。`;
                    greetingText2.innerHTML="要求：1.负责乐园内商品店和纪念品店的商品销售，向游客介绍和推荐商品，提供专业的购物建议。"
                    greetingText3.innerHTML="     2.维护店铺的整洁和商品的陈列。"
                    greetingText4.innerHTML="薪资：30000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label8"){//客服
                    careerName.innerHTML="客服"
                    greetingText.innerHTML = `在迪士尼乐园，我们的客服专员是创造和维护游客笑容的关键。我们正在寻找耐心、细心的客服专员，与我们一起确保每位游客都能享受到无忧无虑的乐园体验。`;
                    greetingText2.innerHTML="要求：1.负责接听游客电话咨询，提供及时、准确的信息和帮助。处理人员走失和物品丢失等紧急情况，确保快速有效的响应。"
                    greetingText3.innerHTML="     2.记录和跟踪游客反馈，确保所有问题都能得到妥善解决。与乐园其他部门紧密合作，提供无缝的游客服务体验。"
                    greetingText4.innerHTML="薪资：35000+"
                    greetingContent.style.display = 'block';
                }
                if(id=="second-panel-label9"){//景点运营员
                    careerName.innerHTML="景点运营"
                    greetingText.innerHTML = `在迪士尼乐园，我们的景点运营员是游客体验的心脏。我们正在寻找充满活力、热情洋溢的团队成员，与我们一同创造并维护这份魔法。`;
                    greetingText2.innerHTML="要求：1.作为游客的第一印象，热情地欢迎并引导他们参与游乐设施和景点。";
                    greetingText3.innerHTML="     2.操作游乐设施和相关设备，确保顺畅运行。解答游客咨询，提供乐园信息和游玩建议。";
                    greetingText4.innerHTML="薪资：35000+"
                }
            });
        });

        // 为关闭按钮添加事件监听器
        closeForm.addEventListener('click', function() {
            greetingContent.style.display = 'none';
            showFormAndCloseIcon();
        });
    });

</script>
</body>
</html>