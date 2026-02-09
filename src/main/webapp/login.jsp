<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 03/02/2026
  Time: 00:58
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login</h2>

<form action="login" method="post">
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Senha:</label><br>
    <input type="password" name="senha" required><br><br>

    <button type="submit">Entrar</button>
</form>

<br>
<a href="esqueci.jsp">Esqueci minha senha</a>

<br><br>
<%
    String erro = (String) request.getAttribute("erro");
    if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
    }
%>

<a href="cadastro.jsp">
    Cadastrar
</a>

</body>
</html>

