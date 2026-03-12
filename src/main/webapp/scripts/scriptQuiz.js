let listaPergResp = [];
let perguntaAtualIndex = 0;
let acertos = 0;
let segundosPorPergunta = 0;

let timerInterval = null;

function iniciar() {
    const num = document.getElementById("questions-qty").value;
    const difc = document.getElementById("difficulty").value;
    const categ = document.getElementById("category").value;

    perguntaAtualIndex = 0;
    acertos = 0;

    criar(num, difc, categ);
}

function criar(num, difc, categ) {

    const url = `https://opentdb.com/api.php?amount=${num}&category=${Number.parseInt(categ)}&difficulty=${difc}&type=multiple`;

    fetch(url)
        .then((response) => {
            if (!response.ok) throw new Error("Erro na rede");
            return response.json();
        })
        .then((data) => {

            if (data.response_code !== 0) {
                alert("A API não encontrou perguntas suficientes.");
                return;
            }

            listaPergResp = data.results.map((item) => {
                const todasAlternativas = [
                    ...item.incorrect_answers,
                    item.correct_answer,
                ];

                return {
                    enunciado: item.question,
                    alternativas: todasAlternativas.sort(() => Math.random() - 0.5),
                    respostaCorreta: item.correct_answer,
                };
            });

            segundosPorPergunta = parseInt(
                document.getElementById("timer-select").value
            );

            document.getElementById("setup-screen").classList.add("hidden");
            document.getElementById("quiz-screen").classList.remove("hidden");

            mostrarPergunta();
        })
        .catch((error) => {
            console.error("Erro:", error);
            alert("Erro ao carregar o quiz.");
        });
}

function mostrarPergunta() {

    iniciarTimer();

    const perguntaObj = listaPergResp[perguntaAtualIndex];

    document.getElementById("question-text").innerHTML =
        perguntaObj.enunciado;

    document.getElementById("progress").innerText =
        `Questão ${perguntaAtualIndex + 1} de ${listaPergResp.length}`;

    const botoes = document.querySelectorAll(".option-btn");

    perguntaObj.alternativas.forEach((alt, i) => {
        if (botoes[i]) {
            botoes[i].innerHTML = alt;
            botoes[i].onclick = () => verificarResposta(alt);
        }
    });
}

function verificarResposta(escolhida) {

    pararTimer();

    const correta = listaPergResp[perguntaAtualIndex].respostaCorreta;

    if (escolhida === correta) {
        acertos++;
    }

    perguntaAtualIndex++;

    if (perguntaAtualIndex < listaPergResp.length) {
        mostrarPergunta();
    } else {
        final();
    }
}

function iniciarTimer() {

    pararTimer();

    let segundos = segundosPorPergunta;
    const timerDisplay = document.getElementById("timer-display");

    timerDisplay.innerText = segundos + "s";

    timerInterval = setInterval(() => {

        segundos--;

        timerDisplay.innerText = segundos + "s";

        if (segundos <= 0) {

            pararTimer();

            verificarResposta(null);

        }

    }, 1000);
}

function pararTimer() {
    if (timerInterval) {
        clearInterval(timerInterval);
        timerInterval = null;
    }
}

function final(){

    pararTimer();

    document.getElementById("quiz-screen").classList.add("hidden");
    document.getElementById("result-screen").classList.remove("hidden");

    document.getElementById("final-score").innerText = acertos;
    document.getElementById("total-questions-result").innerText = listaPergResp.length;
}

function voltarAoInicio() {

    document.getElementById("result-screen").classList.add("hidden");
    document.getElementById("setup-screen").classList.remove("hidden");

}