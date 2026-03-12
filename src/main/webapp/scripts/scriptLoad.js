function mostrarLoader() {
    Swal.fire({
        title: 'Processando...',
        text: 'Aguarde um momento',
        allowOutsideClick: false,
        allowEscapeKey: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
}