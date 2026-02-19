<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 03/02/2026
  Time: 00:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>

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
  <link rel="stylesheet" href="styles/styleEsqueceuSenha.css">
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <title>Cruz Azul - Esqueceu Senha</title>
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
    <h2>Redefinir Senha</h2>
    <h5>Digite seu email, que enviaremos um código para redefinir sua senha</h5>
  </div>
  <div id="container">
    <img src="assets/images/logo de email.png" alt="">
    <h2>Email de envio</h2>
    <form action="esqueci" method="post">
      <div>
        <label>Email</label>
        <input type="text" name="email" placeholder="Digite seu email" required pattern="^[a-zA-Z0-9\._]{3,}@[a-zA-Z0-9]{2,}\.(com|org)\.?(br)?$" title="Digite um email válido, que tenha .com ou .org.br">
      </div>
      <button type="submit" class="confirmar">Enviar</button>
    </form>
  </div>
</main>
</body>
</html>
