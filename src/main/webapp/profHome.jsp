<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 15/02/2026
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.escola_backend_v2.DTO.ProfessorDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.escola_backend_v2.DTO.AlunoDTO" %>
<%@ page import="com.example.escola_backend_v2.DTO.TurmaAlunoDTO" %>


<%
  AlunoDTO aluno = (AlunoDTO) request.getAttribute("aluno");
  ProfessorDTO professor = (ProfessorDTO) session.getAttribute("usuarioLogado");
  Integer totalAlunos = (Integer) request.getAttribute("totalAlunos");

%><!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Portal do Professor</title>
  <link rel="stylesheet" href="style-professor.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', sans-serif;
  }

  body {
    background-color: #EAF0FB;
    color: #123A8D;
  }

  /* TOPBAR */
  .topbar {
    background-color: #163F8C;
    color: #fff;
    padding: 18px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .logo-area {
    display: flex;
    align-items: center;
    gap: 14px;
  }

  #logo {
    width: 52px;
    height: 52px;
    background: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  #logo img {
    width: 28px;
  }

  .logo-area h1 {
    font-size: 20px;
    font-weight: 600;
  }

  .logo-area span {
    font-size: 13px;
    opacity: 0.85;
  }

  .btn-logout {
    background: white;
    color: #163F8C;
    border: none;
    padding: 10px 18px;
    border-radius: 10px;
    font-weight: 600;
    cursor: pointer;
  }

  /* CONTAINER */
  .container {
    max-width: 1150px;
    margin: 50px auto;
    padding: 0 20px;
  }

  .card {
    background: #F6F7FB;
    border-radius: 24px;
    padding: 30px;
    margin-bottom: 40px;
  }

  /* WELCOME CARD */
  .welcome-header {
    background-color: #163F8C;
    color: white;
    padding: 18px 24px;
    border-radius: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .welcome-header h2 {
    font-size: 26px;
  }

  .usuario {
    font-size: 14px;
  }

  .welcome-content {
    display: flex;
    gap: 30px;
    margin-top: 30px;
  }

  .total-card {
    flex: 1;
    background: #DCE6F8;
    border-radius: 18px;
    padding: 30px;
    text-align: center;
  }

  .total-card span {
    display: block;
    margin-top: 10px;
    font-size: 15px;
  }

  .total-card strong {
    font-size: 48px;
    font-weight: bold;
    display: block;
    margin-top: 8px;
  }

  .disciplina-card {
    flex: 1;
    background: #F6E2A9;
    border: 2px solid #F4B400;
    border-radius: 18px;
    padding: 30px;
    text-align: center;
  }

  .disciplina-card span {
    font-size: 14px;
  }

  .disciplina-card h3 {
    font-size: 28px;
    margin-top: 8px;
  }

  /* SEARCH */
  .search-header h3 {
    font-size: 20px;
  }

  .search-header p {
    font-size: 14px;
    margin-top: 6px;
    opacity: 0.8;
  }

  .search-form {
    display: flex;
    gap: 20px;
    margin-top: 20px;
  }

  .input-group {
    flex: 1;
    display: flex;
    flex-direction: column;
  }

  .input-group label {
    font-weight: 600;
    margin-bottom: 6px;
  }

  .input-group input {
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #C8D4F2;
  }
  .input-group select {
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #C8D4F2;
  }



  .btn-search {
    background: #163F8C;
    color: white;
    border: none;
    padding: 14px 22px;
    border-radius: 10px;
    font-weight: 600;
    cursor: pointer;
    align-self: flex-end;
  }

  /* INFO ALUNO */
  .info-header {
    background-color: #F4B400;
    color: white;
    padding: 14px 20px;
    border-radius: 12px;
    margin-bottom: 25px;
  }

  .aluno-dados {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
  }

  .aluno-dados span {
    font-size: 13px;
    opacity: 0.8;
  }

  .aluno-dados strong {
    display: block;
    margin-top: 4px;
    font-size: 18px;
  }

  .email span {
    font-size: 13px;
  }

  .email strong {
    display: block;
    margin-top: 4px;
    margin-bottom: 20px;
  }

  /* NOTAS */
  .notas-box {
    background: #DCE6F8;
    padding: 24px;
    border-radius: 16px;
  }

  .notas-box h4 {
    margin-bottom: 20px;
  }

  .notas-grid {
    display: flex;
    justify-content: space-between;
  }

  .nota-item span {
    display: block;
    margin-bottom: 6px;
  }

  .nota-item strong {
    font-size: 40px;
  }

  .nota-item.media strong {
    color: #F57C00;
  }

  /* BOTÕES */
  .botoes {
    display: flex;
    gap: 20px;
    margin-top: 25px;
  }

  .btn-primary {
    flex: 1;
    background: #163F8C;
    color: white;
    border: none;
    padding: 14px;
    border-radius: 12px;
    font-weight: 600;
    cursor: pointer;
  }

  .btn-warning {
    flex: 1;
    background: #F57C00;
    color: white;
    border: none;
    padding: 14px;
    border-radius: 12px;
    font-weight: 600;
    cursor: pointer;
  }
  .modal {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.4);
    justify-content: center;
    align-items: center;
  }

  .modal-content {
    background: white;
    padding: 30px;
    border-radius: 20px;
    width: 400px;
    text-align: center;
  }

  .modal-content input,
  .modal-content textarea {
    width: 100%;
    margin-bottom: 15px;
    padding: 10px;
  }


</style>
<body>


<header class="topbar">
  <div class="logo-area">
    <div id="logo">
      <img src="logo.png" alt="Cruz Azul">
    </div>
    <div>
      <h1>Cruz Azul</h1>
      <span>Portal do Professor</span>
    </div>
  </div>

  <button class="btn-logout">➜ Sair</button>
</header>

<main class="container">

  <!-- CARD BOAS-VINDAS -->
  <section class="card welcome-card">

    <div class="welcome-header">
      <h2>Bem-vindo, Professor <%= professor.getNome()%>!</h2>
      <span class="usuario">Usuário: <%= professor.getEmail()%></span>
    </div>

    <div class="welcome-content">

      <div class="total-card">
        <div class="icon">👥</div>
        <span>Total de Alunos</span>
        <strong><%= totalAlunos != null ? totalAlunos : 0 %></strong>
      </div>

      <div class="disciplina-card">
        <span>Disciplinas</span>
        <%
          if (professor.getTurmas() != null && !professor.getTurmas().isEmpty()) {
        %>
        <h3><%= professor.getTurmas().get(0).getDisciplina().getNome() %></h3>
        <%
        } else {
        %>
        <h3>Nenhuma</h3>
        <%
          }
        %>
      </div>

    </div>

  </section>


  <!-- BUSCAR ALUNO -->
  <section class="card search-card">

    <form method="post" action="homeProfessor" class="search-form">

      <input type="hidden" name="acao" value="buscarAluno">

      <div class="input-group">
        <label>Disciplina</label>
        <select name="idTurma" required>
          <%
            for (var turma : professor.getTurmas()) {
          %>
          <option value="<%= turma.getId() %>">
            <%= turma.getDisciplina().getNome() %>
          </option>
          <%
            }
          %>
        </select>
      </div>

      <div class="input-group">
        <label>Matrícula</label>
        <input type="text" name="matricula" required>
      </div>

      <button type="submit" class="btn-search">Buscar</button>

    </form>


  </section>


  <!-- INFORMAÇÕES DO ALUNO -->
  <% if (aluno != null) {

    TurmaAlunoDTO matricula = null;

    if (aluno.getMatriculas() != null && !aluno.getMatriculas().isEmpty()) {
      matricula = aluno.getMatriculas().get(0); // primeira turma
    }

    double n1 = matricula != null && matricula.getNota1() != null ? matricula.getNota1() : 0;
    double n2 = matricula != null && matricula.getNota2() != null ? matricula.getNota2() : 0;
    double media = (n1 + n2) / 2;
  %>

  <section class="card info-card">

  <div class="info-header">
    <h3>Informações do Aluno</h3>
  </div>

  <div class="aluno-dados">
    <div>
      <span>Nome</span>
      <strong><%= aluno.getNome() %></strong>
    </div>

    <div>
      <span>Matrícula</span>
      <strong><%= aluno.getMatricula() %></strong>
    </div>
  </div>

  <div class="email">
    <span>E-mail</span>
    <strong><%= aluno.getEmail() %></strong>
  </div>

  <div class="notas-box">
    <h4>Notas Lançadas</h4>

    <div class="notas-grid">
      <div class="nota-item">
        <span>Nota 1</span>
        <strong><%= n1 %></strong>
      </div>

      <div class="nota-item">
        <span>Nota 2</span>
        <strong><%= n2 %></strong>
      </div>

      <div class="nota-item media">
        <span>Média</span>
        <strong><%= String.format("%.2f", media) %></strong>
      </div>
    </div>
  </div>

    <div class="botoes">

      <button type="button" class="btn-primary" onclick="abrirModalNotas()">
        Editar Notas
      </button>

      <button type="button" class="btn-warning" onclick="abrirModalObs()">
        Editar Observação
      </button>

    </div>
    <!-- MODAL NOTAS -->
    <div id="modalNotas" class="modal">
      <div class="modal-content">
        <h3>Lançar Notas</h3>
        <p>Aluno: <%= aluno.getNome() %></p>

        <form method="post" action="homeProfessor">
          <input type="hidden" name="acao" value="salvarNotas">
          <input type="hidden" name="idAluno" value="<%= aluno.getId() %>">
          <input type="hidden" name="idTurma" value="<%= matricula.getTurma().getId() %>">

          <label>Nota 1</label>
          <input type="number" step="0.01" value="<%= n1 %>" name="nota1" required>

          <label>Nota 2</label>
          <input type="number" step="0.01" value="<%= n2 %>" name="nota2" required>

          <button type="submit" class="btn-primary">Salvar Notas</button>
          <button type="button" onclick="fecharModalNotas()">Cancelar</button>
        </form>
      </div>
    </div>


    <!-- MODAL OBSERVAÇÃO -->
    <div id="modalObs" class="modal">
      <div class="modal-content">
        <h3>Editar Observação</h3>

        <form method="post" action="homeProfessor">
          <input type="hidden" name="acao" value="salvarNotas">
          <input type="hidden" name="idAluno" value="<%= aluno.getId() %>">
          <input type="hidden" name="idTurma" value="<%= matricula.getTurma().getId() %>">
          <input type="hidden" name="nota1" value="<%= n1 %>">
          <input type="hidden" name="nota2" value="<%= n2 %>">


          <textarea name="observacao" required></textarea>

          <button type="submit" class="btn-warning">Salvar Observação</button>
          <button type="button" onclick="fecharModalObs()">Cancelar</button>
        </form>
      </div>
    </div>


</section>

  <% } %>

</main>
<script>
  function abrirModalNotas() {
    document.getElementById("modalNotas").style.display = "flex";
  }

  function fecharModalNotas() {
    document.getElementById("modalNotas").style.display = "none";
  }

  function abrirModalObs() {
    document.getElementById("modalObs").style.display = "flex";
  }

  function fecharModalObs() {
    document.getElementById("modalObs").style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target.classList.contains("modal")) {
      event.target.style.display = "none";
    }
  }
</script>

</body>
</html>

