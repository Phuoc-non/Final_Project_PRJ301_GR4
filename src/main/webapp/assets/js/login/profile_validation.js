document.addEventListener('DOMContentLoaded', function () {
    // Inputs
    const fullName = document.querySelector('#full_name');
    const email = document.querySelector('#email');
    const address = document.querySelector('#address');
    const username = document.querySelector('#username');
    const password = document.querySelector('#password');

    const oldPassword = document.querySelector('#oldPassword');
    const newPassword = document.querySelector('#newPassword');
    const confirmNewPassword = document.querySelector('#confirmNewPassword');

    const profileForm = document.querySelector('#profileForm');
    const changePasswordForm = document.querySelector('#changePasswordForm');

    const editBtn = document.querySelector('#editBtn');
    const saveBtn = document.querySelector('#saveBtn');

    // Show/enable inputs on edit
    if (editBtn) {
        editBtn.addEventListener('click', () => {
            fullName.removeAttribute('readonly');
            email.removeAttribute('readonly');
            address.removeAttribute('readonly');
            saveBtn.style.display = 'inline-block';
            editBtn.style.display = 'none';
        });
    }

    // Error functions
    function showError(input, message) {
        clearError(input);
        const error = document.createElement('div');
        error.className = 'error-message';
        error.style.color = '#ff4444';
        error.style.fontSize = '12px';
        error.style.marginTop = '5px';
        error.textContent = message;
        input.parentNode.appendChild(error);
        input.style.borderColor = '#ff4444';
    }

    function clearError(input) {
        const error = input.parentNode.querySelector('.error-message');
        if (error) error.remove();
        input.style.borderColor = '';
    }

    // Validators
    function validateFullName(value) {
        if (!value.trim()) return 'Full name cannot be empty';
        if (!/^[a-zA-Z\s]{2,50}$/.test(value)) return 'Full name must be 2-50 letters only';
        return null;
    }

    function validateEmail(value) {
        if (!value.trim()) return 'Email cannot be empty';
        if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value)) return 'Invalid email format (ex: dat7075@gmail.com)';
        return null;
    }

    function validateAddress(value) {
        if (!value.trim()) return 'Address cannot be empty';
        if (!/^(?!.*[.,#/^()'\-]{2,})(?!-)[A-Za-z0-9\s.,#/^()'\-]{2,50}$/.test(value)) return 'Invalid address (ex: 123 Chicago, USA)';
        return null;
    }

    function validatePassword(value) {
        if (!value) return 'Password cannot be empty';
        if (value.length < 6 || value.length > 20) return 'Password must be between 6-20 characters';
        if (!/[a-z]/.test(value)) return 'Password must contain at least one lowercase letter';
        if (!/[A-Z]/.test(value)) return 'Password must contain at least one uppercase letter';
        if (!/\d/.test(value)) return 'Password must contain at least one number';
        if (!/[!@#$%^&*(),.?":{}|<>]/.test(value)) return 'Password must contain at least one special character';
        return null;
    }

    function checkPasswordMatch(p1, p2) {
        if (p1 !== p2) return 'Passwords do not match';
        return null;
    }

    // Real-time clear error
    [fullName, email, address, oldPassword, newPassword, confirmNewPassword].forEach(input => {
        if (input) input.addEventListener('input', () => clearError(input));
    });

    // Profile form validation
    if (profileForm) {
        profileForm.addEventListener('submit', function (e) {
            let hasError = false;

            const fullNameError = validateFullName(fullName.value);
            if (fullNameError) { showError(fullName, fullNameError); hasError = true; }

            const emailError = validateEmail(email.value);
            if (emailError) { showError(email, emailError); hasError = true; }

            const addressError = validateAddress(address.value);
            if (addressError) { showError(address, addressError); hasError = true; }

            if (hasError) e.preventDefault();
        });
    }

    // Change password validation
    if (changePasswordForm) {
        changePasswordForm.addEventListener('submit', function (e) {
            let hasError = false;

            const oldError = validatePassword(oldPassword.value);
            if (oldError) { showError(oldPassword, oldError); hasError = true; }

            const newError = validatePassword(newPassword.value);
            if (newError) { showError(newPassword, newError); hasError = true; }

            const matchError = checkPasswordMatch(newPassword.value, confirmNewPassword.value);
            if (matchError) { showError(confirmNewPassword, matchError); hasError = true; }

            if (hasError) e.preventDefault();
        });
    }
});
