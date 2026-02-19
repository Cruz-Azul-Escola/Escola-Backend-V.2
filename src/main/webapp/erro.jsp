<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 18/02/2026
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../styles/style.css">
  <link rel="stylesheet" href="../styles/styleDadosCadastrais.css">
  <link rel="stylesheet" href="../styles/styleErroGenerico.css">
  <link rel="shortcut icon" href="../assets/icons/Logo da escola.png" type="image/x-icon">
  <title>Erro</title>
</head>
<body>
<header>
  <div id="logotipo">
    <div>
      <img src="../assets/icons/Logo da escola.png" alt="">
    </div>
    <div>
      <h1>Cruz Azul</h1>
      <h4>Portal do Aluno</h4>
    </div>
  </div>
  <a href="../index.html">
    <div id="voltar">
      <img src="../assets/icons/voltar.png" alt="">
      <h4>Voltar</h4>
    </div>
  </a>
</header>
<main>
  <div>
    <h2>Ocorreu um erro</h2>
  </div>
  <div id="container">
    <img src="../assets/icons/Logo da escola.png" alt="">
   <h2>Erro no Sistema</h2>
    <%
      Throwable ex = exception;

      if (ex != null) {
    %>
    <h3>Mensagem:</h3>
    <ul>
      <li><%= ex.getMessage() %></li>
    </ul>

    <h3>Detalhes:</h3>
    <ul>
      <%
        while (ex != null) {
      %>
      <li><%= ex.getClass().getName() %></li>
      <%
          ex = ex.getCause();
        }
      %>
    </ul>
    <%
    } else {
    %>
    <p>Erro desconhecido.</p>
    <%
      }
    %>
    <a href="login.jsp">Voltar ao login</a> </div>
</main>
</body>
</html>
