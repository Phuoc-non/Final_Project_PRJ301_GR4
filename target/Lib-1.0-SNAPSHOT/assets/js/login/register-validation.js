// ===== FULL VALIDATION SCRIPT FOR REGISTRATION FORM =====
document.addEventListener('DOMContentLoaded', function () {
    const passwordInput = document.querySelector('input[name="password"]');
    const repasswordInput = document.querySelector('input[name="repassword"]');
    const emailInput = document.querySelector('input[type="email"]');
    const addressInput = document.querySelector('input[name="address"]');
    const fullNameInput = document.querySelector('input[name="fullName"]');
    const usernameInput = document.querySelector('input[name="username"]');
    const registerForm = document.querySelector('.register-container form');

    // ======= COMMON ERROR FUNCTIONS =======
    function showError(input, message) {
        const existingError = input.parentNode.querySelector('.error-message');
        if (existingError) existingError.remove();

        const errorElement = document.createElement('div');
        errorElement.className = 'error-message';
        errorElement.textContent = message;
        errorElement.style.cssText = `
            color: #ff4444;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        `;
        input.parentNode.appendChild(errorElement);
        input.style.borderColor = '#ff4444';
    }

    function clearError(input) {
        const errorElement = input.parentNode.querySelector('.error-message');
        if (errorElement) errorElement.remove();
        input.style.borderColor = '#ccc';
    }

    // ======= FULLNAME VALIDATION =======
    function validateFullName(fullName) {
    const fullNameRegex = /^([A-Z][a-z]+)(\s[A-Z][a-z]+)*$/;
        if (!fullName || fullName.trim() === '')
            return 'Full name is required';
        if (!fullNameRegex.test(fullName))
            return 'Full name must be capitalized.';
        return null;
    }

    if (fullNameInput) {
        fullNameInput.addEventListener('blur', function () {
            const error = validateFullName(this.value);
            error ? showError(this, error) : clearError(this);
        });
        fullNameInput.addEventListener('input', () => clearError(fullNameInput));
    }

    // ======= USERNAME VALIDATION =======
    function validateUsername(username) {
        const usernameRegex = /^(?=.*[A-Za-z])[A-Za-z0-9_]+$/;
        if (!username || username.trim() === '')
            return 'Username is required';
        if (!usernameRegex.test(username))
            return 'Username must contain at least one letter and can include letters.';
        return null;
    }

    if (usernameInput) {
        usernameInput.addEventListener('blur', function () {
            const error = validateUsername(this.value);
            error ? showError(this, error) : clearError(this);
        });
        usernameInput.addEventListener('input', () => clearError(usernameInput));
    }

    // ======= EMAIL VALIDATION =======
    function validateEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!email || email.trim() === '')
            return 'Email is required';
        if (!emailRegex.test(email))
            return 'Please enter a valid email address (ex: dat7075@gmail.com)';
        return null;
    }

    if (emailInput) {
        emailInput.addEventListener('blur', function () {
            const error = validateEmail(this.value);
            error ? showError(this, error) : clearError(this);
        });
        emailInput.addEventListener('input', () => clearError(emailInput));
    }

    // ======= PASSWORD VALIDATION =======
    function validatePasswordStrength(password) {
        if (!password)
            return 'Password is required';
        if (password.length < 6 || password.length > 20)
            return 'Password must be between 6 and 20 characters';
        if (!/(?=.*[a-z])/.test(password))
            return 'Password requires at least one lowercase letter';
        if (!/(?=.*[A-Z])/.test(password))
            return 'Password requires at least one uppercase letter';
        if (!/(?=.*\d)/.test(password))
            return 'Password must contain at least one number';
        if (!/(?=.*[!@#$%^&*(),.?":{}|<>])/.test(password))
            return 'Password must contain at least one special character';
        return null;
    }

    function checkPasswordMatch() {
        const password = passwordInput.value;
        const repassword = repasswordInput.value;
        if (repassword && password !== repassword) {
            showError(repasswordInput, 'Passwords do not match');
            return false;
        } else if (repassword) {
            clearError(repasswordInput);
        }
        return true;
    }

    if (passwordInput && repasswordInput) {
        passwordInput.addEventListener('blur', function () {
            const error = validatePasswordStrength(this.value);
            error ? showError(this, error) : clearError(this);
        });

        passwordInput.addEventListener('input', function () {
            clearError(this);
            if (repasswordInput.value)
                checkPasswordMatch();
        });

        repasswordInput.addEventListener('input', checkPasswordMatch);
    }

    // ======= ADDRESS VALIDATION =======
    function validateAddress(address) {
        const addressRegex = /^(?!.*[.,#/^()'\-]{2,})(?!-)[A-Za-z0-9\s.,#/^()'\-]{2,50}$/;
        if (!address || address.trim() === '')
            return 'Address is required';
        if (!addressRegex.test(address))
            return 'Please enter a valid address (ex: 123 Chicago; USA)';
        return null;
    }

    if (addressInput) {
        addressInput.addEventListener('blur', function () {
            const error = validateAddress(this.value);
            error ? showError(this, error) : clearError(this);
        });
        addressInput.addEventListener('input', () => clearError(addressInput));
    }

    // ======= FORM SUBMIT VALIDATION =======
    if (registerForm) {
        registerForm.addEventListener('submit', function (e) {
            // Full name
            const fullNameError = validateFullName(fullNameInput ? fullNameInput.value : '');
            if (fullNameError) {
                e.preventDefault();
                showError(fullNameInput, fullNameError);
                return;
            }

            // Username
            const usernameError = validateUsername(usernameInput ? usernameInput.value : '');
            if (usernameError) {
                e.preventDefault();
                showError(usernameInput, usernameError);
                return;
            }

            // Email
            const emailError = validateEmail(emailInput ? emailInput.value : '');
            if (emailError) {
                e.preventDefault();
                showError(emailInput, emailError);
                return;
            }

            // Address
            const addressError = validateAddress(addressInput ? addressInput.value : '');
            if (addressError) {
                e.preventDefault();
                showError(addressInput, addressError);
                return;
            }

            // Password
            const passwordError = validatePasswordStrength(passwordInput.value);
            if (passwordError) {
                e.preventDefault();
                showError(passwordInput, passwordError);
                return;
            }

            // Confirm password
            if (!repasswordInput.value) {
                e.preventDefault();
                showError(repasswordInput, 'Please confirm your password');
                return;
            }

            if (passwordInput.value !== repasswordInput.value) {
                e.preventDefault();
                showError(repasswordInput, 'Passwords do not match');
                return;
            }
        });
    }
});
