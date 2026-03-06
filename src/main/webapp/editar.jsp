<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 19/02/2026
  Time: 01:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.escola_backend_v2.DTO.*" %>

<html>
<head>
  <title>Editar</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
  <link rel="stylesheet" href="styles/style.css">
  <link rel="stylesheet" href="styles/styleAdmin.css">
  <title>Cruz Azul – Portal do Administrador</title>
</head>
<body class="popup-body">

<h2 style="margin-bottom: 30px; margin-top: 100px; font-weight: 600; text-align: center; color: var(--corAzul);">Editar Registro</h2>

<%
  String tipo = (String) request.getAttribute("tipo");
%>

<%-- ========================= PROFESSOR ========================= --%>
<%
  if ("professor".equals(tipo)) {
    ProfessorDTO p = (ProfessorDTO) request.getAttribute("professor");
    List<TurmaDTO> listaTurmas = (List<TurmaDTO>) request.getAttribute("listaTurmas");
%>

<div class="popup">
  <div class="popup-topo">
    <h2>Informações</h2>

    <button onclick="voltar()" type="button" class="fechar" aria-label="Fechar">✕</button>
  </div>
  <form method="post" action="admin" class="popup-form">
    <input type="hidden" name="acao" value="alterar">
    <input type="hidden" name="tipo" value="<%= tipo %>">
    <input type="hidden" name="id" value="<%= p.getId() %>">

    <div>
      <label for="">Nome</label>
      <input type="text" name="nome" placeholder="Nome" value="<%= p.getNome() %>" required>
    </div>
    <div>
      <label for="">Email</label>
      <input type="email" name="email" placeholder="Email" value="<%= p.getEmail() %>" required>
    </div>
    <div>
      <label for="">Senha</label>
      <input type="text" name="senha" placeholder="Senha" value="<%= p.getSenha() %>" required>
    </div>
    <div>
      <label for="">Turmas</label>
      <select name="turmas" required>
        <%
          for(TurmaDTO t : listaTurmas){
            boolean selecionado = false;

            if(p.getTurmas() != null){
              for(TurmaDTO tp : p.getTurmas()){
                if(tp.getId() == t.getId()){
                  selecionado = true;
                  break;
                }
              }
            }
        %>
        <option value="<%= t.getId() %>" <%= selecionado ? "selected" : "" %>>
          <%= t.getDisciplina().getNome() %> - <%= t.getPeriodoLetivo() %>
        </option>
        <% } %>
      </select>
    </div>
    <button type="submit" class="confirmar">Salvar</button>
  </form>
</div>

<%
  }
%>

<%-- ========================= ALUNO ========================= --%>
<%
  if ("aluno".equals(tipo)) {
    AlunoDTO a = (AlunoDTO) request.getAttribute("aluno");
    List<TurmaDTO> listaTurmas = (List<TurmaDTO>) request.getAttribute("listaTurmas");
%>

<div class="popup">
  <div class="popup-topo">
    <h2>Informações</h2>

    <button onclick="voltar()" type="button" class="fechar" aria-label="Fechar">✕</button>
  </div>
  <form method="post" action="admin" class="popup-form">
    <input type="hidden" name="acao" value="alterar">
    <input type="hidden" name="tipo" value="<%= tipo %>">
    <input type="hidden" name="id" value="<%= a.getId() %>">

    <div>
      <label for="">Nome</label>
      <input type="text" name="nome" placeholder="Nome" value="<%= a.getNome() %>" required>
    </div>
    <div>
      <label for="">Email</label>
      <input type="text" name="email" placeholder="Email" value="<%= a.getEmail() %>" required>
    </div>
    <div>
      <label for="">CPF</label>
      <input type="text" name="cpf" placeholder="CPF" value="<%= a.getCpf() %>" required>
    </div>
    <div>
      <label for="">Matrícula</label>
      <input type="text" name="matricula" placeholder="Matrícula" value="<%= a.getMatricula() %>" required>
    </div>
    <div>
      <label for="">Turma</label>
      <select name="idSala" required>
        <%
          if(listaTurmas != null){
            for(TurmaDTO t : listaTurmas){
              boolean selecionado = false;

              if(a.getMatriculas() != null){
                for(TurmaAlunoDTO ta : a.getMatriculas()){
                  if(ta.getTurma().getId() == t.getId()){
                    selecionado = true;
                    break;
                  }
                }
              }
        %>
        <option value="<%= t.getId() %>" <%= selecionado ? "selected" : "" %>>
          <%= t.getDisciplina().getNome() %> - <%= t.getPeriodoLetivo() %>
        </option>
        <%
            }
          }
        %>
      </select>
    </div>
    <button type="submit" class="confirmar">Salvar</button>
  </form>
</div>

<%
  }
%>

<%-- ========================= DISCIPLINA ========================= --%>
<%
  if ("disciplina".equals(tipo)) {
    DisciplinaDTO d = (DisciplinaDTO) request.getAttribute("disciplina");
%>

<div class="popup">
  <div class="popup-topo">
    <h2>Informações</h2>

    <button onclick="voltar()" type="button" class="fechar" aria-label="Fechar">✕</button>
  </div>
  <form method="post" action="admin" class="popup-form">
    <input type="hidden" name="acao" value="alterar">
    <input type="hidden" name="tipo" value="<%= tipo %>">
    <input type="hidden" name="id" value="<%= d.getId() %>">

    <div>
      <label for="">Nome da Disciplina</label>
      <input type="text" name="nome" placeholder="Disciplina" value="<%= d.getNome() %>" required>
    </div>
    <div>
      <label for="">Carga Horária</label>
      <input type="text" name="cargaHoraria" placeholder="Carga Horária" value="<%= d.getCargaHoraria() %>" required>
    </div>

    <button type="submit" class="confirmar">Salvar</button>
  </form>
</div>

<%
  }
%>
<%-- ========================= SALA ========================= --%>
<%
  if ("sala".equals(tipo)) {
    SalaDTO s = (SalaDTO) request.getAttribute("sala");
%>

<div class="popup">
  <div class="popup-topo">
    <h2>Informações</h2>

    <button onclick="voltar()" type="button" class="fechar" aria-label="Fechar">✕</button>
  </div>
  <form method="post" action="admin" class="popup-form">
    <input type="hidden" name="acao" value="alterar">
    <input type="hidden" name="tipo" value="<%= tipo %>">
    <input type="hidden" name="id" value="<%= s.getId() %>">

    <div>
      <label>Nome da Sala</label>
      <input type="text" name="nomeSala" id="sala-edit-nomeSala" placeholder="Nome da Sala" value="<%= s.getNome() %>" required>
    </div>
    <div>
      <label>Capacidade</label>
      <input type="number" name="capacidade" id="sala-edit-capacidade" placeholder="Capacidade" value="<%= s.getCapacidade() %>" required>
    </div>
    <button type="submit" class="confirmar">Salvar</button>
  </form>
</div>

<%
  }
%>

<%-- ========================= TURMA ========================= --%>
<%
  if ("turma".equals(tipo)) {
    TurmaDTO t = (TurmaDTO) request.getAttribute("turma");
    List<DisciplinaDTO> listaDisciplinas = (List<DisciplinaDTO>) request.getAttribute("listaDisciplinas");
    List<SalaDTO> listaSalas = (List<SalaDTO>) request.getAttribute("listaSalas");
%>

<div class="popup">
  <div class="popup-topo">
    <h2>Informações</h2>

    <button onclick="voltar()" type="button" class="fechar" aria-label="Fechar">✕</button>
  </div>
  <form method="post" action="admin" class="popup-form">
    <input type="hidden" name="acao" value="alterar">
    <input type="hidden" name="tipo" value="<%= tipo %>">
    <input type="hidden" name="id" value="<%= t.getId() %>">

    <div>
      <label for="">Disciplina</label>
      <select name="idDisciplina" required>
        <% for(DisciplinaDTO d : listaDisciplinas){ %>
        <option value="<%= d.getId() %>"
                <%= d.getId() == t.getDisciplina().getId() ? "selected" : "" %>>
          <%= d.getNome() %>
        </option>
        <% } %>
      </select>
    </div>
    <div>
      <label for="">Sala</label>
      <select name="idDisciplina" required>
        <% for(SalaDTO s : listaSalas){ %>
        <option value="<%= s.getId() %>"
                <%= s.getId() == t.getSala().getId() ? "selected" : "" %>>
          <%= s.getNome() %>
        </option>
        <% } %>
      </select>
    </div>
    <div>
      <label for="">Período Letivo</label>
      <input type="text" name="periodoLetivo" placeholder="Ex: 2026/1" value="<%= t.getPeriodoLetivo() %>" required>
    </div>

    <button type="submit" class="confirmar">Salvar</button>
  </form>
</div>

<%
  }
%>

<script>
  function voltar() {
    window.history.back();
  }
</script>
</body>
</html>
