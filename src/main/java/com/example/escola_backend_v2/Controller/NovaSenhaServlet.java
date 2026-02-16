package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DAO.LogarCadastrarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/novaSenha")
public class NovaSenhaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String codigo = request.getParameter("codigo");
        String novaSenha = request.getParameter("senha");

        LogarCadastrarDAO dao = new LogarCadastrarDAO();
        int id = dao.verificar(email, codigo);

        if (id > 0) {
            AlunoDAO alunoDAO = new AlunoDAO();
            alunoDAO.editarSenha(id, novaSenha);
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("erro", "Código inválido");
            request.getRequestDispatcher("novaSenha.jsp").forward(request, response);
        }
    }
}
