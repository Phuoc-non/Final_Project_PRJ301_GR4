function validateLogin() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    // Xóa lỗi cũ
    const errorMsg = document.getElementById("error-msg");
    if (errorMsg) errorMsg.innerText = "";

    // Regex kiểm tra toàn khoảng trắng
    const onlySpaces = /^\s*$/;

    // Kiểm tra rỗng hoặc toàn space
    if (onlySpaces.test(username) && onlySpaces.test(password)) {
        showError("Username and Password cannot be empty!");
        return false;
    }
    if (onlySpaces.test(username)) {
        showError("Username cannot be empty or contain only spaces!");
        return false;
    }
    if (onlySpaces.test(password)) {
        showError("Password cannot be empty or contain only spaces!");
        return false;
    }

    // ❌ Kiểm tra thừa khoảng trắng ở đầu hoặc cuối
    if (username !== username.trim()) {
        showError("Username cannot start or end with spaces!");
        return false;
    }
    if (password !== password.trim()) {
        showError("Password cannot start or end with spaces!");
        return false;
    }

    // ✅ Nếu qua hết -> hợp lệ
    return true;
}

function showError(message) {
    let errorDiv = document.getElementById("error-msg");
    if (!errorDiv) {
        errorDiv = document.createElement("small");
        errorDiv.id = "error-msg";
        errorDiv.className = "text-danger d-block mb-2";
        const form = document.querySelector("form");
        const button = form.querySelector("button[type='submit']");
        form.insertBefore(errorDiv, button);
    }
    errorDiv.innerText = message;
}
