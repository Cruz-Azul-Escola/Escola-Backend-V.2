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
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script defer src="scripts/scriptVisualizarSenha.js"></script>
  <script defer src="scripts/scriptLoad.js"></script>
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
    <form onsubmit="mostrarLoader()" action="novaSenha" method="post">
      <input type="hidden" name="id" value="<%= id %>" />
      <div id="campo-senha">
        <section>
          <label >Senha</label>
          <div id="view-senha">
            <input id="senha" type="password" name="senha" placeholder="Digite sua senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
            <img src="assets/icons/closeEye.png" alt="" id="visualizar-senha" class="ver-senha" onclick="visualizarSenha()">
          </div>
        </section>
        <section>
          <div id="popUp">
            <div>
              <h2>A senha deve ter:</h2>
              <h2 id="fecharPopup" style="cursor:pointer;">✕</h2>
            </div>
            <ul>
              <li>Pelo menos 8 caracteres</li>
              <li>1 letra maiúscula e 1 minúscula</li>
              <li>1 número</li>
              <li>1 caractere especial</li>
            </ul>
          </div>
          <img src="assets/icons/infoSenha.png" alt="Info" id="btnInfoSenha" style="cursor:pointer;">
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
<%
  String mensagem = (String) request.getAttribute("mensagem");
  String erro = (String) request.getAttribute("erro");
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
<script>
  const btnInfo = document.getElementById("btnInfoSenha");
  const popUp = document.getElementById("popUp");
  const fechar = document.getElementById("fecharPopup");
  popUp.style.display = "none";
  btnInfo.addEventListener("click", () => {
    popUp.style.display = "block";
  });

  fechar.addEventListener("click", () => {
    popUp.style.display = "none";
  });
  document.addEventListener("click", function(event) {
    if (!popUp.contains(event.target) && event.target !== btnInfo) {
      popUp.style.display = "none";
    }
  });


</script>
</body>
</html>