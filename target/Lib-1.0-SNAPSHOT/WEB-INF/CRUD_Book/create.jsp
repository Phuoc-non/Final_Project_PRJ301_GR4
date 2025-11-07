<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/headerTotal.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<div class="container mt-4">
    <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="tg-innerbannercontent">
                        <h1 style="margin-bottom: 20px;">Add Books</h1>
                        <ol class="tg-breadcrumb">
                            <li><a href="javascript:void(0);">Home Page</a></li>
                            <li class="tg-active">Book</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- FORM -->
    <form action="http://localhost:8080/Lib/bm" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="create"/>
        <div class="row">
            <!-- LEFT FORM -->
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Title</label>
                        <input type="text" class="form-control" name="title" required placeholder="Book Title">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Author</label>
                        <select class="form-select" name="author" required>
                            <option value="">-- Select Author --</option>
                            <c:forEach var="a" items="${authors}">
                                <option value="${a.name}">${a.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div> <br>

                <div class="mb-3">
                    <label class="form-label fw-semibold"><span style="color: red">*</span>Description</label>
                    <textarea class="form-control" name="description" rows="3" required placeholder="Enter description..."></textarea>
                </div><br>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Release Date</label>
                        <input type="text" class="form-control" name="created_date" required placeholder="dd-MM-yyyy">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Pages</label>
                        <input type="number" class="form-control" name="pages" required placeholder="0">
                    </div>
                </div> <br>

                <div class="row"> 
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Catalog</label>
                        <select class="form-select" name="catalog" required>
                            <option value="">-- Select Category --</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.name}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Book Code</label>
                        <input type="text" class="form-control" name="sku" 
                               value="${nextCode}" readonly required>
                    </div>

                </div> 

                <div class="row">  <br>
                    <div class="col-md-6 mb-3"> 
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Price</label>
                        <input type="number" class="form-control" name="price" step="0.1" required placeholder="Enter Price">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold"><span style="color: red">*</span>Quantity</label>
                        <input type="number" class="form-control" name="quantity" required placeholder="Enter Quantity">
                    </div>
                </div>
            </div> <!-- end col-md-8 -->

            <!-- RIGHT UPLOAD PANEL -->
            <div class="col-md-4 text-center">
                <button type="button" class="btn btn-success mb-2" onclick="document.getElementById('imageFile').click();">
                    Upload
                </button>
                <input type="file" id="imageFile" class="d-none" name="img" accept="image/*" onchange="previewImage(event)" required >

                <!-- Khung hiển thị ảnh -->
                <br>
                <div class="border d-flex align-items-center justify-content-center rounded-3"
                     style="width: 200px; height: 300px; margin: 0 auto; background-color: #f8f9fa;">
                    <img id="preview" src="#" alt="Preview"
                         style="max-width: 100%; max-height: 100%; display: none; object-fit: contain;">
                    <span id="placeholder" style="color: #888;">No image selected</span>
                </div>
            </div>
            <!-- end col-md-4 -->
        </div> <!-- end row -->

        <br>
        <div class="text-end mt-3">
            <button type="submit" class="btn btn-primary px-4">Add</button> 
        </div>
        <br><br>
    </form>


    <script>
        document.addEventListener("DOMContentLoaded", () => {

            // Hàm hiển thị lỗi màu đỏ dưới input
            function showError(input, message) {
                // Xóa lỗi cũ
                const oldError = input.parentElement.querySelector(".text-danger");
                if (oldError)
                    oldError.remove();

                // Tạo phần tử hiển thị lỗi
                const error = document.createElement("small");
                error.className = "text-danger";
                error.textContent = message;
                input.insertAdjacentElement("afterend", error);
            }

            // Hàm xóa lỗi khi nhập lại
            function clearError(input) {
                const oldError = input.parentElement.querySelector(".text-danger");
                if (oldError)
                    oldError.remove();
            }


            // Validate Title
            const titleInput = document.querySelector('input[name="title"]');
            titleInput.addEventListener('blur', function () {
                const regex = /^[A-Za-z]+(\.?[A-Za-z\s]+)*$/;
                const value = this.value.trim();

                if (value !== "" && !regex.test(value)) {
                    showError(this, "Title can only contain letters and dots (e.g., David or David.Cos)");
                    this.value = "";
                } else {
                    clearError(this);
                }
            });

            // Validate Release Date (dd-MM-yyyy)
            const dateInput = document.querySelector('input[name="created_date"]');
            dateInput.addEventListener('blur', function () {
                const regex = /^(\d{2})-(\d{2})-(\d{4})$/;
                const value = this.value.trim();

                if (value !== "" && !regex.test(value)) {
                    showError(this, "Please enter date in dd-MM-yyyy format (e.g., 01-11-2025)");
                    this.value = "";
                } else {
                    clearError(this);
                }
            });
        });
    </script>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            const preview = document.getElementById("preview");
            const placeholder = document.getElementById("placeholder");

            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = "block";
                    placeholder.style.display = "none";
                };
                reader.readAsDataURL(file); // đọc file ảnh để hiển thị trước
            } else {
                preview.src = "#";
                preview.style.display = "none";
                placeholder.style.display = "block";
            }
        }
    </script>


    <%@include file="../includes/footer.jsp"%>
