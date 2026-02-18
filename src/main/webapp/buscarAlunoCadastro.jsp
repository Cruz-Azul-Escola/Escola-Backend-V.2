<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 17/02/2026
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Buscar Aluno</title>
</head>
<body>

<h2>Buscar Aluno para Cadastro</h2>

<form action="${pageContext.request.contextPath}/buscar" method="post">

  <label>CPF:</label>
  <input type="text" name="cpf" required />

  <br><br>

  <button type="submit">Buscar</button>

</form>

</body>
</html>
