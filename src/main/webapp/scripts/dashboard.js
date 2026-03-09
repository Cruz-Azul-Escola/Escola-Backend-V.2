const graficoNotasPeriodo = document.getElementById('NotasPeriodo');
const graficoNotasSala = document.getElementById('NotasSala');

let chartPeriodo;
let chartSala;

function atualizarBigNumbers() {

    document.getElementById("numeroAlunos").innerText =
        numeroAlunos[disciplinaAtual];

    document.getElementById("mediaMedia").innerText =
        mediaMedia[disciplinaAtual].toFixed(2);

    document.getElementById("alunosMaiorMedia").innerText =
        alunosMaiorMedia[disciplinaAtual];

    document.getElementById("maiorMedia").innerText =
        maiorMedia[disciplinaAtual].toFixed(2);
}

function atualizarGraficoPeriodo() {

    const dados = mediasNotas[disciplinaAtual];

    chartPeriodo.data.labels = periodos;
    chartPeriodo.data.datasets[0].data = dados;

    chartPeriodo.update();
}

function atualizarGraficoSala() {

    const salas = nomeSalas[disciplinaAtual];
    const dados = dadosSalasDisciplina[disciplinaAtual];

    const medias = salas.map(s => dados[s][2]);

    chartSala.data.labels = salas;
    chartSala.data.datasets[0].data = medias;

    chartSala.update();
}

chartPeriodo = new Chart(graficoNotasPeriodo, {
    type: 'bar',
    data:{
        labels: [],
        datasets: [{
            label: 'Média dos alunos',
            data: [],
            backgroundColor: "#0B3E91"
        }]
    },
    options: {
        responsive: true,

        plugins: {
            title: {
                display: true,
                text: "Notas por Período"
            },
            legend: {
                position: "top"
            }
        },

        scales: {
            y: {
                beginAtZero: true,
                max: 10,
                ticks: {
                    stepSize: 1
                }
            }
        },

        elements: {
            bar: {
                borderRadius: 8
            }
        }
    }
});

chartSala = new Chart(graficoNotasSala, {
    type: 'bar',
    data:{
        labels: [],
        datasets: [{
            label: 'Média Final por Sala',
            data: [],
            backgroundColor: "#1E88E5"
        }]
    },
    options: {
        responsive: true,
        plugins: {
            title: {
                display: true,
                text: "Notas por Sala"
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                max: 10
            }
        }
    }
});

window.onload = function () {

    const select = document.querySelector(".filtro");
    disciplinaAtual = select.value;

    atualizarBigNumbers();
    atualizarGraficoPeriodo();
    atualizarGraficoSala();
};