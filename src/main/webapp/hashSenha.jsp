<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 18/02/2026
  Time: 13:17
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
  <link rel="stylesheet" href="styles/styleVerificar.css">
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <title>Cruz Azul - Código</title>
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
  <a href="pages/esqueceuSenha.html">
    <div id="voltar">
      <img src="assets/icons/voltar.png" alt="">
      <h4>Voltar</h4>
    </div>
  </a>
</header>
<main>
  <div>
    <h2>Código de Redefinição</h2>
    <h5>Digite o código de 6 dígitos enviado para seu email cadastrado</h5>
  </div>
  <div id="container">
    <img src="assets/icons/Logo da escola.png" alt="">
    <h2>Token</h2>
    <form action="hashSenha" method="post">
      <input type="hidden" name="email" value="<%= request.getAttribute("email") %>">
      <div>
        <label >Código</label>
        <input name="codigo" type="text" pattern="^[0-9]{6}$" placeholder="Digite o código" title="Apenas números, 6 dígitos">
      </div>
      <button type="submit" class="confirmar">Confirmar Código</button>
    </form>
  </div>
</main>
</body>
</html>
