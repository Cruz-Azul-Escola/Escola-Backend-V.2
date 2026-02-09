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
import java.util.List;

@WebServlet(urlPatterns = {"/login", "/cadastrar"})
public class LoginServlet extends HttpServlet {
    LogarCadastrarDAO dao = new LogarCadastrarDAO();
    AlunoDAO alunoDAO = new AlunoDAO();


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/login".equals(path)) {

            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            Object usuario = dao.logar(email, senha);
            System.out.println(usuario.toString());
            System.out.println("Retorno DAO: " + usuario);

            if (usuario != null) {
                System.out.println("d");
                HttpSession session = request.getSession();

                if (usuario instanceof AlunoDTO) {
                    AlunoDTO aluno = (AlunoDTO) usuario;
                    session.setAttribute("usuarioLogado", aluno);
                    session.setAttribute("tipo", "ALUNO");
                    session.setAttribute("id", aluno.getId());
                    System.out.println(aluno);
                    response.sendRedirect("homeAluno");
                    return;

                } else if (usuario instanceof ProfessorDTO) {
                    ProfessorDTO prof = (ProfessorDTO) usuario;
                    session.setAttribute("usuarioLogado", prof);
                    session.setAttribute("tipo", "PROFESSOR");

                    request.getRequestDispatcher("/homeProfessor.jsp").forward(request, response);
                    return;
                }

            } else {
                request.setAttribute("erro", "Email ou senha inválidos");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if ("/cadastrar".equals(path)) {
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
            System.out.println(id);
            if (id <= 0) {
                response.sendRedirect(request.getContextPath() + "/cadastro.jsp");

                return;
            }
            int resultado = alunoDAO.Cadastro(email, senha, id);
            System.out.println(resultado);
            if (resultado > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/cadastro.jsp");

            }



        }

    }
}

