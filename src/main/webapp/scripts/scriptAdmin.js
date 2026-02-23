// Abrir opções
const views = document.getElementsByClassName("views");
const abrirAluno = document.getElementById("view-alunos");
const abrirProfessor = document.getElementById("view-professores");
const abrirTurma = document.getElementById("view-turmas");
const abrirDisciplina = document.getElementById("view-disciplinas");
const abrirSala = document.getElementById("view-salas");
const abrirVinculacao = document.getElementById("view-vinculacoes");

// Seções
const secoes = document.getElementsByClassName("secoes");
const secaoAluno = document.getElementById("secao-aluno");
const secaoProfessor = document.getElementById("secao-professor");
const secaoTurma = document.getElementById("secao-turma");
const secaoDisciplina = document.getElementById("secao-disciplina");
const secaoSala = document.getElementById("secao-sala");
const secaoVinculacao = document.getElementById("secao-vinculacao");

// Cliques
abrirAluno.addEventListener("click", () => {
  for (let i = 0; i < views.length; i++) {
    views[i].style.background = "transparent";
    views[i].style.color = "white";
  }
  for (let i = 0; i < secoes.length; i++) {
    secoes[i].style.display = "none";
  }
  abrirAluno.style.background = "white";
  abrirAluno.style.color = "var(--corAzul)";
  secaoAluno.style.display = "block";
});
abrirProfessor.addEventListener("click", () => {
  for (let i = 0; i < views.length; i++) {
    views[i].style.background = "transparent";
    views[i].style.color = "white";
  }
  for (let i = 0; i < secoes.length; i++) {
    secoes[i].style.display = "none";
  }
  abrirProfessor.style.background = "white";
  abrirProfessor.style.color = "var(--corAzul)";
  secaoProfessor.style.display = "block";
});
abrirTurma.addEventListener("click", () => {
  for (let i = 0; i < views.length; i++) {
    views[i].style.background = "transparent";
    views[i].style.color = "white";
  }
  for (let i = 0; i < secoes.length; i++) {
    secoes[i].style.display = "none";
  }
  abrirTurma.style.background = "white";
  abrirTurma.style.color = "var(--corAzul)";
  secaoTurma.style.display = "block";
});
abrirDisciplina.addEventListener("click", () => {
  for (let i = 0; i < views.length; i++) {
    views[i].style.background = "transparent";
    views[i].style.color = "white";
  }
  for (let i = 0; i < secoes.length; i++) {
    secoes[i].style.display = "none";
  }
  abrirDisciplina.style.background = "white";
  abrirDisciplina.style.color = "var(--corAzul)";
  secaoDisciplina.style.display = "block";
});
abrirSala.addEventListener("click", () => {
  for (let i = 0; i < views.length; i++) {
    views[i].style.background = "transparent";
    views[i].style.color = "white";
  }
  for (let i = 0; i < secoes.length; i++) {
    secoes[i].style.display = "none";
  }
  abrirSala.style.background = "white";
  abrirSala.style.color = "var(--corAzul)";
  secaoSala.style.display = "block";
});
abrirVinculacao.addEventListener("click", () => {
  for (let i = 0; i < views.length; i++) {
    views[i].style.background = "transparent";
    views[i].style.color = "white";
  }
  for (let i = 0; i < secoes.length; i++) {
    secoes[i].style.display = "none";
  }
  abrirVinculacao.style.background = "white";
  abrirVinculacao.style.color = "var(--corAzul)";
  secaoVinculacao.style.display = "block";
});