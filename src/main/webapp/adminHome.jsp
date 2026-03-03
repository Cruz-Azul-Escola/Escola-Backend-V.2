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
        <button onclick="mostrar('secao-aluno', 'view-alunos')" id="view-alunos" class="views">Alunos</button>
        <button onclick="mostrar('secao-professor', 'view-professores')" id="view-professores" class="views">Professores</button>
        <button onclick="mostrar('secao-turma', 'view-turmas')"  id="view-turmas" class="views">Turmas</button>
        <button onclick="mostrar('secao-disciplina', 'view-disciplinas')" id="view-disciplinas" class="views">Disciplinas</button>
        <button onclick="mostrar('secao-sala', 'view-salas')" id="view-salas" class="views">Salas</button>
        <button onclick="mostrar('secao-vinculo', 'view-vinculacoes')" id="view-vinculacoes" class="views">Vinculações</button>
    </section>
    <section id="content-panel">
        <!-- ALUNOS -->
        <div id="secao-aluno" class="secoes">
            <h2>Cadastro de Aluno</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarAluno">
                <div>
                    <label for="">Nome</label>
                    <input type="text" name="nome" placeholder="Nome" required>
                </div>
                <div>
                    <label for="">CPF</label>
                    <input type="text" id="cpf" maxlength="14" placeholder="000.000.000-00" autocomplete="off" required>
                </div>
                <div>
                    <label for="">Sala</label>
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
                </div>
                <button type="submit">Salvar</button>
            </form>
            <hr>

            <h3>Alunos Cadastrados</h3>
            <div>
                <label>Filtro</label>
                <input id="filtro" type="text" >
            </div>

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
                    <tr class="item-linha">
                        <td><%= a.getId() %></td>
                        <td class="nomeItemLinha"><%= a.getNome() %></td>
                        <td><%= a.getCpf() %></td>
                        <td><%= a.getMatricula() %></td>
                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="acao" value="editarAluno">
                                <input type="hidden" name="id" value="<%= a.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>

                            <form onsubmit="return validarFormulario();" method="post" action="admin" style="display:inline;">
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
        <div id="secao-professor" class="secoes">
            <h2>Cadastro de Professor</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarProfessor">
                <div>
                    <label for="">Nome</label>
                    <input type="text" name="nome" placeholder="Nome" required>
                </div>
                <div>
                    <label for="">Email</label>
                    <input type="email" name="email" placeholder="Email" required>
                </div>
                <div>
                    <label for="">Senha</label>
                    <input type="password" name="senha" placeholder="Senha" required>
                </div>
                <div>
                    <label for="">Turma</label>
                    <select name="idTurma" required>
                        <option value="">Selecione a Turma</option>
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
                </div>
                <button type="submit">Salvar</button>
            </form>
            <hr>


            <h3>Professores Cadastrados</h3>
            <div>
                <label>Filtro</label>
                <input id="filtro2" type="text" >
            </div>
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
                    <tr class="item-linha">
                        <td><%= p.getId() %></td>
                        <td class="nomeItemLinha"><%= p.getNome() %></td>
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

                            <form onsubmit="return validarFormulario();" method="post" action="admin" style="display:inline;">
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
        <div id="secao-disciplina" class="secoes">
            <h2>Cadastro de Disciplina</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarDisciplina">
                <div>
                    <label for="">Disciplina</label>
                    <input type="text" name="nomeDisciplina" placeholder="Nome da Disciplina" required>
                </div>
                <div>
                    <label for="">Carga Horária</label>
                    <input type="number" name="cargaHoraria" placeholder="Carga Horária" required>
                </div>
                <button type="submit">Salvar</button>
            </form>
            <hr>

            <h3>Disciplinas Cadastradas</h3>
            <div>
                <label>Filtro</label>
                <input id="filtro3" type="text" >
            </div>

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
                    <tr class="item-linha">
                        <td><%= d.getId() %></td>
                        <td class="nomeItemLinha"><%= d.getNome() %></td>
                        <td><%= d.getCargaHoraria() %>h</td>
                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="tipo" value="disciplina">
                                <input type="hidden" name="id" value="<%= d.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>



                            <form onsubmit="return validarFormulario();" method="post" action="admin" style="display:inline;">
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
        <div id="secao-sala" class="secoes">
            <h2>Cadastro de Sala</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarSala">
                <div>
                    <label for="">Sala</label>
                    <input type="text" name="nomeSala" placeholder="Nome ou Número da Sala" required>
                </div>
                <div>
                    <label for="">Capacidade</label>
                    <input type="number" name="capacidade" placeholder="Capacidade" required>
                </div>
                <button type="submit">Salvar</button>
            </form>
            <hr>

            <h3>Salas Cadastradas</h3>
            <div>
                <label>Filtro</label>
                <input id="filtro4" type="text" >
            </div>
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
                    <tr class="item-linha">
                        <td><%= s.getId() %></td>
                        <td class="nomeItemLinha"><%= s.getNome() %></td>
                        <td><%= s.getCapacidade() %></td>
                        <td style="display: flex; justify-content: space-evenly">
                            <form method="post" action="admin" style="display:inline;">
                                <input type="hidden" name="tipo" value="sala">
                                <input type="hidden" name="id" value="<%= s.getId() %>">
                                <button class="btn-acao btn-editar" type="submit">Editar</button>
                            </form>


                            <form onsubmit="return validarFormulario();" method="post" action="admin" style="display:inline;">
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
        <div id="secao-turma" class="secoes">
            <h2>Cadastro de Turma</h2>
            <form method="post" action="admin">
                <input type="hidden" name="acao" value="salvarTurma">
                <div>
                    <label>Disciplina</label>
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
                </div>
                <div>
                    <label>Sala</label>
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
                </div>
                <div>
                    <label>Período Letivo</label>
                    <input type="text" name="periodoLetivo" placeholder="Ex: 2026/1" required>
                </div>
                <button type="submit">Salvar</button>
            </form>
        </div>

        <!-- VINCULAÇÕES -->
        <div id="secao-vinculo" class="secoes">
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
    function mostrar(id , button) {
        document.querySelectorAll('.secoes').forEach(div => {
            div.classList.remove('ativa');
        });
        document.getElementById(id).classList.add('ativa');

        document.querySelectorAll('.views').forEach(buttons => {
            buttons.style.backgroundColor = "transparent";
            buttons.style.color = "white";
        })
        document.getElementById(button).style.backgroundColor = "white";
        document.getElementById(button).style.color = "var(--corAzul)";
    }
    function validarFormulario() {
        return confirm("Deseja excluir registro?");
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
    document.getElementById("filtro2").addEventListener("keyup", function () {
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
    document.getElementById("filtro3").addEventListener("keyup", function () {
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
    document.getElementById("filtro4").addEventListener("keyup", function () {
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
<script src="scripts/scriptValidacaoCpf.js"></script>
</body>
</html>
