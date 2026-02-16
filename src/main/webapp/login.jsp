<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 13/02/2026
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', sans-serif;
    }

    body {
        background-color: #EEF4FF;
        color: #0A3C9A;
    }

    .topbar {
        background-color: #0B3E91;
        color: #fff;
        padding: 16px 32px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo-area {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo-area img {
        width: 40px;
        height: 40px;
    }

    .logo-area h1 {
        font-size: 20px;
        font-weight: 600;
    }

    .logo-area span {
        font-size: 12px;
        opacity: 0.85;
    }

    .btn-logout {
        background: #fff;
        color: #0B3E91;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
    }
    #logo {
        width: 52px;
        height: 52px;
        background-color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    #logo img {
        width: 28px;
        height: auto;
    }
    .container{
        text-align: center;
    }

    .container h1{
        margin: 3% 0;
    }

    .card-login{
        background-color: rgb(255, 255, 255);
        width: 40%;
        margin: auto;
        padding: 30px 90px;
        border-radius: 40px;
    }
    .field {
        position: relative;
        width: 100%;
        margin-bottom: 24px;
    }

    .field input {
        width: 100%;
        padding: 14px 18px;
        font-size: 16px;
        border: 2px solid #000;
        border-radius: 999px;
        outline: none;
        box-sizing: border-box;
    }

    .field label {
        position: absolute;
        top: -10px;
        left: 20px;
        background: #fff;
        padding: 0 8px;
        font-size: 14px;
        color: #000;
    }

    .link{
        text-decoration: none;
        color: #FF8000;
    }
    .direi {
        display: flex;
        justify-content: flex-end;
    }
    .direi .link {
        margin-left: 6px;
    }
    .botao-entrar{
        padding: 5px 40px;
        font-size: 20px;
        border: 0;
        color: white;
        font-weight: bold;
        background-color: #FF8000;
        border-radius: 20px;
    }




</style>
<body>
<header class="topbar">
    <div class="logo-area">
        <div id="logo">
            <img  src="logo.png" alt="Cruz Azul" />
        </div>
        <div>
            <h1>Cruz Azul</h1>
            <span>Portal do Aluno</span>
        </div>
    </div>
    <form action="login.jsp">
        <button class="btn-logout">➜ Sair</button>
    </form>

</header>
<main>
    <div class="container">
        <h1  class="title-h1">Bem-vindo, ao portal Cruz Azul</h1>
        <div class="card-login">
            <div>
                <img style="width: 50px; height: auto;" src="logo.png" alt="">
                <h1 style="margin-bottom: 50px;" class="title-h1">Faça seu login</h1>
            </div>
            <form action="login" method="post">
                <div class="field">
                    <label>E-mail</label>
                    <input name="email" type="email" placeholder="Digite seu email">
                </div>

                <div style="margin-bottom: 0;" class="field">
                    <label>Senha</label>
                    <input name="senha" type="password" placeholder="Digite sua senha">
                </div>

                <div>
                    <button class="botao-entrar" type="submit">Entrar</button>
                </div>
            </form>


        </div>
    </div>
</main>
</body>
</html>