package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DTO.AlunoDTO;
import com.example.escola_backend_v2.DTO.TurmaAlunoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;

import java.io.IOException;
import java.util.List;

@WebServlet("/gerarBoletim")
public class BoletimServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        AlunoDTO alunoLogado = (AlunoDTO) session.getAttribute("usuarioLogado");

        if (alunoLogado == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        AlunoDAO alunoDAO = new AlunoDAO();

        AlunoDTO aluno = alunoDAO.buscarAlunoPorId(alunoLogado.getId());

        if (!alunoDAO.notasFaltando(aluno.getId())) {
            response.sendRedirect("homeAluno");
            return;
        }

        List<TurmaAlunoDTO> boletim = aluno.getMatriculas();

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=boletim.pdf");

        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage();
            document.addPage(page);

            PDPageContentStream content = new PDPageContentStream(document, page);


            content.beginText();
            content.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 16);
            content.newLineAtOffset(50, 750);
            content.showText("Boletim Escolar - " + aluno.getNome());
            content.endText();

            int y = 710;

            for (TurmaAlunoDTO ta : boletim) {
                String nomeDisciplina = ta.getTurma().getDisciplina().getNome();

                Double n1 = ta.getNota1();
                Double n2 = ta.getNota2();
                double media = ta.getMedia();

                content.beginText();
                content.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                content.newLineAtOffset(50, y);

                content.showText(
                        nomeDisciplina +
                                " | Nota 1: " + (n1 != null ? n1 : "-") +
                                " | Nota 2: " + (n2 != null ? n2 : "-") +
                                " | Média: " + (media == -1 ? "N/D" : media) +
                                " | Obs: " + (ta.getObservacoes() != null ? ta.getObservacoes() : "")
                );

                content.endText();
                y -= 25;
            }

            content.close();
            document.save(response.getOutputStream());
        }
    }
}
