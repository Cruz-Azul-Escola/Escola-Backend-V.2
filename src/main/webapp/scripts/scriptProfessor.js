const abrirNotas = document.getElementById("abrirNotas");
const abrirObservacoes = document.getElementById("abrirObservacoes");

const viewNotas = document.getElementById("notas-lancadas");
const viewObservacoes = document.getElementById("observacoes-lancadas");

abrirNotas.addEventListener("click", () => {
    viewNotas.style.display = "block";
    viewObservacoes.style.display = "none";
    abrirNotas.style.backgroundColor = "white"
    abrirObservacoes.style.backgroundColor = "transparent"
});
abrirObservacoes.addEventListener("click", () => {
    viewObservacoes.style.display = "flex";
    viewNotas.style.display = "none";
    abrirObservacoes.style.backgroundColor = "white"
    abrirNotas.style.backgroundColor = "transparent"
});