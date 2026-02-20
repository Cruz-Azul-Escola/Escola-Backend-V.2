<%@ page import="com.example.escola_backend_v2.DTO.AlunoDTO" %>
<%@ page import="com.example.escola_backend_v2.DTO.TurmaAlunoDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 09/02/2026
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  AlunoDTO aluno = (AlunoDTO) request.getAttribute("aluno");

  if (aluno == null) {
%>
<%
    return;
  }

  List<TurmaAlunoDTO> boletim = aluno.getMatriculas();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <title>Portal do Aluno</title>
  <link rel="stylesheet" href="styles/styleAluno.css" />
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
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

<main class="container">
  <section class="card welcome-card">
    <div class="card-header">
      <h2>Bem-vindo, Aluno(a) <%= aluno.getNome() %>!</h2>
      <span class="matricula">Sala: <%= boletim.get(0).getTurma().getSala().getNome() %></span>
    </div>

    <%
      double somaMedias = 0;
      int qtdMediasValidas = 0;
      int totalObservacoes = 0;

      if (boletim != null) {
        for (TurmaAlunoDTO ta : boletim) {
          if (ta.getMedia() != null && ta.getMedia() >= 0) {
            somaMedias += ta.getMedia();
            qtdMediasValidas++;
          }

          if (ta.getObservacoes() != null && !ta.getObservacoes().isEmpty()) {
            totalObservacoes++;
          }
        }
      }

      double mediaGeral = qtdMediasValidas > 0
              ? Math.round((somaMedias / qtdMediasValidas) * 10.0) / 10.0
              : 0;
    %>
    <div class="stats">
      <div class="stat-box">
        <span>Média Geral</span>
        <strong><%= mediaGeral %></strong>
      </div>

      <div class="stat-box">
        <span>Disciplinas</span>
        <strong><%= boletim != null ? boletim.size() : 0 %></strong>
      </div>

      <div class="stat-box">
        <span>Observações</span>
        <strong><%= totalObservacoes %></strong>
      </div>

    </div>
  </section>
  <section class="card boletim-card">
    <div class="boletim-header">
      <div>
        <h3>Boletim Escolar</h3>
        <p>Visualize suas notas e observações</p>
      </div>

      <form action="gerarBoletim" method="get">
        <button class="btn-pdf" type="submit">Baixar Boletim ⬇</button>
      </form>
    </div>

    <div class="tabs">
      <button onclick="trocaObs()" id="notas" class="tab  active">
        Notas
      </button>
      <button onclick="trocarNota()" id="obs" class="tab">Observações</button>
    </div>

    <div id="boletimDiv">
      <table class="boletim-table">
        <thead>
        <tr>
          <th>Disciplina</th>
          <th>Nota 1</th>
          <th>Nota 2</th>
          <th>Média</th>
          <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
          if (boletim != null && !boletim.isEmpty()) {
            for (TurmaAlunoDTO ta : boletim) {
        %>
        <tr>
          <td><%= ta.getTurma().getDisciplina().getNome() %></td>
          <td><%= ta.getNota1() != null ? ta.getNota1() : "-" %></td>
          <td><%= ta.getNota2() != null ? ta.getNota2() : "-" %></td>
          <td>
            <%= ta.getMedia() == -1 ? "Não disponível" : ta.getMedia() %>
          </td>

          <%
            String status;

            if (ta.getMedia() == null || ta.getMedia() < 0) {
              status = "Indefinido";
            } else if (ta.getMedia() >= 6) {
              status = "Aprovado";
            } else {
              status = "Reprovado";
            }
          %>
          <td><%= status %></td>
        </tr>

        <%
          }
        } else {
        %>
        <tr>
          <td colspan="5">Nenhuma disciplina encontrada.</td>
        </tr>
        <%
          }
        %>

        </tbody>
      </table>
    </div>



    <div class="vazio" id="observacoesDiv">
      <%
        boolean temObs = false;

        if (boletim != null) {
          for (TurmaAlunoDTO ta : boletim) {
            if (ta.getObservacoes() != null && !ta.getObservacoes().isEmpty()) {
              temObs = true;
      %>
      <div class="observacao-card">
        <h4><%= ta.getTurma().getDisciplina().getNome() %></h4>
        <span class="professor">
<%--            Professor(a): <%= ta.getTurma().getProfessores().get(0).getNome() %>--%>
        </span>

        <p class="observacao-texto">
          <%= ta.getObservacoes() %>
        </p>
      </div>
      <%
            }
          }
        }

        if (!temObs) {
      %>
      <p>Nenhuma observação registrada.</p>
      <%
        }
      %>
    </div>


  </section>
</main>
<script>
  let notas = document.getElementById("notas");
  let obs = document.getElementById("obs");

  let notasDiv = document.getElementById("boletimDiv")
  let obsDiv = document.getElementById("observacoesDiv")
  function trocarNota() {
    notas.classList.remove("active");
    obs.classList.add("active");
    notasDiv.classList.add("vazio");
    obsDiv.classList.remove("vazio");

  }
  function trocaObs() {
    obs.classList.remove("active");
    notas.classList.add("active");
    obsDiv.classList.add("vazio");
    notasDiv.classList.remove("vazio");
  }
</script>
</body>
</html>
