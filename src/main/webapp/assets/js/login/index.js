/* 
 * Index UI - Calculations removed
 */

// Basic UI functionality without calculations
const registerButton = document.getElementById("register");
const loginButton = document.getElementById("login");
const container = document.getElementById("container");

if (registerButton) {
    registerButton.addEventListener("click", () => {
        container.classList.add("right-panel-active");
    });
}

if (loginButton) {
    loginButton.addEventListener("click", () => {
        container.classList.remove("right-panel-active");
    });
}

function togglePassword(inputId, eyeIcon) {
    const input = document.getElementById(inputId);
    const eyeOpen = eyeIcon.querySelector('#eye-open');
    const eyeClosed = eyeIcon.querySelector('#eye-closed');
    if (input.type === 'password') {
        input.type = 'text';
        eyeOpen.style.display = 'none';
        eyeClosed.style.display = 'inline';
    } else {
        input.type = 'password';
        eyeOpen.style.display = 'inline';
        eyeClosed.style.display = 'none';
    }
}