<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 16/02/2026
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 13/02/2026
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/styleDadosCadastrais.css">
    <link rel="stylesheet" href="styles/styleAreaRestrita.css">
    <script defer src="scripts/scriptVisualizarSenha.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script defer src="scripts/scriptLoad.js"></script>
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
    <title>Área Restrita</title>
</head>
<body>
<header>
    <div id="logotipo">
        <div>
            <img src="assets/icons/Logo da escola.png" alt="">
        </div>
        <div>
            <h1>Cruz Azul</h1>
            <h4>Portal do Admin</h4>
        </div>
    </div>
    <a href="login.jsp">
        <div id="voltar">
            <img src="assets/icons/voltar.png" alt="">
            <h4>Voltar</h4>
        </div>
    </a>
</header>
<main>
    <div>
        <h2>Área-restrita</h2>
    </div>
    <div id="container">
        <img src="assets/icons/Logo da escola.png" alt="">
        <h2>Conta</h2>
        <form onsubmit="mostrarLoader()" action="logarAdm" method="post">
            <div>
                <label >Email</label>
                <input type="text" name="email" placeholder="Digite seu email" required title="Digite um email válido, que tenha .com ou .org.br">
            </div>
            <div>
                <label >Senha</label>
                <div id="view-senha">
                    <input id="senha" type="password" name="senha" placeholder="Digite sua senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
                    <img src="assets/icons/closeEye.png" alt="" id="visualizar-senha" class="ver-senha" onclick="visualizarSenha()">
                </div>
            </div>
            <button type="submit" class="confirmar">Entrar</button>
        </form>
    </div>
</main>

<% String erro = (String) request.getAttribute("erroLogin"); %>

<% if (erro != null) { %>
<script>
    alert("<%= erro %>");
</script>
<% } %>
<%
    String mensagem = (String) request.getAttribute("mensagem");
%>




<% if (request.getAttribute("mensagem") != null) { %>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Sucesso',
        text: '<%= request.getAttribute("mensagem") %>',
        timer: 2500,
        showConfirmButton: false
    });
</script>
<% } %>
<% if (request.getAttribute("erro") != null) { %>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Erro na hora do cadastro ou link, certifique existencia e a singularidade de dados"
        });
    });
</script>
<% } %>
</body>
</html>