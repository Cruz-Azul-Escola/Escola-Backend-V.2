<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 05/02/2026
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer id = (Integer) request.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro</title>
</head>
<body>

<h2>Completar Cadastro</h2>

<form action="${pageContext.request.contextPath}/cadastrar" method="post">

    <!-- ID vindo da página anterior -->
    <input type="hidden" name="id" value="<%= id %>" />

    <label>Nome:</label>
    <input type="text" name="nome" required />

    <br><br>

    <label>Email:</label>
    <input type="email" name="email" required />

    <br><br>

    <label>Senha:</label>
    <input pattern="^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$" type="password" name="senha" required />
    <label>Confirmação de senha::</label>
    <input pattern="^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$" type="password" name="senhaConf" required />


    <br><br>

    <button type="submit">Cadastrar</button>

</form>

</body>
</html>
