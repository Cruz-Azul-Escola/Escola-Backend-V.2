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
  <title>Nova Senha</title>
</head>
<body>

<h2>Definir Nova Senha</h2>

<form action="novaSenha" method="post">

  <input type="hidden" name="email" value="<%= request.getAttribute("email") %>">

  <label>Código recebido:</label><br>
  <input type="text" name="codigo" required><br><br>

  <label>Nova senha:</label><br>
  <input type="password" name="senha" required><br><br>

  <button type="submit">Salvar senha</button>
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
