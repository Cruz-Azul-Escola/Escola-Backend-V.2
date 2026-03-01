<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 16/02/2026
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.escola_backend_v2.DTO.*" %>
<%@ page import="com.example.escola_backend_v2.DAO.ProfessorDAO" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/styleAdmin.css">
    <script defer src="scripts/scriptAdmin.js"></script>
    <title>Cruz Azul – Portal do Administrador</title>
</head>
<style>
    body {
        margin: 0;
        font-family: Arial;
        background: #f1f3f8;
    }

    .topbar {
        background: #1e4b9a;
        color: white;
        padding: 15px;
        display: flex;
        justify-content: space-between;
    }

    .menu {
        display: flex;
        background: #1e4b9a;
        padding: 10px;
    }

    .menu button {
        background: white;
        border: none;
        padding: 10px 20px;
        margin-right: 10px;
        cursor: pointer;
    }

    .content-panel {
        padding: 30px;
    }

    .aba {
        display: none;
    }

    .aba.ativa {
        display: block;
    }

    .mensagem {
        color: green;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .erro {
        color: red;
        font-weight: bold;
        margin-bottom: 15px;
    }

</style>
<body>

<%
    List<ProfessorDTO> listaProfessores = (List<ProfessorDTO>) request.getAttribute("listaProfessores");
    List<AlunoDTO> listaAlunos = (List<AlunoDTO>) request.getAttribute("listaAlunos");
    List<SalaDTO> listaSalas = (List<SalaDTO>) request.getAttribute("listaSalas");
    List<TurmaDTO> listaTurmas = (List<TurmaDTO>) request.getAttribute("listaTurmas");
    List<DisciplinaDTO> listaDisciplinas = (List<DisciplinaDTO>) request.getAttribute("listaDisciplinas");

%>
<header>
    <div id="logotipo">
        <div>
            <img src="assets/icons/Logo da escola.png" alt="">
        </div>
        <div>
            <h1>Cruz Azul</h1>
            <h4>Portal do Administrador</h4>
        </div>
    </div>
    <a href="logarAdm.jsp">
        <div id="voltar">
            <h4 >➜ Sair </h4>
        </div>
    </a>
</header>
<main id="admin-main">
    <section id="welcome-card">
        <div id="welcome-banner">
            Bem-vindo, Administrador!
        </div>
    </section>
    <section id="toolbar">
        <button onclick="mostrar('alunos')" id="view-alunos" class="views">Alunos</button>
        <button onclick="mostrar('professores')" id="view-professores" class="views">Professores</button>
        <button onclick="mostrar('turmas')"  id="view-turmas" class="views">Turmas</button>
        <button onclick="mostrar('disciplinas')" id="view-disciplinas" class="views">Disciplinas</button>
        <button onclick="mostrar('salas')" id="view-salas" class="views">Salas</button>
        <button onclick="mostrar('vinculos')" id="view-vinculacoes" class="views">Vinculações</button>
    </section>
    <section id="content-panel">
        <!-- ALUNOS -->
        <div id="alunos" class="aba">
            <h2>Cadastro de Aluno</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarAluno">
                <input type="text" name="nome" placeholder="Nome" required>
                <input        type="text"
                              id="cpf"
                              maxlength="14"
                              placeholder="000.000.000-00"
                              autocomplete="off" required>
                <select name="idSala" required>
                    <option value="">Selecione a Sala</option>
                    <%
                        List<SalaDTO> salas = (List<SalaDTO>) request.getAttribute("listaSalas");
                        if(salas != null){
                            for(SalaDTO sala : salas){
                    %>
                    <option value="<%= sala.getId() %>"><%= sala.getNome() %> (Capacidade: <%= sala.getCapacidade() %>)</option>
                    <%
                            }
                        }
                    %>
                </select>
                <button type="submit">Salvar</button>
            </form>
            <hr>
            <h3>Alunos Cadastrados</h3>

            <div class="tabela-container">
                <% if(listaAlunos != null && !listaAlunos.isEmpty()) { %>

                <table class="tabela" border="1" cellpadding="5">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>CPF</th>
                        <th>Matrícula</th>
                        <th>Ações</th>
                    </tr>

                    <% for(AlunoDTO a : listaAlunos) { %>
                    <tr>
                        <td><%= a.getId() %></td>
                        <td><%= a.getNome() %></td>
                        <td><%= a.getCpf() %></td>
                        <td><%= a.getMatricula() %></td>
                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="acao" value="editarAluno">
                                <input type="hidden" name="id" value="<%= a.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>

                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="acao" value="excluirAluno">
                                <input type="hidden" name="id" value="<%= a.getId() %>">
                                <button class="btn-acao btn-excluir" type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <% } else { %>
                <p>Nenhum aluno cadastrado.</p>
                <% } %>
            </div>
        </div>

        <!-- PROFESSORES -->
        <div id="professores" class="aba">
            <h2>Cadastro de Professor</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarProfessor">
                <input type="text" name="nome" placeholder="Nome" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="senha" placeholder="Senha" required>
                <select name="turmaIds" multiple size="5">
                    <%
                        List<TurmaDTO> turmas = (List<TurmaDTO>) request.getAttribute("listaTurmas");
                        if(turmas != null){
                            for(TurmaDTO t : turmas){
                    %>
                    <option value="<%= t.getId() %>"><%= t.getPeriodoLetivo() %> - Sala: <%= t.getSala().getNome() %> - Disciplina: <%= t.getDisciplina().getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>
                <button type="submit">Salvar</button>
            </form>
            <hr>
            <h3>Professores Cadastrados</h3>

            <div class="tabela-container">
                <% if(listaProfessores != null && !listaProfessores.isEmpty()) { %>
                <table class="tabela" border="1" cellpadding="5">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Email</th>
                        <th>Ativo</th>
                        <th>Disciplinas</th>
                        <th>Ações</th>
                    </tr>

                    <% ProfessorDAO professorDAO = new ProfessorDAO();
                        for(ProfessorDTO p : listaProfessores) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getNome() %></td>
                        <td><%= p.getEmail() %></td>
                        <td><%= p.isEstaAtivo() ? "Sim" : "Não" %></td>
                        <td>
                            <%
                                List<DisciplinaDTO> disciplinas = professorDAO.listarDisciplinasDoProfessor(p.getId());

                                if(disciplinas != null && !disciplinas.isEmpty()){
                                    for(DisciplinaDTO d : disciplinas){
                            %>
                            <%= d.getNome() %><br>
                            <%
                                }
                            } else {
                            %>
                            Nenhuma
                            <%
                                }
                            %>
                        </td>

                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="tipo" value="professor">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>

                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="acao" value="excluirProfessor">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button class="btn-acao btn-excluir" type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <% } else { %>
                <p>Nenhum professor cadastrado.</p>
                <% } %>
            </div>
        </div>

        <!-- DISCIPLINAS -->
        <div id="disciplinas" class="aba">
            <h2>Cadastro de Disciplina</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarDisciplina">
                <input type="text" name="nomeDisciplina" placeholder="Nome da Disciplina" required>
                <input type="number" name="cargaHoraria" placeholder="Carga Horária" required>
                <button type="submit">Salvar</button>
            </form>
            <hr>
            <h3>Disciplinas Cadastradas</h3>

            <div class="tabela-container">


                <% if(listaDisciplinas != null && !listaDisciplinas.isEmpty()) { %>
                <table class="tabela" border="1" cellpadding="5">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Carga Horária</th>
                        <th>Ações</th>
                    </tr>

                    <% for(DisciplinaDTO d : listaDisciplinas) { %>
                    <tr>
                        <td><%= d.getId() %></td>
                        <td><%= d.getNome() %></td>
                        <td><%= d.getCargaHoraria() %>h</td>
                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="tipo" value="disciplina">
                                <input type="hidden" name="id" value="<%= d.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>



                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="acao" value="excluirDisciplina">
                                <input type="hidden" name="id" value="<%= d.getId() %>">
                                <button class="btn-acao btn-excluir" type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <% } else { %>
                <p>Nenhuma disciplina cadastrada.</p>
                <% } %>
            </div>
        </div>

        <!-- SALAS -->
        <div id="salas" class="aba">
            <h2>Cadastro de Sala</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarSala">
                <input type="text" name="nomeSala" placeholder="Nome ou Número da Sala" required>
                <input type="number" name="capacidade" placeholder="Capacidade" required>
                <button type="submit">Salvar</button>
            </form>
            <hr>
            <h3>Salas Cadastradas</h3>

            <div class="tabela-container">


                <% if(listaSalas != null && !listaSalas.isEmpty()) { %>
                <table class="tabela" border="1" cellpadding="5">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Capacidade</th>
                        <th>Ações</th>
                    </tr>

                    <% for(SalaDTO s : listaSalas) { %>
                    <tr>
                        <td><%= s.getId() %></td>
                        <td><%= s.getNome() %></td>
                        <td><%= s.getCapacidade() %></td>
                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="tipo" value="sala">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>


                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="acao" value="excluirSala">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <button class="btn-acao btn-excluir" type="submit">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <% } else { %>
                <p>Nenhuma sala cadastrada.</p>
                <% } %>
            </div>
        </div>

        <!-- TURMAS -->
        <div id="turmas" class="aba">
            <h2>Cadastro de Turma</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarTurma">
                <label>Disciplina:</label>
                <select name="idDisciplina" required>
                    <option value="">Selecione a Disciplina</option>
                    <%
                        List<DisciplinaDTO> disciplinas = (List<DisciplinaDTO>) request.getAttribute("listaDisciplinas");
                        if(disciplinas != null){
                            for(DisciplinaDTO d : disciplinas){
                    %>
                    <option value="<%= d.getId() %>"><%= d.getNome() %> (Carga: <%= d.getCargaHoraria() %>h)</option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Sala:</label>
                <select name="idSala" required>
                    <option value="">Selecione a Sala</option>
                    <%
                        if(salas != null){
                            for(SalaDTO s : salas){
                    %>
                    <option value="<%= s.getId() %>"><%= s.getNome() %> (Capacidade: <%= s.getCapacidade() %>)</option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Período Letivo:</label>
                <input type="text" name="periodoLetivo" placeholder="Ex: 2026/1" required>

                <button type="submit">Salvar</button>
            </form>
        </div>

        <!-- VINCULAÇÕES -->
        <div id="vinculos" class="aba">
            <h2>Vinculações</h2>

            <!-- Aluno em Turma -->
            <h3>Matricular Aluno</h3>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="vincularAlunoTurma">
                <select name="idAluno" required>
                    <option value="">Selecione o Aluno</option>
                    <%
                        List<AlunoDTO> alunos = (List<AlunoDTO>) request.getAttribute("listaAlunos");
                        if(alunos != null){
                            for(AlunoDTO a : alunos){
                    %>
                    <option value="<%= a.getId() %>"><%= a.getNome() %> - Matrícula: <%= a.getMatricula() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <select name="idTurma" required>
                    <option value="">Selecione a Turma</option>
                    <%
                        if(turmas != null){
                            for(TurmaDTO t : turmas){
                    %>
                    <option value="<%= t.getId() %>"><%= t.getPeriodoLetivo() %> - Sala: <%= t.getSala().getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <button type="submit">Matricular</button>
            </form>

            <!-- Professor em Disciplina -->
            <h3>Vincular Professor à Disciplina</h3>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="vincularProfessorDisciplina">
                <select name="idProfessor" required>
                    <option value="">Selecione o Professor</option>
                    <%
                        if(listaProfessores != null){
                            for(ProfessorDTO p : (List<ProfessorDTO>)request.getAttribute("listaProfessores")){
                    %>
                    <option value="<%= p.getId() %>"><%= p.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <select name="idDisciplina" required>
                    <option value="">Selecione a Disciplina</option>
                    <%
                        if(disciplinas != null){
                            for(DisciplinaDTO d : disciplinas){
                    %>
                    <option value="<%= d.getId() %>"><%= d.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <button type="submit">Vincular</button>
            </form>

            <!-- Professor em Turma -->
            <h3>Vincular Professor à Turma</h3>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="vincularProfessorTurma">
                <select name="idProfessor" required>
                    <option value="">Selecione o Professor</option>
                    <%
                        if(listaProfessores != null){
                            for(ProfessorDTO p : (List<ProfessorDTO>)request.getAttribute("listaProfessores")){
                    %>
                    <option value="<%= p.getId() %>"><%= p.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <select name="idTurma" required>
                    <option value="">Selecione a Turma</option>
                    <%
                        if(turmas != null){
                            for(TurmaDTO t : turmas){
                    %>
                    <option value="<%= t.getId() %>"><%= t.getPeriodoLetivo() %> - Sala: <%= t.getSala().getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <button type="submit">Vincular</button>
            </form>
        </div>

    </section>
    </main>

<script>
    function mostrar(id) {
        document.querySelectorAll('.aba').forEach(div => {
            div.classList.remove('ativa');
        });
        document.getElementById(id).classList.add('ativa');
    }

</script>
<script src="scripts/scriptValidacaoCpf.js"></script>
</body>
</html>
