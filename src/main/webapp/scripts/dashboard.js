const graficoNotasPeriodo = document.getElementById('NotasPeriodo');
const boxplotNotasSala = document.getElementById('NotasSala');

new Chart(graficoNotasPeriodo, {
    type: 'bar',
    data:{
        labels: periodos,
        datasets: [{
            label: 'Média dos alunos',
            data: mediasNotas,
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
const datasets = [];

for (const sala in dadosBoxplot) {

    datasets.push({
        label: sala,
        data: dadosBoxplot[sala],
        borderWidth: 2
    });
}

new Chart(boxplotNotasSala, {
    type: 'line',
    data:{
        labels: periodos,
        datasets: datasets
    },
    options: {
        responsive: true,

        plugins: {
            title: {
                display: true,
                text: "Notas por Sala"
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
        }
    }
});