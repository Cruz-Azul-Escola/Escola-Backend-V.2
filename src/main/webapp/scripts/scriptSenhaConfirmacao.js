const form = document.getElementById("formulario");
form.addEventListener("submit", (event) => {
    event.preventDefault();

    const senha = document.getElementById("senha").value;
    const confirmacaoSenha = document.getElementById("confirmacaoSenha").value;

    if (senha !== confirmacaoSenha) {
        alert("As senhas não coincidem. Por favor, tente novamente.");
        return;
    } else {
        form.submit();
    }
});