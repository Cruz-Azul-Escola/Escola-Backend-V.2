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
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles/style.css" />
  <link rel="stylesheet" href="styles/styleAluno.css" />
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script defer src="scripts/scriptAluno.js"></script>
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
      <div>Bem-vindo, Aluno(a) <%= aluno.getNome() %>!</div>
      <div>Sala: <%= boletim.get(0).getTurma().getSala().getNome() %></div>
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

    <div class="corpo-boasvindas">
      <div class="estatisticas">
        <div class="estatistica">
          <div class="rotulo">Média Geral</div>
          <div class="valor"><%= mediaGeral %></div>
        </div>

        <div class="estatistica">
          <div class="rotulo">Disciplinas</div>
          <div class="valor"><%= boletim != null ? boletim.size() : 0 %></div>
        </div>

        <div class="estatistica">
          <div class="rotulo">Observações</div>
          <div class="valor"><%= totalObservacoes %></div>
        </div>
      </div>
    </div>
  </section>

  <div class="espacador"></div>

  <section class="cartao boletim">
    <div class="topo-boletim">
      <div>
        <h2>Boletim Escolar</h2>
        <p>Visualize suas notas e observações</p>
      </div>

      <form action="gerarBoletim" method="get">
        <button class="botao-pdf" type="submit">⬇ Baixar PDF</button>
      </form>
    </div>

    <div class="abas" role="tablist" aria-label="Boletim">
      <button type="button" class="aba ativa" id="tab-notas" role="tab" aria-selected="true">Notas</button>
      <button type="button" class="aba" id="tab-observacoes" role="tab" aria-selected="false">Observações</button>
    </div>

    <div id="painel-notas">
      <div class="tabela-container">
        <table class="tabela">
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
    </div>

    <div id="painel-observacoes" style="display:none;">
      <div class="area-conteudo">
        <%
          boolean temObs = false;

          if (boletim != null) {
            for (TurmaAlunoDTO ta : boletim) {
              if (ta.getObservacoes() != null && !ta.getObservacoes().isEmpty()) {
                temObs = true;
        %>
        <article class="card-observacao">
          <div class="barra-lateral"></div>
          <div class="observacao-conteudo">
            <div class="observacao-topo">
              <div class="disciplina"><%= ta.getTurma().getDisciplina().getNome() %></div>
              <div class="professor">Professor(a): Ana Souza</div>
            </div>
            <div class="observacao-texto">
              <%= ta.getObservacoes() %>
            </div>
          </div>
        </article>
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
    </div>
  </section>
</main>
</body>
</html>
