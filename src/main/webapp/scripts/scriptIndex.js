let clickes = 0;
document.getElementById("button-area-restrita").addEventListener("click", () => {
    clickes ++;
    if (clickes >= 5) {
        window.location.href = "../pages/areaRestritaLogin.html";
    }
})