package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DTO.AlunoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/homeAluno"})
public class AlunoServlet extends HttpServlet {

    AlunoDAO alunoDAO = new AlunoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer idAluno = (Integer) session.getAttribute("id"); // só o id
        System.out.println(idAluno);

        if (idAluno == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        AlunoDTO alunoLogado = (AlunoDTO) session.getAttribute("usuarioLogado");



        AlunoDTO alunoCompleto = alunoDAO.buscarAlunoPorId(alunoLogado.getId());
        boolean completo = alunoDAO.notasFaltando(alunoCompleto.getId());
        req.setAttribute("boletimCompleto", completo);
        req.setAttribute("aluno", alunoCompleto);
        req.getRequestDispatcher("/homeAluno.jsp").forward(req, resp);

    }

}
