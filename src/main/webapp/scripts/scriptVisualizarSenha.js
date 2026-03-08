const senha = document.getElementById("senha");
const visualizaSenha = document.getElementById("visualizar-senha");

function visualizarSenha() {
    if (visualizaSenha.src.includes("viewEye.png")) {
        visualizaSenha.src = "assets/icons/closeEye.png";
        senha.type = "password";
    } else {
        visualizaSenha.src = "assets/icons/viewEye.png";
        senha.type = "text";
    }
};