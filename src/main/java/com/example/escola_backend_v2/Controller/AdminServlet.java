package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.*;
import com.example.escola_backend_v2.DTO.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private AlunoDAO alunoDAO = new AlunoDAO();
    private ProfessorDAO professorDAO = new ProfessorDAO();
    private DisciplinaDAO disciplinaDAO = new DisciplinaDAO();
    private SalaDAO salaDAO = new SalaDAO();
    private TurmaDAO turmaDAO = new TurmaDAO();


    @Override
    //primeiro carrego dados da home
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        carregarListas(request);
        request.getRequestDispatcher("adminHome.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("alterar".equals(acao)) {
            alterar(request, response);
            return;
        }

        if (request.getParameter("tipo") != null && acao == null) {
            abrirTelaEdicao(request, response);
            return;
        }

        switch (acao) {
            case "salvarAluno":
                cadastrarAluno(request, response);
                break;

            case "salvarProfessor":
                cadastrarProfessor(request, response);
                break;

            case "salvarDisciplina":
                cadastrarDisciplina(request, response);
                break;

            case "salvarSala":
                cadastrarSala(request, response);
                break;

            case "salvarTurma":
                cadastrarTurma(request, response);
                break;
            case "editarAluno":
                carregarListas(request);
                editarAluno(request, response);
                break;

            case "excluirAluno":
                excluirAluno(request, response);
                break;

            case "atualizarAluno":
                atualizarAluno(request, response);
                break;
            case "excluirSala":
                salaDAO.excluir(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("admin");
                break;

            case "excluirDisciplina":
                disciplinaDAO.excluirDisciplina(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("admin");
                break;

            case "excluirProfessor":
                professorDAO.desativar(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("admin");
                break;
            case "vincularAlunoTurma":
                vincularAlunoTurma(request, response);
                break;

            case "vincularProfessorDisciplina":
                vincularProfessorDisciplina(request, response);
                break;

            case "vincularProfessorTurma":
                vincularProfessorTurma(request, response);
                break;
            default:
                enviarErro(request, response, "Ação inválida.");
        }
    }

    private void abrirTelaEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipo");
        int id = Integer.parseInt(request.getParameter("id"));

        carregarListas(request); // importante para selects

        switch (tipo) {

            case "professor":
                ProfessorDTO professor = professorDAO.buscarPorId(id);
                request.setAttribute("professor", professor);
                break;

            case "aluno":
                AlunoDTO aluno = alunoDAO.buscarAlunoPorId(id);
                request.setAttribute("aluno", aluno);
                break;
            case "sala":
                SalaDTO sala = salaDAO.buscarSala(id);
                request.setAttribute("sala", sala);
                break;
            case "disciplina":
                DisciplinaDTO disciplina = disciplinaDAO.buscar(id);
                request.setAttribute("disciplina", disciplina);
                break;

        }

        request.setAttribute("tipo", tipo);
        request.getRequestDispatcher("editar.jsp").forward(request, response);
    }

    private void alterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipo");

        try {

            switch (tipo) {

                case "professor":
                    alterarProfessorSimples(request);
                    break;

                case "aluno":
                    alterarAlunoSimples(request);
                    break;

                case "sala":
                    alterarSalaSimples(request);
                    break;

                case "disciplina":
                    System.out.println("editado");

                    alterarDisciplinaSimples(request);
                    break;

            }

            response.sendRedirect("admin");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    private void alterarProfessorSimples(HttpServletRequest request) {

        ProfessorDTO professor = new ProfessorDTO();

        professor.setId(Integer.parseInt(request.getParameter("id")));
        professor.setNome(request.getParameter("nome"));
        professor.setEmail(request.getParameter("email"));
        professor.setSenha(request.getParameter("senha"));

        String[] turmaIds = request.getParameterValues("turmaIds");
        List<Integer> listaTurmas = new ArrayList<>();

        if (turmaIds != null) {
            for (String t : turmaIds) {
                listaTurmas.add(Integer.parseInt(t));
            }
        }

        professorDAO.atualizarProfessorCompleto(professor, listaTurmas);
    }
    private void alterarAlunoSimples(HttpServletRequest request) {

        AlunoDTO aluno = new AlunoDTO();

        aluno.setId(Integer.parseInt(request.getParameter("id")));
        aluno.setNome(request.getParameter("nome"));
        aluno.setEmail(request.getParameter("email"));
        aluno.setCpf(request.getParameter("cpf"));
        aluno.setMatricula(request.getParameter("matricula"));
        aluno.setEstaAtivo(true);

        String[] turmaIds = request.getParameterValues("turmaIds");
        List<TurmaAlunoDTO> lista = new ArrayList<>();

        if (turmaIds != null) {
            for (String idTurma : turmaIds) {
                TurmaDTO turma = new TurmaDTO();
                turma.setId(Integer.parseInt(idTurma));

                TurmaAlunoDTO ta = new TurmaAlunoDTO();
                ta.setTurma(turma);

                lista.add(ta);
            }
        }

        aluno.setMatriculas(lista);

        alunoDAO.alterarAlunoCompleto(aluno);
    }

    private void alterarDisciplinaSimples(HttpServletRequest request) {

        DisciplinaDTO disciplina = new DisciplinaDTO();

        disciplina.setId(Integer.parseInt(request.getParameter("id")));
        disciplina.setNome(request.getParameter("nome"));
        disciplina.setCargaHoraria(Integer.parseInt(request.getParameter("cargaHoraria")));

        disciplinaDAO.editarDisciplina(disciplina);
        System.out.println("editado");
    }

    private void alterarSalaSimples(HttpServletRequest request) {

        SalaDTO sala = new SalaDTO();

        sala.setId(Integer.parseInt(request.getParameter("id")));
        sala.setNome(request.getParameter("nomeSala"));
        sala.setCapacidade(Integer.parseInt(request.getParameter("capacidade")));
        salaDAO.editarSala(sala);
    }




    private void carregarListas(HttpServletRequest request) {
        List<AlunoDTO> listaAlunos = alunoDAO.listarAlunos();
        List<ProfessorDTO> listaProfessores = professorDAO.listarProfessores();
        List<DisciplinaDTO> listaDisciplinas = disciplinaDAO.listarDisciplina();
        List<SalaDTO> listaSalas = salaDAO.listarSalas();
        List<TurmaDTO> listaTurmas = turmaDAO.listarTurmas();

        request.setAttribute("listaAlunos", listaAlunos);
        request.setAttribute("listaProfessores", listaProfessores);
        request.setAttribute("listaDisciplinas", listaDisciplinas);
        request.setAttribute("listaSalas", listaSalas);
        request.setAttribute("listaTurmas", listaTurmas);
    }

    private void enviarMensagem(HttpServletRequest req, HttpServletResponse resp, String mensagem)
            throws ServletException, IOException {
        req.setAttribute("mensagem", mensagem);
        carregarListas(req);
        req.getRequestDispatcher("adminHome.jsp").forward(req, resp);
    }

    private void enviarErro(HttpServletRequest req, HttpServletResponse resp, String erro)
            throws ServletException, IOException {
        req.setAttribute("erro", erro);
        carregarListas(req);
        req.getRequestDispatcher("adminHome.jsp").forward(req, resp);
    }


    private void cadastrarAluno(HttpServletRequest request, HttpServletResponse response) {
        try {
            String cpf = request.getParameter("cpf");

            AlunoDTO aluno = new AlunoDTO();
            aluno.setNome(request.getParameter("nome"));
            aluno.setCpf(cpf);
            aluno.setIdSala(Integer.parseInt(request.getParameter("idSala")));

            AlunoDTO alunoCadastrado = alunoDAO.preCadastro(aluno);

            enviarMensagem(request, response,
                    "Aluno cadastrado com sucesso! Matrícula: " + alunoCadastrado.getMatricula());

        } catch (Exception e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Erro ao cadastrar aluno: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void cadastrarProfessor(HttpServletRequest request, HttpServletResponse response) {
        try {
            String email = request.getParameter("email");


            ProfessorDTO professor = new ProfessorDTO();
            professor.setNome(request.getParameter("nome"));
            professor.setEmail(email);
            professor.setSenha(request.getParameter("senha"));
            professor.setEstaAtivo(true);

            String[] turmaIdsParam = request.getParameterValues("turmaIds");
            List<Integer> turmaIds = new ArrayList<>();
            if (turmaIdsParam != null) {
                for (String idStr : turmaIdsParam) {
                    turmaIds.add(Integer.parseInt(idStr));
                }
            }

            professorDAO.criarProfessorCompleto(professor, turmaIds);

            enviarMensagem(request, response, "Professor cadastrado com sucesso!");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Erro ao cadastrar professor: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }


    private void cadastrarSala(HttpServletRequest request, HttpServletResponse response) {
        try {
            String nomeSala = request.getParameter("nomeSala");
            int capacidade = Integer.parseInt(request.getParameter("capacidade"));


            salaDAO.adicionarSala(nomeSala, capacidade);

            enviarMensagem(request, response, "Sala cadastrada com sucesso!");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Capacidade inválida: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Erro ao cadastrar sala: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void cadastrarTurma(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idDisciplina = Integer.parseInt(request.getParameter("idDisciplina"));
            int idSala = Integer.parseInt(request.getParameter("idSala"));
            String periodoLetivo = request.getParameter("periodoLetivo");



            turmaDAO.adicionarTurma(idDisciplina, idSala, periodoLetivo);

            enviarMensagem(request, response, "Turma cadastrada com sucesso!");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "ID inválido: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Erro ao cadastrar turma: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }


    private void cadastrarDisciplina(HttpServletRequest request, HttpServletResponse response) {
        try {
            String nomeDisciplina = request.getParameter("nomeDisciplina");
            int cargaHoraria = Integer.parseInt(request.getParameter("cargaHoraria"));



            disciplinaDAO.adicionarDisciplina(nomeDisciplina, cargaHoraria);

            enviarMensagem(request, response, "Disciplina cadastrada com sucesso!");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Carga horária inválida: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                enviarErro(request, response, "Erro ao cadastrar disciplina: " + e.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void excluirAluno(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        alunoDAO.excluir(id);

        response.sendRedirect("admin");
    }
    private void editarAluno(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AlunoDTO aluno = alunoDAO.buscarAlunoPorId(id);

        request.setAttribute("aluno", aluno);
        request.setAttribute("tipo", "aluno");

        request.getRequestDispatcher("editar.jsp").forward(request, response);
    }
    private void atualizarAluno(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            AlunoDTO aluno = new AlunoDTO();
            aluno.setId(id);
            aluno.setNome(request.getParameter("nome"));
            aluno.setEmail(request.getParameter("email"));
            aluno.setCpf(request.getParameter("cpf"));
            aluno.setMatricula(request.getParameter("matricula"));
            aluno.setEstaAtivo(Boolean.parseBoolean(request.getParameter("ativo")));

            // ===== TURMAS =====

            String[] turmaIds = request.getParameterValues("turmaIds");

            List<TurmaAlunoDTO> listaMatriculas = new ArrayList<>();

            if (turmaIds != null) {

                for (String turmaIdStr : turmaIds) {

                    int turmaId = Integer.parseInt(turmaIdStr);

                    TurmaDTO turma = new TurmaDTO();
                    turma.setId(turmaId);

                    TurmaAlunoDTO ta = new TurmaAlunoDTO();
                    ta.setTurma(turma);
                    String nota1Str = request.getParameter("nota1_" + turmaId);
                    String nota2Str = request.getParameter("nota2_" + turmaId);
                    String obs = request.getParameter("obs_" + turmaId);

                    if (nota1Str != null && !nota1Str.isBlank()) {
                        ta.setNota1(Double.parseDouble(nota1Str));
                    }

                    if (nota2Str != null && !nota2Str.isBlank()) {
                        ta.setNota2(Double.parseDouble(nota2Str));
                    }

                    ta.setObservacoes(obs);

                    listaMatriculas.add(ta);
                }
            }

            aluno.setMatriculas(listaMatriculas);

            boolean sucesso = alunoDAO.alterarAlunoCompleto(aluno);

            if (sucesso) {
                response.sendRedirect("admin");
            } else {
                request.setAttribute("erro", "Erro ao atualizar aluno.");
                carregarListas(request);
                request.getRequestDispatcher("adminHome.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }



    private void vincularAlunoTurma(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int idAluno = Integer.parseInt(request.getParameter("idAluno"));
            int idTurma = Integer.parseInt(request.getParameter("idTurma"));

            alunoDAO.vincularAlunoTurma(idAluno, idTurma);

            enviarMensagem(request, response, "Aluno matriculado com sucesso!");

        } catch (Exception e) {
            enviarErro(request, response, "Erro ao matricular aluno: " + e.getMessage());
        }
    }

    private void vincularProfessorTurma(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int idProfessor = Integer.parseInt(request.getParameter("idProfessor"));
            int idTurma = Integer.parseInt(request.getParameter("idTurma"));

            professorDAO.vincularProfessorTurma(idProfessor, idTurma);

            enviarMensagem(request, response, "Professor vinculado à turma com sucesso!");

        } catch (Exception e) {
            enviarErro(request, response, "Erro ao vincular professor: " + e.getMessage());
        }
    }
    private void vincularProfessorDisciplina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int idProfessor = Integer.parseInt(request.getParameter("idProfessor"));
            int idDisciplina = Integer.parseInt(request.getParameter("idDisciplina"));

            professorDAO.vincularProfessorDisciplina(idProfessor, idDisciplina);

            enviarMensagem(request, response, "Professor vinculado à disciplina com sucesso!");

        } catch (Exception e) {
            enviarErro(request, response, "Erro ao vincular professor à disciplina: " + e.getMessage());
        }
    }





}
