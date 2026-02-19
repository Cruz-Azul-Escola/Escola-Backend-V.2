package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DAO.LogarCadastrarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = {"/novaSenha", "/hashSenha"})
public class NovaSenhaServlet extends HttpServlet {

    LogarCadastrarDAO dao = new LogarCadastrarDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/novaSenha")){
            String novaSenha = request.getParameter("senha");
            String novaSenhaConf = request.getParameter("confirmarSenha");
            int id= Integer.parseInt( request.getParameter("id"));

            if (!novaSenhaConf.equals(novaSenha)){
                response.sendRedirect("novaSenha.jsp");
            }else {
                AlunoDAO alunoDAO = new AlunoDAO();
                int res= alunoDAO.editarSenha(id, novaSenha);
                if (res>0){
                    response.sendRedirect("login.jsp");
                } else {
                    response.sendRedirect("novaSenha.jsp");
                }
            }


        } else if (path.equals("/hashSenha")) {
            String codigo = request.getParameter("codigo");
            String email = request.getParameter("email");
            int id = dao.verificar(email, codigo);
            if (id > 0) {
                AlunoDAO alunoDAO = new AlunoDAO();
                request.setAttribute("id", id);
                request.getRequestDispatcher("novaSenha.jsp").forward(request, response);
            } else {
                request.setAttribute("erro", "Código inválido");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}
