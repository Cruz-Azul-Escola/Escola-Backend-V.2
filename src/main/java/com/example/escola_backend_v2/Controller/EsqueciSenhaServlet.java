package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.LogarCadastrarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/esqueci")
public class EsqueciSenhaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        LogarCadastrarDAO dao = new LogarCadastrarDAO();
        int ok = dao.chekarParaEnvio(email);

        if (ok > 0) {
            request.setAttribute("email", email);
            request.getRequestDispatcher("novaSenha.jsp").forward(request, response);
        } else {
            request.setAttribute("erro", "Email não encontrado");
            request.getRequestDispatcher("esqueci.jsp").forward(request, response);
        }
    }
}