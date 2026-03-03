const tabNotas = document.getElementById("tab-notas");
const tabObs = document.getElementById("tab-observacoes");
const painelNotas = document.getElementById("painel-notas");
const painelObs = document.getElementById("painel-observacoes");

function ativarNotas() {
    tabNotas.classList.add("ativa");
    tabObs.classList.remove("ativa");
    tabNotas.setAttribute("aria-selected", "true");
    tabObs.setAttribute("aria-selected", "false");
    painelNotas.style.display = "block";
    painelObs.style.display = "none";
}

function ativarObservacoes() {
    tabObs.classList.add("ativa");
    tabNotas.classList.remove("ativa");
    tabObs.setAttribute("aria-selected", "true");
    tabNotas.setAttribute("aria-selected", "false");
    painelObs.style.display = "block";
    painelNotas.style.display = "none";
}

tabNotas.addEventListener("click", ativarNotas);
tabObs.addEventListener("click", ativarObservacoes);