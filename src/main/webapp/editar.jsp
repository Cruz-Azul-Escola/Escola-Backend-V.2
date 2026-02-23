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

</head>
<body>

<h2>Editar Registro</h2>

<%
  String tipo = (String) request.getAttribute("tipo");
%>

<form action="admin" method="post">
  <input type="hidden" name="acao" value="alterar">
  <input type="hidden" name="tipo" value="<%= tipo %>">

  <%-- ========================= PROFESSOR ========================= --%>
  <%
    if ("professor".equals(tipo)) {
      ProfessorDTO p = (ProfessorDTO) request.getAttribute("professor");
      List<TurmaDTO> listaTurmas = (List<TurmaDTO>) request.getAttribute("listaTurmas");
  %>

  <input type="hidden" name="id" value="<%= p.getId() %>">

  Nome: <br>
  <input type="text" name="nome" value="<%= p.getNome() %>"><br><br>

  Email: <br>
  <input type="text" name="email" value="<%= p.getEmail() %>"><br><br>

  Senha: <br>
  <input type="password" name="senha" value="<%= p.getSenha() %>"><br><br>

  Turmas:<br>
  <select name="turmaIds" multiple size="5">
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

  <%
    }
  %>

  <%-- ========================= ALUNO ========================= --%>
  <%
    if ("aluno".equals(tipo)) {
      AlunoDTO a = (AlunoDTO) request.getAttribute("aluno");
      List<TurmaDTO> listaTurmas = (List<TurmaDTO>) request.getAttribute("listaTurmas");
  %>

  <input type="hidden" name="id" value="<%= a.getId() %>">

  Nome:<br>
  <input type="text" name="nome" value="<%= a.getNome() %>"><br><br>

  Email:<br>
  <input type="text" name="email" value="<%= a.getEmail() %>"><br><br>

  CPF:<br>
  <input type="text" name="cpf" value="<%= a.getCpf() %>"><br><br>

  Matrícula:<br>
  <input type="text" name="matricula" value="<%= a.getMatricula() %>"><br><br>

  Turmas:<br>
  <select name="turmaIds" multiple size="5">
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

  <%
    }
  %>

  <%-- ========================= DISCIPLINA ========================= --%>
  <%
    if ("disciplina".equals(tipo)) {
      DisciplinaDTO d = (DisciplinaDTO) request.getAttribute("disciplina");
  %>

  <input type="hidden" name="id" value="<%= d.getId() %>">

  Nome da Disciplina:<br>
  <input type="text" name="nome" value="<%= d.getNome() %>"><br><br>

  Carga Horária:<br>
  <input type="number" name="cargaHoraria" value="<%= d.getCargaHoraria() %>"><br><br>

  <%
    }
  %>
  <%-- ========================= SALA ========================= --%>
  <%
    if ("sala".equals(tipo)) {
      SalaDTO s = (SalaDTO) request.getAttribute("sala");
  %>

  <input type="hidden" name="id" value="<%= s.getId() %>">

  Nome da Sala:<br>
  <input type="text" name="nomeSala" value="<%= s.getNome() %>"><br><br>

  Capacidade:<br>
  <input type="number" name="capacidade" value="<%= s.getCapacidade() %>"><br><br>

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

  <input type="hidden" name="id" value="<%= t.getId() %>">

  Período Letivo:<br>
  <input type="text" name="periodoLetivo" value="<%= t.getPeriodoLetivo() %>"><br><br>

  Disciplina:<br>
  <select name="idDisciplina">
    <% for(DisciplinaDTO d : listaDisciplinas){ %>
    <option value="<%= d.getId() %>"
            <%= d.getId() == t.getDisciplina().getId() ? "selected" : "" %>>
      <%= d.getNome() %>
    </option>
    <% } %>
  </select><br><br>

  Sala:<br>
  <select name="idSala">
    <% for(SalaDTO s : listaSalas){ %>
    <option value="<%= s.getId() %>"
            <%= s.getId() == t.getSala().getId() ? "selected" : "" %>>
      <%= s.getNome() %>
    </option>
    <% } %>
  </select>

  <%
    }
  %>

  <br><br>
  <button type="submit">Salvar Alterações</button>
</form>

<br>
<a href="admin?acao=listar">Voltar</a>

</body>
</html>
