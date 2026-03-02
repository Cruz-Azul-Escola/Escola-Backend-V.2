const cpfInput = document.getElementById("cpf");
const erro = document.getElementById("cpf-erro");

cpfInput.addEventListener("input", function () {

    // Remove tudo que não for número
    let cpf = this.value.replace(/\D/g, "");

    // Aplica máscara automaticamente
    if (cpf.length > 3) {
        cpf = cpf.replace(/^(\d{3})(\d)/, "$1.$2");
    }
    if (cpf.length > 7) {
        cpf = cpf.replace(/^(\d{3})\.(\d{3})(\d)/, "$1.$2.$3");
    }
    if (cpf.length > 11) {
        cpf = cpf.replace(/^(\d{3})\.(\d{3})\.(\d{3})(\d)/, "$1.$2.$3-$4");
    }

    this.value = cpf;

    // Validação quando estiver completo
    if (cpf.length === 14) {
        if (validarCPF(cpf)) {
            this.classList.remove("invalido");
            this.classList.add("valido");
            erro.textContent = "";
        } else {
            this.classList.remove("valido");
            this.classList.add("invalido");
            erro.textContent = "CPF inválido.";
        }
    } else {
        this.classList.remove("valido", "invalido");
        erro.textContent = "";
    }
});

function validarCPF(cpf) {
    cpf = cpf.replace(/\D/g, "");

    if (cpf.length !== 11) return false;

    // Rejeita CPFs iguais (11111111111, etc)
    if (/^(\d)\1+$/.test(cpf)) return false;

    let soma = 0;
    let resto;

    // Primeiro dígito
    for (let i = 1; i <= 9; i++) {
        soma += parseInt(cpf.substring(i-1, i)) * (11 - i);
    }

    resto = (soma * 10) % 11;
    if (resto === 10 || resto === 11) resto = 0;
    if (resto !== parseInt(cpf.substring(9, 10))) return false;

    soma = 0;

    // Segundo dígito
    for (let i = 1; i <= 10; i++) {
        soma += parseInt(cpf.substring(i-1, i)) * (12 - i);
    }

    resto = (soma * 10) % 11;
    if (resto === 10 || resto === 11) resto = 0;
    if (resto !== parseInt(cpf.substring(10, 11))) return false;

    return true;
}