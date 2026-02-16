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

@WebServlet(urlPatterns = {"/login", "/cadastrar", "/logarAdm"})
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
            request.setAttribute("erro", "Email ou senha inválidos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void cadastrarAluno(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (cpf == null || email == null || senha == null ||
                cpf.isBlank() || email.isBlank() || senha.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/cadastro.jsp");
            return;
        }

        cpf = cpf.trim();
        email = email.trim();
        senha = senha.trim();

        int id = alunoDAO.buscarPorCpf(cpf);
        if (id <= 0) {
            response.sendRedirect(request.getContextPath() + "/cadastro.jsp");
            return;
        }

        int resultado = alunoDAO.Cadastro(email, senha, id);
        if (resultado > 0) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/cadastro.jsp");
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
