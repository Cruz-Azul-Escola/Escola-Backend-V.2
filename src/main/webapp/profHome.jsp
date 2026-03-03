
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
<%@ page import="java.util.List" %>


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
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles/style.css">
  <link rel="stylesheet" href="styles/styleProfessor.css">
  <script defer src="/scripts/scriptAbrirIframeProfessor.js"></script>
  <script defer src="scripts/scriptProfessor.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
<header id="cabecalho-site">
  <div id="logotipo">
    <div>
      <img src="assets/icons/Logo da escola.png" alt="">
    </div>
    <div>
      <h1>Cruz Azul</h1>
      <h4>Portal do Professor</h4>
    </div>
  </div>
  <a href="login.jsp">
    <div id="voltar">
      <img src="assets/icons/voltar.png" alt="">
      <h4>Sair</h4>
    </div>
  </a>
</header>

<main class="container">
  <section class="cartao">
    <div class="cabecalho-boasvindas">
      <h3>Bem-vindo, Professor <%= professor.getNome()%>!</h3>
      <h4>Usuário: <%= professor.getEmail()%></h4>
    </div>

    <div class="informacoes-gerais">
      <div class="dados">
        <div class="rotulo">Total de Alunos</div>
        <div class="valor"><%= totalAlunos != null ? totalAlunos : 0 %></div>
      </div>

      <div class="dados">
        <div class="rotulo">Disciplinas</div>
        <%
          if (professor.getTurmas() != null && !professor.getTurmas().isEmpty()) {
        %>
        <select id="opcoes-disciplina" class="valor">
          <option value="Disciplina 1"><%= professor.getTurmas().get(0).getDisciplina().getNome() %></option>
        </select>
        <%
        } else {
        %>
        <select id="opcoes-disciplina" class="valor">
          <option value="Nenhuma">Nenhuma</option>
        </select>
        <%
          }
        %>
      </div>
    </div>
  </section>

  <section class="cartao">
    <h3>Dashboard Geral</h3>
    <a style="text-decoration: none" class="btn-primary" href="dashboard">
      <button>
        Visualizar Dashboard Geral
      </button>
    </a>
  </section>

  <section class="cartao">
    <div id="cabecalho-busca">
      <div id="titulo-busca">
        <img src="assets/icons/lupa azul.png" alt="">
        <h3>Buscar Aluno</h3>
      </div>
      <p>Digite a mátricula do aluno para visualizar e editar informações</p>
    </div>
    <form>
      <div>
        <label for="">Mátricula</label>
        <input name="matricula" type="number" required>
      </div>
      <button type="submit">
        <img src="assets/icons/lupa branca.png" alt="">
        <p>Buscar</p>
      </button>
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

  <section class="cartao">
    <div id="cabecalho-info-aluno">
      <h3>Informações do Aluno</h3>
    </div>
    <div id="info-aluno">
      <div>
        <h5>Nome</h5>
        <h3><%= aluno.getNome() %></h3>
      </div>
      <div>
        <h5>Matrícula</h5>
        <h3><%= aluno.getMatricula() %></h3>
      </div>
      <div>
        <h5>E-mail<h5>
          <h3><a href="mailto:"><%= aluno.getEmail() %></a></h3>
      </div>
    </div>
    <div class="abas">
      <a class="aba" id="abrirNotas">Notas</a>
      <a class="aba" id="abrirObservacoes">Observações</a>
    </div>
    <div id="notas-lancadas" class="areas">
      <h3>Notas Lançadas</h3>
      <div id="formula-nota">
        <div>
          <h3>Nota 1</h3>
          <h1><%= n1 %></h1>
        </div>
        <div>
          <h3>Nota 2</h3>
          <h1><%= n2 %></h1>
        </div>
        <div>
          <h3>Média</h3>
          <h1><%= String.format("%.2f", media) %></h1>
        </div>
      </div>
    </div>
    <div id="observacoes-lancadas" class="areas">
      <article class="card-observacao">
        <div class="barra-lateral"></div>

        <div class="observacao-conteudo">
          <div class="observacao-topo">
            <div class="disciplina">Matemática</div>
            <div class="professor">Professor(a): Ana Souza</div>
          </div>

          <div class="observacao-texto">
            Longa e chata observação que estou com preguiça de escrever
          </div>
        </div>
      </article>


      <article class="card-observacao">
        <div class="barra-lateral"></div>

        <div class="observacao-conteudo">
          <div class="observacao-topo">
            <div class="disciplina">Matemática</div>
            <div class="professor">Professor(a): Ana Souza</div>
          </div>

          <div class="observacao-texto">
            Longa e chata observação que estou com preguiça de escrever
          </div>
        </div>
      </article>
    </div>
    <div id="opcoes-edicao">
      <button id="btn-notas">Lançar/Editar Notas</button>
      <button id="btn-observacoes">Fazer/Editar Observação</button>
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
</body>
</html>
