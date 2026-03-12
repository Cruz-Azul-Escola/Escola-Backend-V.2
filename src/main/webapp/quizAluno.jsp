<%--
  Created by IntelliJ IDEA.
  User: iagodiniz-ieg
  Date: 09/02/2026
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.escola_backend_v2.DTO.AlunoDTO" %>
<%@ page import="com.example.escola_backend_v2.DTO.TurmaAlunoDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <title>Portal do Aluno</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/style.css" />
    <link rel="stylesheet" href="styles/styleAluno.css" />
    <link rel="stylesheet" href="styles/styleQuiz.css" />
    <link rel="shortcut icon" href="assets/icons/Logo da escola.png" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script defer src="scripts/scriptLoad.js"></script>
    <script defer src="scripts/scriptAluno.js"></script>

    <title>Title</title>
</head>
<body>
<header id="cabecalho-site">
    <div id="logotipo">
        <div>
            <img src="assets/icons/Logo da escola.png" alt="">
        </div>
        <div>
            <h1>Cruz Azul</h1>
            <h4>Portal do Professor</h4>
        </div>
    </div>
    <a href="homeAluno">
        <div id="voltar">
            <img src="assets/icons/voltar.png" alt="">
            <h4>Sair</h4>
        </div>
    </a>
</header>
<main class="container">
    <div class="main-wrapper">
        <section id="setup-screen" class="card">
            <h1>Configurações do Quiz</h1>

            <div class="setting-group">
                <label for="category">Categoria</label>
                <select id="category" required>
                    <option value="22">Geografia</option>
                    <option value="23">Historia</option>
                    <option value="25">Arte</option>
                    <option value="27">Biologia</option>
                    <option value="9">Conhecimentos Gerais</option>
                </select>
            </div>

            <div class="setting-group">
                <label for="difficulty">Dificuldade</label>
                <select id="difficulty" required>
                    <option value="easy">Fácil</option>
                    <option value="medium">Médio</option>
                    <option value="hard">Difícil</option>
                </select>
            </div>

            <div class="setting-group">
                <label for="questions-qty">Quantidade de Questões</label>
                <input
                        required
                        type="number"
                        id="questions-qty"
                        min="1"
                        max="50"
                        value="10"
                />
            </div>

            <div class="setting-group">
                <label for="timer-select">Tempo por Questão (segundos)</label>
                <select id="timer-select" required>
                    <option value="15">15s</option>
                    <option value="30" selected>30s</option>
                    <option value="60">60s</option>
                </select>
            </div>

            <button onclick="iniciar()" id="start-btn" class="primary-btn">
                Iniciar Quiz
            </button>
        </section>

        <section id="quiz-screen" class="card hidden">
            <div class="quiz-header">
                <div id="timer-display" class="timer">30s</div>
                <div id="progress">Questão 1 de 10</div>
            </div>

            <div class="question-container">
                <h2 id="question-text"></h2>
                <div id="options-container" class="options-grid">
                    <button id="1" class="option-btn"></button>
                    <button id="2" class="option-btn"></button>
                    <button id="3" class="option-btn"></button>
                    <button id="4" class="option-btn"></button>
                </div>
            </div>

            <button id="next-btn" class="primary-btn hidden">Próxima</button>
        </section>
        <section id="result-screen" class="card hidden">
            <h1>Resultado Final</h1>
            <div class="score-container">
                <span id="final-score">0</span>
                <small>/ <span id="total-questions-result">0</span></small>
            </div>
            <p id="performance-msg">Bom trabalho!</p>
            <button onclick="voltarAoInicio()" class="primary-btn">
                Jogar Novamente
            </button>
        </section>
    </div>
</main>
<script src="scripts/scriptQuiz.js"></script>
</body>
</html>
