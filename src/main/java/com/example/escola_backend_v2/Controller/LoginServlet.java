package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DAO.LogarCadastrarDAO;
import com.example.escola_backend_v2.DTO.AlunoDTO;
import com.example.escola_backend_v2.DTO.ProfessorDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/buscar", "/cadastrar", "/logarAdm"})
public class LoginServlet extends HttpServlet {

    private final LogarCadastrarDAO dao = new LogarCadastrarDAO();
    private final AlunoDAO alunoDAO = new AlunoDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String path = request.getServletPath();
        switch (path) {
            case "/login":
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
            case "/buscar":
                request.getRequestDispatcher("buscarAlunoCadastro.jsp").forward(request, response);
                break;

            case "/cadastrar":
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                break;

            case "/logarAdm":
                request.getRequestDispatcher("logarAdm.jsp").forward(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                loginAlunoOuProfessor(request, response);
                break;
            case "/buscar":
                buscarAluno(request, response);
                break;

            case "/cadastrar":
                cadastrarAluno(request, response);
                break;

            case "/logarAdm":
                loginAdministrador(request, response);
                break;


            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    // ==========================
    // MÉTODOS AUXILIARES
    // ==========================

    private void loginAlunoOuProfessor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        Object usuario = dao.logar(email, senha);

        if (usuario != null) {
            HttpSession session = request.getSession();

            if (usuario instanceof AlunoDTO) {
                AlunoDTO aluno = (AlunoDTO) usuario;
                session.setAttribute("usuarioLogado", aluno);
                session.setAttribute("tipo", "ALUNO");
                session.setAttribute("id", aluno.getId());
                response.sendRedirect("homeAluno");

            } else if (usuario instanceof ProfessorDTO) {
                ProfessorDTO prof = (ProfessorDTO) usuario;
                session.setAttribute("usuarioLogado", prof);
                session.setAttribute("tipo", "PROFESSOR");
                session.setAttribute("id", prof.getId());
                response.sendRedirect("homeProfessor");
            }

        } else {
            request.setAttribute("erroLogin", "Usuário ou senha inválidos!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
    }

    private void cadastrarAluno(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt( request.getParameter("id"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String senhaconf = request.getParameter("senhaConf");

        if (nome == null || nome.isBlank() || email == null || email.isBlank() || senha == null || senha.isBlank() ){
            response.sendRedirect(request.getContextPath() + "/cadastro.jsp");
            return;
        }

        nome= nome.trim();
        email = email.trim();
        senha=senha.trim();
        senhaconf= senhaconf.trim();
        if (!senhaconf.equals(senha)){
            response.sendRedirect(request.getContextPath() + "/cadastro.jsp");

        }
        int result=alunoDAO.Cadastro(email, senha, id, nome);
        if (result>0){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }



    }

    private void buscarAluno(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cpf = request.getParameter("cpf");

        if (cpf == null || cpf.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/buscarAlunoCadastro.jsp");
            return;
        }
        cpf = cpf.trim();
        int id = alunoDAO.buscarPorCpf(cpf);
        if (id>0){
            request.setAttribute("id", id);
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    private void loginAdministrador(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email").trim();
        String senha = request.getParameter("senha").trim();

        if (dao.logarAdm(email, senha) > 0) {
            response.sendRedirect("admin");
        } else {
            request.setAttribute("erro", "Email ou senha inválidos");
            request.getRequestDispatcher("logarAdm.jsp").forward(request, response);
        }
    }
}
