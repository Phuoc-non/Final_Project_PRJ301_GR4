<%-- 
    Document   : statistics
    Created on : Oct 31, 2025, 10:45:55 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/headerTotal.jsp" %>

<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Statistics Management</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">Home page</a></li>
                        <li class="tg-active">statistics</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>






<div class="container mt-4">
    <h2>Báo cáo thống kê</h2>

    <form method="get" action="${pageContext.request.contextPath}/statistics" class="mb-4">
        <label for="period">Kỳ báo cáo:</label>
        <select id="period" name="period" onchange="this.form.submit()">
            <option value="day" <c:if test="${period eq 'day'}">selected</c:if>>Theo ngày</option>
            <option value="month" <c:if test="${period eq 'month'}">selected</c:if>>Theo tháng</option>
            <option value="year" <c:if test="${period eq 'year'}">selected</c:if>>Theo năm</option>
            </select>
        </form>

        <div class="row">
            <div class="col-md-8">
                <h4>Tổng doanh thu</h4>
                <canvas id="chartRevenue"></canvas>
            </div>
            <div class="col-md-4">
                <h4>Sản phẩm bán chạy</h4>
                <canvas id="chartBestSeller"></canvas>
            </div>
        </div>
    </div>

    <script id="data-revenue" type="application/json">
    <c:out value="${revenueData}" escapeXml="false"/>
</script>
<script id="data-best" type="application/json">
    <c:out value="${bestSellerData}" escapeXml="false"/>
</script>

<script>
    function getJson(id) {
        const el = document.getElementById(id);
        return el ? JSON.parse(el.textContent.trim()) : null;
    }
    window.addEventListener('load', () => {
        const rev = getJson('data-revenue');
        const best = getJson('data-best');
        if (rev) {
            rev.datasets[0].backgroundColor = '#3498db';
            new Chart(document.getElementById('chartRevenue').getContext('2d'), {type: 'bar', data: rev});
        }
        if (best) {
            best.datasets[0].backgroundColor = ['#1abc9c', '#e67e22', '#9b59b6', '#f1c40f', '#e74c3c'];
            new Chart(document.getElementById('chartBestSeller').getContext('2d'), {type: 'doughnut', data: best});
        }
    });
</script>



<%@include file="/WEB-INF/includes/footer.jsp" %>
