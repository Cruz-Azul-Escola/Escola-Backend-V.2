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
            <h4>Portal do Aluno</h4>
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
        <form action="logarAdm" method="post">
            <div>
                <label >Email</label>
                <input type="text" name="email" placeholder="Digite seu email" required title="Digite um email válido, que tenha .com ou .org.br">
            </div>
            <div>
                <label>Senha</label>
                <input type="password" name="senha" placeholder="Digite sua senha" required >
            </div>
            <button type="submit" class="confirmar">Entrar</button>
        </form>
    </div>
</main>
</body>
</html>