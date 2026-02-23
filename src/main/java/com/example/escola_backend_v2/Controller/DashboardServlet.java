
package com.example.escola_backend_v2.Controller;


import com.example.escola_backend_v2.DAO.ProfessorTurmaDAO;
import com.example.escola_backend_v2.DAO.TurmaAlunoDAO;
import com.example.escola_backend_v2.DTO.*;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProfessorDTO professor = (ProfessorDTO) request.getSession().getAttribute("usuarioLogado");
        int idProfessor = professor.getId();

        ProfessorTurmaDAO professorTurmaDao = new ProfessorTurmaDAO();
        TurmaAlunoDAO matriculaDao = new TurmaAlunoDAO();

        List<ProfessorTurmaDTO> professorTurmas = professorTurmaDao.buscarPorProfessor(idProfessor);
        List<TurmaAlunoDTO> todasMatriculas = new ArrayList<>();

        for (ProfessorTurmaDTO pt : professorTurmas) {

            TurmaDTO turma = pt.getTurma();

            List<TurmaAlunoDTO> matriculas =
                    matriculaDao.buscaPorProfessorTurma(turma);

            todasMatriculas.addAll(matriculas);
        }
        int numeroAlunos = todasMatriculas.size();
        double periodo1 = 0;
        double periodo2 = 0;
        double somaMedia = 0;
        double maiorMedia = -1;
        List<String> alunosMaiorMedia = new ArrayList<>();

        for (TurmaAlunoDTO tm : todasMatriculas) {
            periodo1 += tm.getNota1();
            periodo2 += tm.getNota2();
            somaMedia += tm.getMedia();

            if (tm.getMedia() >= maiorMedia) {
                maiorMedia = tm.getMedia();
                alunosMaiorMedia.add(tm.getAluno().getNome());
            }
        }
        double mediaN1 = periodo1 / numeroAlunos;
        double mediaN2 = periodo2 / numeroAlunos;
        double mediaMedia = somaMedia / numeroAlunos;
        String concatAlunosMaiorMedia = String.join(", ", alunosMaiorMedia);

        Gson gson = new Gson();
        List<String> periodos = Arrays.asList("1º período", "2º período", "Nota Final");
        List<Double> mediasNotas = Arrays.asList(mediaN1, mediaN2, mediaMedia);

        request.setAttribute("numeroAlunos", numeroAlunos);
        request.setAttribute("mediaN1", mediaN1);
        request.setAttribute("mediaN2", mediaN2);
        request.setAttribute("mediaMedia", mediaMedia);
        request.setAttribute("maiorMedia", maiorMedia);
        request.setAttribute("alunosMaiorMedia", concatAlunosMaiorMedia);
        request.setAttribute("periodos", gson.toJson(periodos));
        request.setAttribute("mediasNotas", gson.toJson(mediasNotas));
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}