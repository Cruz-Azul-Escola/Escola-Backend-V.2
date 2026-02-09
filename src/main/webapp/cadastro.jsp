<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 05/02/2026
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <form action="<%= request.getContextPath() %>/cadastrar" method="post">
        <label>CPF:</label><br>
        <input type="text" name="cpf" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Senha:</label><br>
        <input pattern="^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$" type="password" name="senha" required><br><br>

        <button type="submit">Cadastrar</button>
    </form>

</head>
</html>
