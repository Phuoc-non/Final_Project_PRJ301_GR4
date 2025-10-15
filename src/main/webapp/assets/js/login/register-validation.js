// Simple password confirmation validation
document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.querySelector('input[name="password"]');
    const repasswordInput = document.querySelector('input[name="repassword"]');

    // Show error message
    function showError(input, message) {
        // Remove existing error
        const existingError = input.parentNode.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // Create new error message
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

    // Clear error message
    function clearError(input) {
        const errorElement = input.parentNode.querySelector('.error-message');
        if (errorElement) {
            errorElement.remove();
        }
        input.style.borderColor = '#ccc';
    }

    // Check password confirmation
    function checkPasswordMatch() {
        const password = passwordInput.value;
        const repassword = repasswordInput.value;

        if (repassword && password !== repassword) {
            showError(repasswordInput, 'Passwords do not match');
            return false;
        } else if (repassword) {
            clearError(repasswordInput);
            return true;
        }
        return true;
    }

    // Kiểm tra mật khẩu cấp cao
    function validatePasswordStrength(password) {
        if (!password) {
            return 'Password is required';
        }
        if (password.length < 8) {
            return 'Password must be at least 8 characters long';
        }
        if (!/(?=.*[a-z])/.test(password)) {
            return 'Password must contain at least one lowercase letter';
        }
        if (!/(?=.*[A-Z])/.test(password)) {
            return 'Password must contain at least one uppercase letter';
        }
        if (!/(?=.*\d)/.test(password)) {
            return 'Password must contain at least one number';
        }
        if (!/(?=.*[!@#$%^&*(),.?":{}|<>])/.test(password)) {
            return 'Password must contain at least one special character';
        }
        return null; // Password is strong
    }

    // Add event listeners
    if (passwordInput && repasswordInput) {
        // Kiểm tra độ mạnh mật khẩu khi blur
        passwordInput.addEventListener('blur', function() {
            const error = validatePasswordStrength(this.value);
            if (error) {
                showError(this, error);
            } else {
                clearError(this);
            }
        });

        // Clear password error on input
        passwordInput.addEventListener('input', function() {
            clearError(this);
            // Re-check password match if repassword has value
            if (repasswordInput.value) {
                checkPasswordMatch();
            }
        });

        repasswordInput.addEventListener('input', checkPasswordMatch);
    }

    // Email validation function
    function validateEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!email || email.trim() === '') {
            return 'Email is required';
        }
        if (!emailRegex.test(email)) {
            return 'Please enter a valid email address';
        }
        return null; // No error
    }

    // Email input validation
    const emailInput = document.querySelector('input[type="email"]');
    if (emailInput) {
        emailInput.addEventListener('blur', function() {
            const email = this.value;
            const emailError = validateEmail(email);
            if (emailError) {
                showError(this, emailError);
            } else {
                clearError(this);
            }
        });

        emailInput.addEventListener('input', function() {
            // Clear error on input to give immediate feedback
            clearError(this);
        });
    }

    // Form submission validation
    const registerForm = document.querySelector('.register-container form');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            // Validate email first
            const email = emailInput ? emailInput.value : '';
            const emailError = validateEmail(email);
            if (emailError) {
                e.preventDefault();
                showError(emailInput, emailError);
                alert('Error: ' + emailError);
                return;
            }

            // Kiểm tra độ mạnh mật khẩu trước
            const password = passwordInput.value;
            const passwordError = validatePasswordStrength(password);
            if (passwordError) {
                e.preventDefault();
                showError(passwordInput, passwordError);
                alert('Error: ' + passwordError);
                return;
            }

            // Check if passwords match before submitting
            const repassword = repasswordInput.value;

            if (!repassword) {
                e.preventDefault();
                showError(repasswordInput, 'Please confirm your password');
                return;
            }

            if (password !== repassword) {
                e.preventDefault();
                showError(repasswordInput, 'Passwords do not match');
                
                // Show alert for user attention
                alert('Error: Password confirmation does not match the entered password!');
                return;
            }
        });
    }
});
