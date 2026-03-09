
package com.example.escola_backend_v2.Controller;


import com.example.escola_backend_v2.DAO.*;
import com.example.escola_backend_v2.DTO.*;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProfessorDTO professor = (ProfessorDTO) request.getSession().getAttribute("usuarioLogado");
        int idProfessor = professor.getId();

//        Instanciando objetos DAO

        ProfessorTurmaDAO professorTurmaDao = new ProfessorTurmaDAO();
        TurmaAlunoDAO matriculaDao = new TurmaAlunoDAO();
        TurmaDAO turmaDao = new TurmaDAO();
        SalaDAO salaDao = new SalaDAO();
        DisciplinaDAO disciplinaDao = new DisciplinaDAO();

//        Criando listas das DTOs utilizadas

        List<ProfessorTurmaDTO> professorTurmas = professorTurmaDao.buscarPorProfessor(idProfessor);
        List<TurmaDTO> turmas = new ArrayList<>();
        List<TurmaAlunoDTO> todasMatriculas = new ArrayList<>();
        List<SalaDTO> salas = new ArrayList<>();
        List<DisciplinaDTO> disciplinas = new ArrayList<>();

//        Adicionando as turmas do professor

        for (ProfessorTurmaDTO pt : professorTurmas) {
            TurmaDTO turma = pt.getTurma();
            turmas.addAll(turmaDao.buscarPorId(turma.getId()));
        }
//        Adicionando matriculas (turma_aluno), salas e disciplinas do professor
        for (TurmaDTO t : turmas) {
            todasMatriculas.addAll(matriculaDao.buscaPorProfessorTurma(t));
            salas.addAll(salaDao.buscarSalaPorTurma(t));
            disciplinas.addAll(disciplinaDao.buscarDisciplinaPorTurma(t));
        }

//        Variáveis GLOBAIS
        int numeroAlunosGlobal = 0;
        double mediaN1Global = 0;
        double mediaN2Global = 0;
        double MediaMediaGlobal = 0;
        double maiorMediaGlobal = -1;
        List<String> alunosMaiorMediaGlobal = new ArrayList<>();

//        Variáveis base para dados filtrado por disciplina (String - nome da disciplina)
        // Big Numbers
        Map<String, Integer> numeroAlunosDisciplina = new HashMap<>();
        Map<String, Double> maiorMediaDisciplina = new HashMap<>();
        Map<String, String> alunoMaiorMediaDisciplina = new HashMap<>();
        // Período
        Map<String, Double> mediaN1Disciplina = new HashMap<>();
        Map<String, Double> mediaN2Disciplina = new HashMap<>();
        Map<String, Double> mediaMediaDisciplina = new HashMap<>();
        // Sala
        Map<String, Map<String, Integer>> numeroAlunosSalasDisciplina = new HashMap<>();
        Map<String, Map<String, Double>> somaN1SalasDisciplina = new HashMap<>();
        Map<String, Map<String, Double>> somaN2SalasDisciplina = new HashMap<>();
        Map<String, Map<String, Double>> somaMediaSalasDisciplina = new HashMap<>();
        Map<String, Map<String, Double>> mediaN1SalasDisciplina = new HashMap<>();
        Map<String, Map<String, Double>> mediaN2SalasDisciplina = new HashMap<>();
        Map<String, Map<String, Double>> mediaMediaSalasDisciplina = new HashMap<>();

//        FOR principal: atribuição de valores aos Maps (disciplina: {sala: nota})
        for (TurmaAlunoDTO tm : todasMatriculas) {

//                Notas individuais dos alunos
            double n1Aluno = tm.getNota1() != null ? tm.getNota1() : 0;
            double n2Aluno = tm.getNota2() != null ? tm.getNota2() : 0;
            double mediaAluno = tm.getMedia() != null ? tm.getMedia() : 0;

            // pega a sala dos alunos
            String nomeSala = matriculaDao.bucarSala(tm.getTurma(), tm.getAluno()).getNome();

            // percorre as disciplinas dos alunos
            for (DisciplinaDTO d : disciplinas) {

                String disciplina = d.getNome();

//                    Criando o Map interno para cada nota (sala: nota)
                // Bloco que diferencia cada uma das matérias: getOrDefault - se o map principal dessa disciplina
                //já existir, usa o map interno já existente, se não, instancia um novo map interno para a disciplina
                Map<String, Integer> mapaAlunosSala =
                        numeroAlunosSalasDisciplina.getOrDefault(disciplina, new HashMap<>());
                Map<String, Double> mapaSalasN1 =
                        somaN1SalasDisciplina.getOrDefault(disciplina, new HashMap<>());
                Map<String, Double> mapaSalasN2 =
                        somaN2SalasDisciplina.getOrDefault(disciplina, new HashMap<>());
                Map<String, Double> mapaSalasMedia =
                        somaMediaSalasDisciplina.getOrDefault(disciplina, new HashMap<>());
                // Atribuindo os valores do map interno. Mesma lógica do getOrDefault: se o map interno dessa sala
                //já existir, apenas adiciona a nota do novo aluno, se não, cria um novo map para a sala
                mapaAlunosSala.put(
                        nomeSala,
                        mapaAlunosSala.getOrDefault(nomeSala, 0) + 1
                );
                mapaSalasN1.put(
                        nomeSala,
                        mapaSalasN1.getOrDefault(nomeSala, 0.0) + n1Aluno
                );
                mapaSalasN2.put(
                        nomeSala,
                        mapaSalasN2.getOrDefault(nomeSala, 0.0) + n2Aluno
                );
                mapaSalasMedia.put(
                        nomeSala,
                        mapaSalasMedia.getOrDefault(nomeSala, 0.0) + mediaAluno
                );

//                    Atribuindo os valores ao map principal (chave: disciplina; valor: {sala: nota})
                numeroAlunosSalasDisciplina.put(disciplina, mapaAlunosSala);
                somaN1SalasDisciplina.put(disciplina, mapaSalasN1);
                somaN2SalasDisciplina.put(disciplina, mapaSalasN2);
                somaMediaSalasDisciplina.put(disciplina, mapaSalasMedia);
            }
        }

//            Calculando as medias de cada sala por disciplina
        for (String disciplina : somaN1SalasDisciplina.keySet()) {

            Map<String, Double> somaSalasN1 = somaN1SalasDisciplina.get(disciplina);
            Map<String, Double> somaSalasN2 = somaN2SalasDisciplina.get(disciplina);
            Map<String, Double> somaSalasMedia = somaMediaSalasDisciplina.get(disciplina);

            Map<String, Integer> numeroAlunosSala = numeroAlunosSalasDisciplina.get(disciplina);

            Map<String, Double> mediasSalasN1 = new HashMap<>();
            Map<String, Double> mediasSalasN2 = new HashMap<>();
            Map<String, Double> mediasSalasMedia = new HashMap<>();

            for (String sala : somaSalasN1.keySet()) {

                double soma = somaSalasN1.get(sala);
                int alunos = numeroAlunosSala.get(sala);

                double media = alunos > 0 ? soma / alunos : 0;

                mediasSalasN1.put(sala, media);
            }
            mediaN1SalasDisciplina.put(disciplina, mediasSalasN1);

            for (String sala : somaSalasN2.keySet()) {

                double soma = somaSalasN2.get(sala);
                int alunos = numeroAlunosSala.get(sala);

                double media = alunos > 0 ? soma / alunos : 0;

                mediasSalasN2.put(sala, media);
            }
            mediaN2SalasDisciplina.put(disciplina, mediasSalasN2);

            for (String sala : somaSalasMedia.keySet()) {

                double soma = somaSalasMedia.get(sala);
                int alunos = numeroAlunosSala.get(sala);

                double media = alunos > 0 ? soma / alunos : 0;

                mediasSalasMedia.put(sala, media);
            }
            mediaMediaSalasDisciplina.put(disciplina, mediasSalasMedia);
        }

//            Definindo valores globais da disciplina
        // Numero de alunos por disciplina
        for (String disciplina : numeroAlunosSalasDisciplina.keySet()) {
            for (String sala : numeroAlunosSalasDisciplina.get(disciplina).keySet()) {
                int numAlunos = numeroAlunosSalasDisciplina.get(disciplina).get(sala);
                numeroAlunosDisciplina.put(
                        disciplina,
                        numeroAlunosDisciplina.getOrDefault(disciplina, 0) + numAlunos
                );
            }
        }
        // Cálculo das maiores médias por disciplina
        for (TurmaAlunoDTO ta : todasMatriculas) {

            for (DisciplinaDTO disciplina : matriculaDao.listarDisciplinas(ta.getTurma(), ta.getAluno())) {

                String nomeDisciplina = disciplina.getNome();
                double mediaAluno = ta.getMedia();

                if (!maiorMediaDisciplina.containsKey(nomeDisciplina) ||
                        mediaAluno > maiorMediaDisciplina.get(nomeDisciplina)) {

                    maiorMediaDisciplina.put(nomeDisciplina, mediaAluno);
                    alunoMaiorMediaDisciplina.put(nomeDisciplina, ta.getAluno().getNome());
                }
            }
        }


        // Buscando alunos da maior nota de cada disciplina
        for (TurmaAlunoDTO ta : todasMatriculas) {
            for (DisciplinaDTO disciplina : disciplinas) {
                String nomeDisciplina = disciplina.getNome();
                double mediaAluno = ta.getMedia();
                if (!maiorMediaDisciplina.containsKey(nomeDisciplina) ||
                        mediaAluno > maiorMediaDisciplina.get(nomeDisciplina)) {
                    maiorMediaDisciplina.put(nomeDisciplina, mediaAluno);
                }
            }
        }

        // Calculando as médias gerais de cada nota por disciplina
        for (String disciplina : somaN1SalasDisciplina.keySet()) {
            double somaTotal = 0;
            int alunosTotal = 0;
            for (String sala : somaN1SalasDisciplina.get(disciplina).keySet()) {
                somaTotal += somaN1SalasDisciplina.get(disciplina).get(sala);
                alunosTotal += numeroAlunosSalasDisciplina.get(disciplina).get(sala);
            }
            mediaN1Disciplina.put(disciplina, somaTotal / alunosTotal);
        }
        for (String disciplina : somaN2SalasDisciplina.keySet()) {
            double somaTotal = 0;
            int alunosTotal = 0;
            for (String sala : somaN2SalasDisciplina.get(disciplina).keySet()) {
                somaTotal += somaN2SalasDisciplina.get(disciplina).get(sala);
                alunosTotal += numeroAlunosSalasDisciplina.get(disciplina).get(sala);
            }
            mediaN2Disciplina.put(disciplina, somaTotal / alunosTotal);
        }
        for (String disciplina : somaMediaSalasDisciplina.keySet()) {
            double somaTotal = 0;
            int alunosTotal = 0;
            for (String sala : somaMediaSalasDisciplina.get(disciplina).keySet()) {
                somaTotal += somaMediaSalasDisciplina.get(disciplina).get(sala);
                alunosTotal += numeroAlunosSalasDisciplina.get(disciplina).get(sala);
            }
            mediaMediaDisciplina.put(disciplina, somaTotal / alunosTotal);
        }

//            Preparando dados para visão de Períodos
        // labels
        List<String> periodos = Arrays.asList("1º período", "2º período", "Nota Final");

        // dados - {disciplina: [n1,n2,n3]}
        Map<String, List<Double>> mediasNotasDisciplina = new HashMap<>();
        for (String disciplina : mediaMediaDisciplina.keySet()) {
            List<Double> mediasNotas = new ArrayList<>();
            mediasNotas.add(mediaN1Disciplina.getOrDefault(disciplina, 0.0));
            mediasNotas.add(mediaN2Disciplina.getOrDefault(disciplina, 0.0));
            mediasNotas.add(mediaMediaDisciplina.getOrDefault(disciplina, 0.0));
            mediasNotasDisciplina.put(disciplina, mediasNotas);
        }

//            Preparando dados para visão de Salas
        // labels
        Map<String, List<String>> nomeSalasDisciplina = new HashMap<>();
        for (String disciplina : mediaMediaSalasDisciplina.keySet()) {
            List<String> nomeSalas = new ArrayList<>(mediaMediaSalasDisciplina.get(disciplina).keySet());
            nomeSalasDisciplina.put(disciplina, nomeSalas);
        }

        // dados - {disciplina: {sala: [n1,n2,media]}}
        Map<String, Map<String, List<Double>>> dadosSalasDisciplina = new HashMap<>();
        for (String disciplina : mediaMediaSalasDisciplina.keySet()) {
            // Map interno dos dados
            Map<String, List<Double>> salasNotas = new HashMap<>();
            for (String sala : mediaMediaSalasDisciplina.get(disciplina).keySet()) {
                List<Double> mediasNotas = new ArrayList<>();
                mediasNotas.add(mediaN1SalasDisciplina.get(disciplina).getOrDefault(sala, 0.0));
                mediasNotas.add(mediaN2SalasDisciplina.get(disciplina).getOrDefault(sala, 0.0));
                mediasNotas.add(mediaMediaSalasDisciplina.get(disciplina).getOrDefault(sala, 0.0));
                salasNotas.put(sala, mediasNotas);
            }
            dadosSalasDisciplina.put(disciplina, salasNotas);
        }

        Gson gson = new Gson();

        // Filtro
        request.setAttribute("disciplinas", disciplinas);
        // Big Numbers
        request.setAttribute("numeroAlunos", gson.toJson(numeroAlunosDisciplina));
        request.setAttribute("mediaMedia", gson.toJson(mediaMediaDisciplina));
        request.setAttribute("alunoMaiorMedia", gson.toJson(alunoMaiorMediaDisciplina));
        request.setAttribute("maiorMedia", gson.toJson(maiorMediaDisciplina));
        // Visão de Períodos
        request.setAttribute("periodos", gson.toJson(periodos));
        request.setAttribute("mediasNotas", gson.toJson(mediasNotasDisciplina));
        // Visão detalhada por Sala
        request.setAttribute("nomeSalas", gson.toJson(nomeSalasDisciplina));
        request.setAttribute("dadosSalasDisciplina", gson.toJson(dadosSalasDisciplina));
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}