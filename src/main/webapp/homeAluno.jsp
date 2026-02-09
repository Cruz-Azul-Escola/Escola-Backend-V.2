<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.escola_backend_v2.DTO.TurmaAlunoDTO" %>
<%@ page import="com.example.escola_backend_v2.DTO.AlunoDTO" %>

<%
  AlunoDTO aluno = (AlunoDTO) request.getAttribute("aluno");

  if (aluno == null) {
%>
<p style="color:red;">Aluno não encontrado!</p>
<%
    return;
  }

  List<TurmaAlunoDTO> boletim = aluno.getMatriculas();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Home do Aluno</title>
  <style>
    * { box-sizing: border-box; font-family: Arial, sans-serif; }
    body { margin: 0; background: #eaf1fb; }
    .topbar { height: 60px; background: #ff8a00; color: white; display: flex; align-items: center; padding: 0 20px; justify-content: space-between; font-weight: bold; }
    .sidebar { position: fixed; top: 60px; left: 0; width: 80px; height: calc(100vh - 60px); background: #ff8a00; display: flex; justify-content: center; padding-top: 20px; color: white; }
    .main { margin-left: 100px; padding: 30px; display: flex; gap: 30px; }
    .left-column { width: 250px; display: flex; flex-direction: column; gap: 20px; }
    .card { background: white; border-radius: 12px; padding: 20px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
    .profile-icon { width: 80px; height: 80px; border: 3px solid #0a3fa8; border-radius: 50%; margin: 0 auto 10px; display: flex; align-items: center; justify-content: center; color: #0a3fa8; font-size: 40px; font-weight: bold; }
    .status { text-align: center; color: green; font-weight: bold; margin-top: 10px; }
    .formula { text-align: center; }
    .formula span { background: #ff8a00; color: white; padding: 4px 8px; border-radius: 6px; font-weight: bold; }
    .table-container { flex: 1; background: white; border-radius: 12px; padding: 20px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); display: flex; flex-direction: column; }
    table { width: 100%; border-collapse: collapse; }
    thead { background: #f2f2f2; }
    th, td { padding: 10px; text-align: center; border-bottom: 1px solid #ddd; }
    .table-scroll { overflow-y: auto; max-height: 400px; }
    .download-btn { align-self: flex-end; margin-top: 15px; background: #ff8a00; color: white; border: none; padding: 10px 18px; border-radius: 20px; cursor: pointer; font-weight: bold; }
    .download-btn:hover { background: #e57900; }
  </style>
</head>
<body>

<div class="topbar">
  <div>← Suas Disciplinas</div>
  <div>Profile</div>
</div>

<div class="sidebar">
  Notas
</div>

<div class="main">

  <div class="left-column">
    <div class="card">
      <div class="profile-icon"><svg width="300px" height="300px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g clip-path="url(#clip0_15_82)"> <rect width="24" height="24" fill="white"></rect> <g filter="url(#filter0_d_15_82)"> <path d="M14.3365 12.3466L14.0765 11.9195C13.9082 12.022 13.8158 12.2137 13.8405 12.4092C13.8651 12.6046 14.0022 12.7674 14.1907 12.8249L14.3365 12.3466ZM9.6634 12.3466L9.80923 12.8249C9.99769 12.7674 10.1348 12.6046 10.1595 12.4092C10.1841 12.2137 10.0917 12.022 9.92339 11.9195L9.6634 12.3466ZM4.06161 19.002L3.56544 18.9402L4.06161 19.002ZM19.9383 19.002L20.4345 18.9402L19.9383 19.002ZM16 8.5C16 9.94799 15.2309 11.2168 14.0765 11.9195L14.5965 12.7737C16.0365 11.8971 17 10.3113 17 8.5H16ZM12 4.5C14.2091 4.5 16 6.29086 16 8.5H17C17 5.73858 14.7614 3.5 12 3.5V4.5ZM7.99996 8.5C7.99996 6.29086 9.79082 4.5 12 4.5V3.5C9.23854 3.5 6.99996 5.73858 6.99996 8.5H7.99996ZM9.92339 11.9195C8.76904 11.2168 7.99996 9.948 7.99996 8.5H6.99996C6.99996 10.3113 7.96342 11.8971 9.40342 12.7737L9.92339 11.9195ZM9.51758 11.8683C6.36083 12.8309 3.98356 15.5804 3.56544 18.9402L4.55778 19.0637C4.92638 16.1018 7.02381 13.6742 9.80923 12.8249L9.51758 11.8683ZM3.56544 18.9402C3.45493 19.8282 4.19055 20.5 4.99996 20.5V19.5C4.70481 19.5 4.53188 19.2719 4.55778 19.0637L3.56544 18.9402ZM4.99996 20.5H19V19.5H4.99996V20.5ZM19 20.5C19.8094 20.5 20.545 19.8282 20.4345 18.9402L19.4421 19.0637C19.468 19.2719 19.2951 19.5 19 19.5V20.5ZM20.4345 18.9402C20.0164 15.5804 17.6391 12.8309 14.4823 11.8683L14.1907 12.8249C16.9761 13.6742 19.0735 16.1018 19.4421 19.0637L20.4345 18.9402Z" fill="#000000"></path> </g> </g> <defs> <filter id="filter0_d_15_82" x="2.55444" y="3.5" width="18.8911" height="19" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"> <feFlood flood-opacity="0" result="BackgroundImageFix"></feFlood> <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"></feColorMatrix> <feOffset dy="1"></feOffset> <feGaussianBlur stdDeviation="0.5"></feGaussianBlur> <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"></feColorMatrix> <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_15_82"></feBlend> <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_15_82" result="shape"></feBlend> </filter> <clipPath id="clip0_15_82"> <rect width="24" height="24" fill="white"></rect> </clipPath> </defs> </g></svg></div>
      <p><strong>Nome:</strong> <%= aluno.getNome() %></p>
      <p><strong>Matrícula:</strong> <%= aluno.getMatricula() %></p>
      <p><strong>Sala:</strong> <%= boletim.get(0).getTurma().getSala().getNome() %></p>
      <div class="status">EM PROCESSO</div>
    </div>

    <div class="card formula">
      <h4>Fórmulas</h4>
      <p><span>Média</span> = (nota1 + nota2) / 2</p>
    </div>
  </div>

  <div class="table-container">
    <div class="table-scroll">
      <table>
        <thead>
        <tr>
          <th>Disciplina</th>
          <th>Nota 1</th>
          <th>Nota 2</th>
          <th>Média</th>
          <th>Observações</th>
        </tr>
        </thead>
        <tbody>
        <%
          if (boletim != null && !boletim.isEmpty()) {
            for (TurmaAlunoDTO ta : boletim) {
        %>
        <tr>
          <td><%= ta.getTurma().getDisciplina().getNome() %></td>
          <td><%= ta.getNota1() != null ? ta.getNota1() : "-" %></td>
          <td><%= ta.getNota2() != null ? ta.getNota2() : "-" %></td>
          <td>
            <%= ta.getMedia() == -1 ? "Não disponível" : ta.getMedia() %>
          </td>
          <td><%= ta.getObservacoes() != null ? ta.getObservacoes() : "" %></td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="5">Nenhuma disciplina encontrada.</td>
        </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>

    <%
      Boolean completo = (Boolean) request.getAttribute("boletimCompleto");
      if (completo != null && completo) {
    %>
    <form action="gerarBoletim" method="get">
      <button class="download-btn" type="submit">Baixar Boletim ⬇</button>
    </form>
    <%
      }
    %>
  </div>

</div>

</body>
</html>
