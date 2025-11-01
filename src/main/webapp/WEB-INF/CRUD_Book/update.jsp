<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/headerTotal.jsp" %>

<div class="container mt-4">
    <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
         data-z-index="-100"
         data-appear-top-offset="600"
         data-parallax="scroll"
         data-image-src="../images/parallax/bgparallax-07.jpg">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="tg-innerbannercontent">
                        <h1 style="margin-bottom: 20px;">Book Update</h1>
                        <ol class="tg-breadcrumb">
                            <li><a href="${pageContext.request.contextPath}/bm">Home Page</a></li>
                            <li class="tg-active">Book update</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3">${error}</div>
    </c:if>

    <% Product p = (Product) request.getAttribute("product");%>

    <form action="<%= request.getContextPath()%>/bm" method="post" enctype="multipart/form-data" onsubmit="return confirmUpdate();">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="oldImg" value="<%= p.getImg()%>">
        <input type="hidden" name="sku" value="<%= p.getSku_product()%>">

        <div class="row mt-4">
            <!-- LEFT FORM -->
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Title</label>
                        <input type="text" class="form-control" name="title" value="<%= p.getName_product()%>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Author</label>
                        <select class="form-select" name="author" required>
                            <c:forEach var="a" items="${authors}">
                                <option value="${a.name}" ${a.name == p.getAuthor_name() ? "selected" : ""}>${a.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div> <br>

                <div class="mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Description</label>
                    <textarea class="form-control" name="description" rows="4" required><%= p.getDescription_product()%></textarea>
                </div> <br>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Release Date</label>
                        <input type="text" class="form-control" name="created_date" value="<%= p.getCreated_product()%>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Pages</label>
                        <input type="number" class="form-control" name="pages" value="<%= p.getPages()%>" required>
                    </div>
                </div> <br>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Catalog</label>
                        <select class="form-select" name="catalog" required>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.name}" ${c.name == p.getCategory_name() ? "selected" : ""}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Book Code</label>
                        <input type="text" class="form-control" name="sku" value="<%= p.getSku_product()%>" required>
                    </div>
                </div> <br>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color:red">*</span>Price</label>
                        <input type="number" step="0.01" class="form-control" name="price" value="<%= p.getPrice_product()%>" required>
                    </div>
                </div> <br>
            </div> <br>

            <!-- RIGHT UPLOAD PANEL -->
            <div class="col-md-4 text-center">
                <label for="imageFile" class="btn btn-success mb-2" style="cursor:pointer;">
                    Upload New Image
                </label>
                <input type="file" id="imageFile" name="img" accept="image/*" onchange="previewImage(event)" style="display:none;">


                <div class="border d-flex align-items-center justify-content-center rounded-3"
                     style="width: 200px; height: 300px; margin: 0 auto; background-color: #f8f9fa;">
                    <%
                        String imgPath = p.getImg();
                        if (imgPath != null && !imgPath.trim().isEmpty()) {
                    %>
                    <img id="preview"
                         src="<%= imgPath.startsWith("http") ? imgPath : (request.getContextPath() + "/images/" + imgPath)%>"
                         alt="Current Image"
                         style="max-width:100%; max-height:100%; object-fit:contain;">
                    <%
                    } else {
                    %>
                    <span id="placeholder" style="color: #888;">No image selected</span>
                    <img id="preview" src="#" alt="Preview" style="display:none;">
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <div class="text-end mt-4">
            <button type="submit" class="btn btn-primary">Complete</button>
        </div> <br>
    </form> <br>

</div>

<script>
    function confirmUpdate() {
        return confirm("Bạn có chắc chắn muốn thay đổi không?");
    }

    // Hiển thị ảnh preview ngay sau khi chọn file
    function previewImage(event) {
        const img = document.getElementById('preview');
        const file = event.target.files[0];
        if (file) {
            img.src = URL.createObjectURL(file);
            img.style.display = 'block';
        } else {
            img.src = "#";
            img.style.display = 'none';
        }
    }

    // Validate Book Code
    const skuInput = document.querySelector('input[name="sku"]');
    skuInput.addEventListener('blur', function () {
        const regex = /^book\d{2}$/i;
        let value = skuInput.value.trim();
        if (value !== "" && !regex.test(value)) {
            alert("❌ Book Code must be in the format: BOOK + 2 digits (e.g., BOOK01)");
            skuInput.value = "";
            skuInput.focus();
        } else if (value !== "") {
            skuInput.value = value.toUpperCase();
        }
    });

    // Validate Title
    const titleInput = document.querySelector('input[name="title"]');
    titleInput.addEventListener('input', function () {
        this.value = this.value.replace(/[^a-zA-Z.\s]/g, '');
    });
    titleInput.addEventListener('blur', function () {
        const regex = /^[A-Za-z]+(\.?[A-Za-z\s]+)*$/;
        const value = this.value.trim();
        if (value !== "" && !regex.test(value)) {
            alert("Title can only contain letters and dots (e.g., David or David.Cos)");
            this.value = "";
            this.focus();
        }
    });

    // Validate Date
    const inputDate = document.querySelector('input[name="created_date"]');
    inputDate.addEventListener('blur', function () {
        const regex = /^(\d{2})-(\d{2})-(\d{4})$/;
        if (this.value.trim() !== "" && !regex.test(this.value.trim())) {
            alert("Please enter date in dd-MM-yyyy format!");
            this.value = "";
            this.focus();
        }
    });
</script>

<%@include file="../includes/footer.jsp"%>
