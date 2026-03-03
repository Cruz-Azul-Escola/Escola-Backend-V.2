// Abrir iframe
const abrirIframe = document.getElementsByClassName("button-popUp-excluir");

// Documents principais
const main = document.getElementById("admin-main");
const header = document.getElementById("topBar");

// Cliques
for (let i = 0; i < abrirIframe.length; i++) {
  abrirIframe[i].addEventListener("click", () => {
    const iframeExcluir = document.getElementById("popUp-excluir-dados");
    const fecharIframe = iframeExcluir.contentDocument.getElementById("fechar");
    iframeExcluir.style.display = "block";
    header.style.filter = "blur(10px)";
    main.style.filter = "blur(10px)";
    fecharIframe.addEventListener("click", () => {
      iframeExcluir.style.display = "none";
      header.style.filter = "blur(0px)";
      main.style.filter = "blur(0px)";
    });
  });
}