<%@ page import="com.example.escola_backend_v2.DTO.DisciplinaDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: rafaeltakematsu-ieg
  Date: 19/02/2026
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
    List<DisciplinaDTO> disciplinas = (List<DisciplinaDTO>) request.getAttribute("disciplinas");
%>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/styleDashboard.css">
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
    <script>
        const numeroAlunos = JSON.parse('${numeroAlunos}');
        const mediaMedia = JSON.parse('${mediaMedia}');
        const alunosMaiorMedia = JSON.parse('<%= request.getAttribute("alunoMaiorMedia") %>');
        const maiorMedia = JSON.parse('${maiorMedia}')
        const periodos = JSON.parse('${periodos}');
        const mediasNotas = JSON.parse('${mediasNotas}');
        const nomeSalas = JSON.parse('${nomeSalas}');
        const dadosSalasDisciplina = JSON.parse('${dadosSalasDisciplina}');
    </script>
</head>
<body>
<header id="cabecalho-site">
    <div id="logotipo">
        <div>
            <img src="assets/icons/Logo da escola.png" alt="">
        </div>
        <div>
            <h1>Cruz Azul</h1>
            <h4>Portal do Professor</h4>
        </div>
    </div>
    <a href="profHome.jsp">
        <div id="voltar">
            <img src="assets/icons/voltar.png" alt="">
            <h4>Voltar</h4>
        </div>
    </a>
</header>

<main>
    <div class="titulo">
        <h2>Visão Geral - Analítico</h2>

        <div class="filtros">
            <select class="filtro box" onchange="filtrarDisciplina(this)" >
                <%
                    for (var disciplina : disciplinas) {
                %>
                <option value="<%= disciplina.getNome() %>">
                    <%= disciplina.getNome() %>
                </option>
                <%
                    }
                %>
            </select>
        </div>

    </div>

    <section class="dash-container">

        <div class="bignumber">
            <h2>Alunos</h2>
            <p id="numeroAlunos"></p>
        </div>

        <div class=" bignumber">
            <h2>Média da Nota Final</h2>
            <p id="mediaMedia"></p>
        </div>

        <div class="bignumber">
            <h2>Maior Nota Final</h2>
            <p id="alunosMaiorMedia"></p>
            <p id="maiorMedia"></p>
        </div>
        <div class="filtros">
                <select class="filtro box" onchange="mudarGrafico(this)">
                    <option value="opcao1">Notas por Periodo</option>
                    <option value="opcao2">Notas por Sala</option>
                </select>
        </div>


        <div id="graficoNotasPeriodo" class="graficoNotasPeriodo">
            <canvas id="NotasPeriodo"></canvas>
        </div>

        <div id="graficoNotasSala" class="graficoNotasPeriodo vazio">
            <canvas id="NotasSala"></canvas>
        </div>

    </section>
</main>
<script>

    function mudarGrafico(select) {
        const graficoPeriodo = document.getElementById("graficoNotasPeriodo");
        const graficoSala = document.getElementById("graficoNotasSala");

        if (select.value === "opcao1") {
            graficoPeriodo.classList.remove("vazio");
            graficoSala.classList.add("vazio");
        } else {
            graficoPeriodo.classList.add("vazio");
            graficoSala.classList.remove("vazio");
        }
    }

    let disciplinaAtual = null;

    function filtrarDisciplina(select) {

        disciplinaAtual = select.value;

        atualizarBigNumbers();
        atualizarGraficoPeriodo();
        atualizarGraficoSala();
    }

</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="scripts/dashboard.js"></script>
</body>
</html>
