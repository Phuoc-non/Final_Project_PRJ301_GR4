<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Double Slider Login / Registration Form</title>
        <link href="https://cdn.lineicons.com/4.0/lineicons.css" rel="stylesheet" />
        <link rel="stylesheet" href="http://localhost:8080/Lib/assets/css/login.css" />
    </head>
    <body>
        <div class="container" id="container">
            <!-- Register -->
            <div class="form-container register-container">
                <form action="register" method="post">
                    <h1 class="register-link">Register here.</h1>
                    <% if (request.getAttribute("errorRegister") != null) {%>
                    <div class="alert alert-danger"><%= request.getAttribute("errorRegister")%></div>
                    <% } %>
                    <% if (request.getAttribute("messageRegister") != null) {%>
                    <div class="alert alert-success"><%= request.getAttribute("messageRegister")%></div>
                    <% } %>

                    <!---Name-->
                    <div class="user-box">
                        <div class="input-with-icon">
                            <input type="text" name="fullName" required />
                            <label>Full Name</label>
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10" />
                            <circle cx="12" cy="10" r="3" />
                            <path d="M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662" />
                            </svg>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="user-box">
                        <div class="input-with-icon">
                            <input type="email" name="email" required />
                            <label>Email</label>
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                            <polyline points="22,6 12,13 2,6" />
                            </svg>
                        </div>
                    </div>

                    <!-- Username -->
                    <div class="user-box">
                        <div class="input-with-icon">
                            <input type="text" name="username" required />
                            <label>Username</label>
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
                            <circle cx="12" cy="7" r="4" />
                            </svg>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="user-box">
                        <div class="input-with-icon">
                            <input type="password" name="password" id="register-password" required />
                            <label>Password</label>
                            <span class="toggle-password" onclick="togglePassword('register-password', this)">
                                <svg class="eye-open" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z" />
                                <circle cx="12" cy="12" r="3" />
                                </svg>
                                <svg class="eye-closed" style="display:none;" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path
                                    d="M17.94 17.94A10.47 10.47 0 0 1 12 19c-7 0-11-7-11-7a21.46 21.46 0 0 1 5.17-6.88M22 12s-1.1-2.1-3-4.27M2 2l20 20" />
                                </svg>
                            </span>
                        </div>
                    </div>

                    <!-- Re-password -->
                    <div class="user-box">
                        <div class="input-with-icon">
                            <input type="password" name="repassword" id="register-repassword" required />
                            <label>Re-password</label>
                            <span class="toggle-password" onclick="togglePassword('register-repassword', this)">
                                <svg class="eye-open" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z" />
                                <circle cx="12" cy="12" r="3" />
                                </svg>
                                <svg class="eye-closed" style="display:none;" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path
                                    d="M17.94 17.94A10.47 10.47 0 0 1 12 19c-7 0-11-7-11-7a21.46 21.46 0 0 1 5.17-6.88M22 12s-1.1-2.1-3-4.27M2 2l20 20" />
                                </svg>
                            </span>
                        </div>
                    </div>

                    <button type="submit">Register</button>
                    <!-- Social login section -->
                    <div class="social-login">
                        <div class="divider">
                            <span>Or</span>
                        </div>
                        <div class="social-buttons">
                            <a href="login-facebook" class="social-btn facebook">
                                <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/facebook/facebook-original.svg" alt="">
                                Facebook
                            </a>
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/Lib/login&response_type=code&client_id=28124643077-1jjekr9l68gv8ach2fpf1qji2l7ktb5p.apps.googleusercontent.com&approval_prompt=force"" class="social-btn google">
                                <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg" alt="">
                                Google
                            </a>
                        </div>
                    </div>

                </form>
            </div>


            <!-- Login -->
            <div class="form-container login-container">
                <form action="login" method="post">
                    <h1>Login here.</h1>
                    <div class="user-box">
                        <div class="input-with-icon">
                            <input type="text" name="username" required />
                            <label>Username</label>
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                 class="lucide lucide-user-icon lucide-user">
                            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
                            <circle cx="12" cy="7" r="4" />
                            </svg>
                        </div>
                    </div>
                    <div class="user-box">
                        <div class="input-with-icon" style="position: relative;">
                            <input type="password" name="password" id="login-password" required />
                            <label>Password</label>
                            <!-- Nút con mắt -->
                            <span class="toggle-password" onclick="togglePassword('login-password', this)">
                                <!-- SVG hình con mắt mở -->
                                <svg id="eye-open" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                     class="lucide lucide-eye">
                                <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z" />
                                <circle cx="12" cy="12" r="3" />
                                </svg>
                                <!-- SVG hình con mắt đóng (ẩn ban đầu) -->
                                <svg id="eye-closed" style="display:none;" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                     class="lucide lucide-eye-off">
                                <path
                                    d="M17.94 17.94A10.47 10.47 0 0 1 12 19c-7 0-11-7-11-7a21.46 21.46 0 0 1 5.17-6.88M22 12s-1.1-2.1-3-4.27M2 2l20 20" />
                                </svg>
                            </span>
                        </div>
                    </div>

                    <%
                        if (request.getAttribute("errorLogin") != null) {
                            String res = (String) request.getAttribute("errorLogin");
                            out.println("<p>" + res + "</p>");
                        }
                    %>

                    <button type="submit">Login</button>

                    <!-- Social login section -->
                    <div class="social-login">
                        <div class="divider">
                            <span>Or</span>
                        </div>
                        <div class="social-buttons">
                            <a href="login-facebook" class="social-btn facebook">
                                <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/facebook/facebook-original.svg" alt="">
                                Facebook
                            </a>
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/Lib/login&response_type=code&client_id=28124643077-1jjekr9l68gv8ach2fpf1qji2l7ktb5p.apps.googleusercontent.com&approval_prompt=force"" class="social-btn google">
                                <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg" alt="">
                                Google
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Overlay Panels -->
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1 class="title">Hello <br />friends</h1>
                        <button class="ghost" id="login">Login
                            <i class="lni lni-arrow-left login"></i>
                        </button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1 class="title">Start your <br />journey now</h1>

                        <button class="ghost" id="register">Register
                            <i class="lni lni-arrow-right register"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <script src="http://localhost:8080/Lib/assets/js/login/index.js"></script>
        <script src="http://localhost:8080/Lib/assets/js/login/register-validation.js"></script>
    </body>

    <%
        String activeTab = (request.getAttribute("activeTab") != null) ? (String) request.getAttribute("activeTab") : "login";
    %>
    <script>
                                window.addEventListener('DOMContentLoaded', function () {
                                    var activeTab = "<%= activeTab%>";
                                    if (activeTab === "register") {
                                        document.getElementById("register").click();
                                    } else {
                                        document.getElementById("login").click();
                                    }
                                });
    </script>

</html>