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

    //Controle das ações
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
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

            default:
                enviarErro(request, response, "Ação inválida.");
        }
    }

    //Listas
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

    //Mensagens
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

    //Cadastros
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
            tratarErro(response, request, "Erro ao cadastrar aluno", e);
        }
    }

    private void cadastrarProfessor(HttpServletRequest request, HttpServletResponse response) {
        try {
            String email = request.getParameter("email");


            ProfessorDTO professor = new ProfessorDTO();
            professor.setNome(request.getParameter("nome"));
            professor.setEmail(email);
            professor.setSenha(request.getParameter("senha"));
            professor.setEstaAtivo(Boolean.parseBoolean(request.getParameter("estaAtivo")));

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
            tratarErro(response, request, "Erro ao cadastrar professor", e);
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
            tratarErro(response, request, "Capacidade inválida", e);
        } catch (Exception e) {
            e.printStackTrace();
            tratarErro(response, request, "Erro ao cadastrar sala", e);
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
            tratarErro(response, request, "ID inválido", e);
        } catch (Exception e) {
            e.printStackTrace();
            tratarErro(response, request, "Erro ao cadastrar turma", e);
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
            tratarErro(response, request, "Carga horária inválida", e);
        } catch (Exception e) {
            e.printStackTrace();
            tratarErro(response, request, "Erro ao cadastrar disciplina", e);
        }
    }

    //Tratamento
    private void tratarErro(HttpServletResponse response, HttpServletRequest request, String mensagem, Exception e){
        try{
            enviarErro(request, response, mensagem + ": " + e.getMessage());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
