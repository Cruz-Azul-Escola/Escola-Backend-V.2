<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 03/02/2026
  Time: 00:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Recuperar Senha</title>
</head>
<body>

<h2>Recuperação de Senha</h2>

<form action="esqueci" method="post">
  <label>Digite seu email:</label><br>
  <input type="email" name="email" required><br><br>

  <button type="submit">Enviar código</button>
</form>

<br>
<a href="login.jsp">Voltar ao login</a>

<br><br>
<%
  String erro = (String) request.getAttribute("erro");
  if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
  }
%>

</body>
</html>
