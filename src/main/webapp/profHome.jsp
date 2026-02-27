
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
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <link rel="stylesheet" href="styles/styleProfessor.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
<header class="topbar">
  <div class="logo-area">
    <div id="logo">
      <img src="logo.png" alt="Cruz Azul">
    </div>
    <div>
      <h1>Cruz Azul</h1>
      <span>Portal do Professor(a)</span>
    </div>
  </div>




  <a style="text-decoration: none;" href="login.jsp" class="btn-logout">➜ Sair </a>
</header>

<main class="container">

  <section class="card welcome-card">

    <div class="welcome-header">
      <h2>Bem-vindo, Professor <%= professor.getNome()%>!</h2>
      <span class="usuario">Usuário: <%= professor.getEmail()%></span>
    </div>

    <div class="welcome-content">

      <div class="total-card">
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
  <section class="card dashboard">
    <h3>Dashboard Geral</h3>
    <br>
    <br>

    <a  style="text-decoration: none" class="btn-primary"
        href="dashboard">
      Visualizar Dashboard Geral
    </a>
  </section>



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

  <% if (aluno != null) {

    TurmaAlunoDTO matricula = null;

    if (aluno.getMatriculas() != null && !aluno.getMatriculas().isEmpty()) {
      matricula = aluno.getMatriculas().get(0); // primeira turma
    }

    double n1 = matricula != null && matricula.getNota1() != null ? matricula.getNota1() : 0;
    double n2 = matricula != null && matricula.getNota2() != null ? matricula.getNota2() : 0;
    String obs = matricula != null && matricula.getObservacoes() != null ? matricula.getObservacoes() : null;
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

    <div id="modalNotas" class="modal">
      <div class="modal-content">
        <h3>Lançar Notas</h3>
        <p>Aluno: <%= aluno.getNome() %></p>

        <form method="post" action="homeProfessor">
          <input type="hidden" name="acao" value="salvarNotas">
          <input type="hidden" name="idAluno" value="<%= aluno.getId() %>">
          <input type="hidden" name="idTurma" value="<%= matricula.getTurma().getId() %>">
          <input type="hidden" name="observacao" value="<%= obs %>">

          <label>Nota 1</label>
          <input type="number" step="0.01" value="<%= n1 %>" name="nota1" required>

          <label>Nota 2</label>
          <input type="number" step="0.01" value="<%= n2 %>" name="nota2" required>

          <button type="submit" class="btn-primary">Salvar Notas</button>
          <button type="button" onclick="fecharModalNotas()">Cancelar</button>
        </form>
      </div>
    </div>

    <div id="modalObs" class="modal">
      <div class="modal-content">
        <h3>Editar Observação</h3>

        <form method="post" action="homeProfessor">
          <input type="hidden" name="acao" value="salvarNotas">
          <input type="hidden" name="idAluno" value="<%= aluno.getId() %>">
          <input type="hidden" name="idTurma" value="<%= matricula.getTurma().getId() %>">
          <input type="hidden" name="nota1" value="<%= n1 %>">
          <input type="hidden" name="nota2" value="<%= n2 %>">


          <textarea name="observacao" value="<%= obs %>" required></textarea>

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
