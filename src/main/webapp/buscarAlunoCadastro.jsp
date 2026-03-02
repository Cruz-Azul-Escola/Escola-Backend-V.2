<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 17/02/2026
  Time: 20:13
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
  <title>Cruz Azul - Cadastro</title>
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
    <h2>Cadastro de Aluno</h2>
    <h5>Estudante, informe seu CPF para continuar o cadastro</h5>
  </div>
  <div id="container">
    <img src="assets/images/logo de documento.png" alt="">
    <h2>Cadastro</h2>
    <form action="${pageContext.request.contextPath}/buscar" method="post">
      <div>
        <label>CPF</label>
        <input         type="text"
                       id="cpf"
                       maxlength="14"
                       placeholder="000.000.000-00"
                       autocomplete="off" required pattern="^[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}[ \-]?[0-9]{2}$" title="Digite um CPF válido, Ex: 123.456.789-00 ou 12345678900">
      </div>
      <button type="submit" class="confirmar">Confirmar CPF</button>
    </form>
  </div>
</main>
<script src="scripts/scriptValidacaoCpf.js"></script>
</body>
</html>