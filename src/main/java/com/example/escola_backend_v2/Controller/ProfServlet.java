package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DAO.ProfessorDAO;
import com.example.escola_backend_v2.DAO.TurmaAlunoDAO;
import com.example.escola_backend_v2.DTO.AlunoDTO;
import com.example.escola_backend_v2.DTO.ProfessorDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/homeProfessor", "/buscarAluno", "/salvarNotas"})
public class ProfServlet extends HttpServlet {

    ProfessorDAO professorDAO = new ProfessorDAO();
    AlunoDAO alunoDAO = new AlunoDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            System.out.println("Sessão é NULL");
        } else {
            System.out.println("Sessão ID: " + session.getId());
            System.out.println("ID Professor: " + session.getAttribute("id"));
        }


        ProfessorDTO professorLogado = (ProfessorDTO) session.getAttribute("usuarioLogado");
        System.out.println("baba"+ professorLogado);
        if (professorLogado == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        System.out.println("baannanannnan");
        ProfessorDTO professorCompleto = professorDAO.buscarPorId(professorLogado.getId());
        req.setAttribute("professor", professorCompleto);


        int totalAlunos = professorDAO.contarTotalAlunosDoProfessor(professorCompleto.getId());
        System.out.println(totalAlunos);
        req.setAttribute("totalAlunos", totalAlunos);
        req.getRequestDispatcher("/profHome.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        if ("buscarAluno".equals(acao)) {

            String matricula = request.getParameter("matricula");
            int idTurma = Integer.parseInt(request.getParameter("idTurma"));

            AlunoDTO aluno = alunoDAO.buscarAlunoPorMatricula(matricula, idTurma);

            request.setAttribute("aluno", aluno);
            request.setAttribute("idTurmaSelecionada", idTurma);


            request.setAttribute("aluno", aluno);
            doGet(request, response);
        }


        else if ("salvarNotas".equals(acao)) {

            int idAluno = Integer.parseInt(request.getParameter("idAluno"));
            int idTurma = Integer.parseInt(request.getParameter("idTurma"));
            Double nota1 = request.getParameter("nota1").isEmpty() ? null : Double.parseDouble(request.getParameter("nota1"));
            Double nota2 = request.getParameter("nota2").isEmpty() ? null : Double.parseDouble(request.getParameter("nota2"));

            String observacao = request.getParameter("observacao");
            TurmaAlunoDAO turmaAlunoDAO= new TurmaAlunoDAO();

            turmaAlunoDAO.atualizarNotas(idAluno, idTurma, nota1, nota2, observacao);

            response.sendRedirect("homeProfessor");
        }
    }

}