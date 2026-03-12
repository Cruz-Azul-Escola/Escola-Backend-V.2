
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
<%@ page import="java.util.ArrayList" %>


<%
  AlunoDTO aluno = (AlunoDTO) request.getAttribute("aluno");
  ProfessorDTO professor = (ProfessorDTO) session.getAttribute("usuarioLogado");
  Integer totalAlunos = (Integer) request.getAttribute("totalAlunos");
  List<TurmaAlunoDTO> rankng = (List<TurmaAlunoDTO>)  request.getAttribute("listaAlunos");

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
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script defer src="scripts/scriptLoad.js"></script>
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
    <h3>Alunos Existentes</h3>
    <div>
      <label>Filtro</label>
      <input id="filtro" type="text" class="filtros">
    </div>

    <div class="tabela-container">
      <% if(rankng != null && !rankng.isEmpty()) { %>

      <table class="tabela" border="1" cellpadding="5">
        <tr>
          <th>Posição</th>
          <th>Nome</th>
          <th>Matrícula</th>
          <th>Média</th>
        </tr>

        <% int cont=1;
          for(TurmaAlunoDTO a : rankng) { %>
        <tr class="item-linha">
          <td><%= cont %>°</td>
          <% cont++; %>
          <td class="nomeItemLinha"><%= a.getAluno().getNome() %></td>
          <td><%=a.getAluno().getMatricula() %></td>
          <td><%=a.getMedia() %></td>
        </tr>
        <% } %>
      </table>
      <% } else { %>
      <p>Você não tem nenhum aluno por enquanto.</p>
      <% } %>
    </div>
  </section>

  <section style="padding: 20px" class="cartao">
    <div id="cabecalho-busca">
      <div class="titulo-busca">
        <img src="assets/icons/lupa azul.png" alt="">
        <h3>Buscar Aluno</h3>
      </div>
      <p class="titulo-busca">Digite a mátricula do aluno para visualizar e editar informações</p>
    </div>
    <form onsubmit="mostrarLoader()" method="post" action="homeProfessor" class="search-form">
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
      <button type="submit" class="btn-search">
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
        <h5>E-mail</h5>
          <h3><a href="mailto:<%= aluno.getEmail() %>"><%= aluno.getEmail() %></a></h3>
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

        <form onsubmit="mostrarLoader()" method="post" action="homeProfessor">
          <input type="hidden" name="acao" value="salvarNotas">
          <input type="hidden" name="idAluno" value="<%= aluno.getId() %>">
          <input type="hidden" name="idTurma" value="<%= matricula.getTurma().getId() %>">
          <input type="hidden" name="observacao" value="<%= obs %>">

          <div>
            <label>Nota 1</label>
            <input type="number" step="0.01" value="<%= n1 %>" name="nota1" required>
          </div>

          <div>
            <label>Nota 2</label>
            <input type="number" step="0.01" value="<%= n2 %>" name="nota2" required>
          </div>

          <button type="submit" class="btn-primary">Salvar Notas</button>
          <button type="button" onclick="fecharModalNotas()">Cancelar</button>
        </form>
      </div>
    </div>

    <div id="modalObs" class="modal">
      <div class="modal-content">
        <h3>Editar Observação</h3>

        <form onsubmit="mostrarLoader()" method="post" action="homeProfessor">
          <input type="hidden" name="acao" value="salvarNotas">
          <input type="hidden" name="idAluno" value="<%= aluno.getId() %>">
          <input type="hidden" name="idTurma" value="<%= matricula.getTurma().getId() %>">
          <input type="hidden" name="nota1" value="<%= n1 %>">
          <input type="hidden" name="nota2" value="<%= n2 %>">

          <textarea name="observacao" value="<%= obs %>" required><%= obs %></textarea>

          <button type="submit" class="btn-warning">Salvar Observação</button>
          <button type="button" onclick="fecharModalObs()">Cancelar</button>
        </form>
      </div>
    </div>
  </section>

  <% } %>

</main>
<%
  String mensagem = (String) request.getAttribute("mensagem");
  String erro = (String) request.getAttribute("erro");
%>




<% if (request.getAttribute("mensagem") != null) { %>
<script>
  Swal.fire({
    icon: 'success',
    title: 'Sucesso',
    text: '<%= request.getAttribute("mensagem") %>',
    timer: 2500,
    showConfirmButton: false
  });
</script>
<% } %>
<% if (request.getAttribute("erro") != null) { %>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    Swal.fire({
      icon: "error",
      title: "Oops...",
      text: "Erro na hora do cadastro ou link, certifique existencia e a singularidade de dados"
    });
  });
</script>
<% } %>
<script>
  function abrirModalNotas() {
    document.getElementById("modalNotas").style.display = "block";
    document.getElementById("modalObs").style.display = "none";
  }

  function fecharModalNotas() {
    document.getElementById("modalNotas").style.display = "none";
  }

  function abrirModalObs() {
    document.getElementById("modalObs").style.display = "block";
    document.getElementById("modalNotas").style.display = "none";
  }

  function fecharModalObs() {
    document.getElementById("modalObs").style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target.classList.contains("modal")) {
      event.target.style.display = "none";
    }
  }

  document.getElementById("filtro").addEventListener("keyup", function () {
    let termo = this.value.toLowerCase();
    let alunos = document.querySelectorAll(".item-linha");
    alunos.forEach(function (aluno) {
      let nome = aluno.querySelector(".nomeItemLinha")
              .textContent
              .toLowerCase();

      if (nome.includes(termo)) {
        aluno.style.display = "";
      } else {
        aluno.style.display = "none";
      }
    });
  });
</script>


</body>
</html>