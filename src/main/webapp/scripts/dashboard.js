const graficoNotasPeriodo = document.getElementById('NotasPeriodo');

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