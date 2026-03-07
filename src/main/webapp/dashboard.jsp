<%--
  Created by IntelliJ IDEA.
  User: rafaeltakematsu-ieg
  Date: 19/02/2026
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/styleDashboard.css">
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
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
    <a href="homeProfessor">
        <div id="voltar">
            <h4 >➜ Sair </h4>
        </div>
    </a>
</header>

<main>
    <div class="titulo">
        <h2>Visão Geral - Analítico</h2>

        <div class="filtros">
            <div class="filtro box">
                ${disciplinas}
            </div>
        </div>

    </div>

    <section class="dash-container">

        <div class="bignumber">
            <h2>Alunos</h2>
            <p>${numeroAlunos}</p>
        </div>

        <div class=" bignumber">
            <h2>Média da Nota Final</h2>
            <p>${mediaMedia}</p>
        </div>

        <div class="bignumber">
            <h2>Maior Nota Final</h2>
            <p>${alunosMaiorMedia}</p>
            <p>${maiorMedia}</p>
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
    const periodos = JSON.parse('${periodos}');
    const mediasNotas = JSON.parse('${mediasNotas}');
    const nomeSalas = JSON.parse('${nomeSalas}');
    const dadosBoxplot = JSON.parse('${dadosBoxplot}');


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


</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="scripts/dashboard.js"></script>
</body>
</html>
