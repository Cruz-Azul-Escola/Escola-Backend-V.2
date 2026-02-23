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
    <link rel="stylesheet" href="styles/styleIndex.css">
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
    <title>Cruz Azul - Login</title>
</head>
<body>
<header>
    <div id="logotipo">
        <div>
            <img src="assets/icons/Logo da escola.png" alt="">
        </div>
        <div>
            <button id="button-area-restrita"><h1>Cruz Azul</h1></button>
            <h4>Portal do Aluno</h4>
        </div>
    </div>
</header>
<main>
    <h2>Bem-vindo, ao portal Cruz Azul</h2>
    <div id="container">
        <img src="assets/icons/Logo da escola.png" alt="">
        <a href="logarAdm" style="list-style: none"><h2>Faça já o seu Login</h2></a>
        <form action="login" method="post">
            <div>
                <label >Email</label>
                <input type="email" name="email" placeholder="Digite seu email" required pattern="^[a-zA-Z0-9\._]{3,}@[a-zA-Z0-9]{2,}\.(com|org)\.?(br)?$" title="Digite um email válido, que tenha .com ou .org.br">
            </div>
            <div>
                <label >Senha</label>
                <input type="password" name="senha" placeholder="Digite sua senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
                <p id="esqueceu-senha"> Esqueceu a senha? <a href="esqueci.jsp">Crie uma nova</a></p>
            </div>
            <button type="submit" class="confirmar">Entrar</button>
        </form>
        <p id="linkConta">Aluno novo? <a href="buscarAlunoCadastro.jsp">Crie uma conta</a></p>
    </div>
</main>
<script src="scripts/scriptIndex.js"></script>
</body>
</html>