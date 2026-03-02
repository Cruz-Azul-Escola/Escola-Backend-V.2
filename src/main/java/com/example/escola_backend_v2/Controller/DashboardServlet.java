
package com.example.escola_backend_v2.Controller;


import com.example.escola_backend_v2.DAO.ProfessorTurmaDAO;
import com.example.escola_backend_v2.DAO.SalaDAO;
import com.example.escola_backend_v2.DAO.TurmaAlunoDAO;
import com.example.escola_backend_v2.DAO.TurmaDAO;
import com.example.escola_backend_v2.DTO.*;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.*;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProfessorDTO professor = (ProfessorDTO) request.getSession().getAttribute("usuarioLogado");
        int idProfessor = professor.getId();

        ProfessorTurmaDAO professorTurmaDao = new ProfessorTurmaDAO();
        TurmaAlunoDAO matriculaDao = new TurmaAlunoDAO();
        TurmaDAO turmaDao = new TurmaDAO();
        SalaDAO salaDao = new SalaDAO();

        List<ProfessorTurmaDTO> professorTurmas = professorTurmaDao.buscarPorProfessor(idProfessor);
        List<TurmaDTO> turmas = new ArrayList<>();
        List<TurmaAlunoDTO> todasMatriculas = new ArrayList<>();
        List<SalaDTO> salas = new ArrayList<>();

        for (ProfessorTurmaDTO pt : professorTurmas) {
            TurmaDTO turma = pt.getTurma();
            turmas.addAll(turmaDao.buscarPorId(turma.getId()));
        }
        for (TurmaDTO t : turmas) {
            todasMatriculas.addAll(matriculaDao.buscaPorProfessorTurma(t));
            salas.addAll(salaDao.buscarSalaPorTurma(t));
        }

        int numeroAlunos = todasMatriculas.size();
        double periodo1 = 0;
        double periodo2 = 0;
        double somaMedia = 0;
        double maiorMedia = -1;
        List<String> alunosMaiorMedia = new ArrayList<>();

        Map<String, Double> somaN1Salas = new HashMap<>();
        Map<String, Double> somaN2Salas = new HashMap<>();
        Map<String, Double> somaMediaSalas = new HashMap<>();
        Map<String, Integer> qtdAlunosPorSala = new HashMap<>();

        for (TurmaAlunoDTO tm : todasMatriculas) {

            double n1Aluno = tm.getNota1() != null ? tm.getNota1() : 0;
            double n2Aluno = tm.getNota2() != null ? tm.getNota2() : 0;
            double mediaAluno = tm.getMedia() != null ? tm.getMedia() : 0;

            periodo1 += n1Aluno;
            periodo2 += n2Aluno;
            somaMedia += mediaAluno;

            for (SalaDTO s : salas) {
                String nomeSala = s.getNome();

                somaN1Salas.put(
                        nomeSala,
                        somaN1Salas.getOrDefault(nomeSala, 0.0) + n1Aluno
                );
                somaN2Salas.put(
                        nomeSala,
                        somaN2Salas.getOrDefault(nomeSala, 0.0) + n2Aluno
                );
                somaMediaSalas.put(
                        nomeSala,
                        somaMediaSalas.getOrDefault(nomeSala, 0.0) + mediaAluno
                );

                qtdAlunosPorSala.put(
                        nomeSala,
                        qtdAlunosPorSala.getOrDefault(nomeSala, 0) + 1
                );
            }

            if (tm.getMedia() >= maiorMedia) {
                maiorMedia = tm.getMedia();
                alunosMaiorMedia.add(tm.getAluno().getNome());
            }
        }
        double mediaN1 = periodo1 / numeroAlunos;
        double mediaN2 = periodo2 / numeroAlunos;
        double mediaMedia = (double) Math.round(somaMedia / numeroAlunos *100) / 100;
        String concatAlunosMaiorMedia = String.join(", ", alunosMaiorMedia);

        Map<String, Double> mediaN1Salas = new HashMap<>();
        Map<String, Double> mediaN2Salas = new HashMap<>();
        Map<String, Double> mediaMediaSalas = new HashMap<>();
        List<String> nomeSalas = new ArrayList<>();

        for (String sala : somaN1Salas.keySet()) {
            mediaN1Salas.put(
                    sala,
                    somaN1Salas.get(sala) / qtdAlunosPorSala.get(sala)
            );
            nomeSalas.add(sala);
        }
        for (String sala : somaN2Salas.keySet()) {
            mediaN2Salas.put(
                    sala,
                    somaN2Salas.get(sala) / qtdAlunosPorSala.get(sala)
            );
        }
        for (String sala : somaMediaSalas.keySet()) {
            mediaMediaSalas.put(
                    sala,
                    somaMediaSalas.get(sala) / qtdAlunosPorSala.get(sala)
            );
        }

        Map<String, List<Double>> dadosBoxplot = new LinkedHashMap<>();

        for (String sala : mediaN1Salas.keySet()) {

            List<Double> medias = new ArrayList<>();

            medias.add(mediaN1Salas.get(sala));
            medias.add(mediaN2Salas.get(sala));
            medias.add(mediaMediaSalas.get(sala));

            dadosBoxplot.put(sala, medias);
        }

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
        request.setAttribute("dadosBoxplot", gson.toJson(dadosBoxplot));
        request.setAttribute("nomeSalas", gson.toJson(nomeSalas));
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}