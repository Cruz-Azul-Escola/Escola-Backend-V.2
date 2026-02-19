<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 03/02/2026
  Time: 00:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  Integer id = (Integer) request.getAttribute("id");
%>
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
  <link rel="stylesheet" href="styles/styleAlterarSenha.css">
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <title>Cruz Azul - Alterar Senha</title>
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
</header>
<main>
  <div>
    <h2>Alterar Senha</h2>
    <h5>Crie uma nova senha para sua conta</h5>
  </div>
  <div id="container">
    <img src="assets/images/logo de alterar senha.png" alt="">
    <h2>Altere sua senha</h2>
    <form action="novaSenha" method="post">
      <input type="hidden" name="id" value="<%= id %>" />
      <div id="campo-senha">
        <section>
          <label >Senha</label>
          <input type="password" name="senha" placeholder="Digite uma nova senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
        </section>
        <section>
          <div id="popUp">
            <div>
              <h2>A senha deve ter:</h2>
              <h2>✕</h2>
            </div>
            <ul>
              <li>Pelo menos 8 caracteres</li>
              <li>1 letra maiúscula e 1 minúscula</li>
              <li>1 número</li>
              <li>1 caractere especial</li>
            </ul>
          </div>
          <input id="infoSenha" type="checkbox">
          <img src="assets/icons/infoSenha.png" alt="">
        </section>
      </div>
      <div>
        <label>Confirme a Senha</label>
        <input type="password" name="confirmarSenha" placeholder="Confirme sua senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
      </div>
      <button type="submit" class="confirmar">Alterar Senha</button>
    </form>
  </div>
</main>
</body>
</html>