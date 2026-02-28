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
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/styleDadosCadastrais.css">
    <link rel="stylesheet" href="styles/styleContaAluno.css">
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
    <title>Cruz Azul - Criar Conta</title>
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
        <h2>Conta do Aluno</h2>
        <h5>Estudante, certifique que seu nome esteja correto e preencha os campos</h5>
    </div>
    <div id="container">
        <img src="assets/images/logo de conta.png" alt="">
        <h2>Crie sua Conta</h2>
        <form action="${pageContext.request.contextPath}/cadastrar" method="post">
            <input type="hidden" name="id" value="<%= id %>" />
            <div>
                <label >Nome</label>
                <input type="text" name="nome" placeholder="Digite seu nome" required pattern="^[A-Z][a-z]{1,} [A-Za-z][A-Za-z ]*$" title="Digite seu nome completo, começando com letra maiúscula">
            </div>
            <div>
                <label>Email</label>
                <input type="text" name="email" placeholder="Digite seu email" required pattern="^[a-zA-Z0-9\._]{3,}@[a-zA-Z0-9]{2,}\.(com|org)\.?(br)?$" title="Digite um email válido, que tenha .com ou .org.br">
            </div>
            <div id="campo-senha">
                <section>
                    <label>Senha</label>
                    <input type="password" name="senha" placeholder="Digite uma senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
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
                <label >Senha</label>
                <input type="password" name="senhaConf" placeholder="Digite uma senha" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="A senha deve ter: - 8 dígitos - 1 letra maiúscula e minúscula - 1 número - 1 caractere especial">
            </div>
            <button type="submit" class="confirmar">Criar Conta</button>
        </form>
    </div>
</main>
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