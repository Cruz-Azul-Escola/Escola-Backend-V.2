const header = document.getElementById("cabecalho-site");
const main = document.getElementById("secao-principal");
const notas = document.getElementById("notas");
const obs = document.getElementById("observacoes");
const fecharNotas = document.getElementById("notas").contentDocument.getElementById("fecharNotas");
const fecharObservacoes = document.getElementById("observacoes").contentDocument.getElementById("fecharObservacoes");

document.getElementById("btn-notas").onclick = () => {
    notas.style.display = "block";
    header.style.filter = "blur(10px)";
    main.style.filter = "blur(10px)";
};

document.getElementById("btn-observacoes").onclick = () => {
    obs.style.display = "block";
    header.style.filter = "blur(10px)";
    main.style.filter = "blur(10px)";
};

fecharNotas.onclick = () => {
    notas.style.display = "none";
    header.style.filter = "none";
    main.style.filter = "none";
};

fecharObservacoes.onclick = () => {
    obs.style.display = "none";
    header.style.filter = "none";
    main.style.filter = "none";
};