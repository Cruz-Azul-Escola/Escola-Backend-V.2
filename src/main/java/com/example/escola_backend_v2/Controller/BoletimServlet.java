package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DTO.AlunoDTO;
import com.example.escola_backend_v2.DTO.TurmaAlunoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.font.*;
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

        List<TurmaAlunoDTO> boletim = aluno.getMatriculas();

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=boletim.pdf");

        try (PDDocument document = new PDDocument()) {

            PDPage page = new PDPage();
            document.addPage(page);

            PDPageContentStream content = new PDPageContentStream(document, page);

            // ===== TÍTULO =====
            content.beginText();
            content.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 18);
            content.newLineAtOffset(50, 750);
            content.showText("Boletim Escolar");
            content.endText();

            content.beginText();
            content.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
            content.newLineAtOffset(50, 730);
            content.showText("Aluno: " + aluno.getNome());
            content.endText();

            // ===== CONFIG TABELA =====
            float startX = 50;
            float startY = 680;
            float rowHeight = 30;

            float colDisc = 200;
            float colNota = 80;
            float colObs = 150;

            // ===== CABEÇALHO AZUL =====
            drawCell(content, startX, startY, colDisc, rowHeight, 0.2f,0.4f,0.8f);
            drawCell(content, startX + colDisc, startY, colNota, rowHeight, 0.2f,0.4f,0.8f);
            drawCell(content, startX + colDisc + colNota, startY, colNota, rowHeight, 0.2f,0.4f,0.8f);
            drawCell(content, startX + colDisc + colNota*2, startY, colNota, rowHeight, 0.2f,0.4f,0.8f);
            drawCell(content, startX + colDisc + colNota*3, startY, colObs, rowHeight, 0.2f,0.4f,0.8f);

            content.setNonStrokingColor(1,1,1);

            writeText(content,"Disciplina",startX+10,startY+10);
            writeText(content,"Nota 1",startX+colDisc+10,startY+10);
            writeText(content,"Nota 2",startX+colDisc+colNota+10,startY+10);
            writeText(content,"Média",startX+colDisc+colNota*2+10,startY+10);
            writeText(content,"Obs",startX+colDisc+colNota*3+10,startY+10);

            // ===== LINHAS DA TABELA =====
            float y = startY - rowHeight;
            boolean cinza = false;

            for (TurmaAlunoDTO ta : boletim) {

                float r = cinza ? 0.95f : 1f;
                float g = cinza ? 0.95f : 1f;
                float b = cinza ? 0.95f : 1f;

                drawCell(content,startX,y,colDisc,rowHeight,r,g,b);
                drawCell(content,startX+colDisc,y,colNota,rowHeight,r,g,b);
                drawCell(content,startX+colDisc+colNota,y,colNota,rowHeight,r,g,b);
                drawCell(content,startX+colDisc+colNota*2,y,colNota,rowHeight,r,g,b);
                drawCell(content,startX+colDisc+colNota*3,y,colObs,rowHeight,r,g,b);

                content.setNonStrokingColor(0,0,0);

                writeText(content,
                        ta.getTurma().getDisciplina().getNome(),
                        startX+10,y+10);

                writeText(content,
                        ta.getNota1()!=null?ta.getNota1().toString():"-",
                        startX+colDisc+10,y+10);

                writeText(content,
                        ta.getNota2()!=null?ta.getNota2().toString():"-",
                        startX+colDisc+colNota+10,y+10);

                writeText(content,
                        ta.getMedia()==-1?"N/D":String.valueOf(ta.getMedia()),
                        startX+colDisc+colNota*2+10,y+10);

                writeText(content,
                        ta.getObservacoes()!=null?ta.getObservacoes():"-",
                        startX+colDisc+colNota*3+10,y+10);

                y -= rowHeight;
                cinza = !cinza;
            }

            content.close();
            document.save(response.getOutputStream());
        }
    }

    // ===== DESENHAR CÉLULA =====
    private void drawCell(PDPageContentStream content,
                          float x, float y,
                          float width, float height,
                          float r, float g, float b) throws IOException {

        content.setNonStrokingColor(r,g,b);
        content.addRect(x,y,width,height);
        content.fill();

        content.setStrokingColor(0,0,0);
        content.addRect(x,y,width,height);
        content.stroke();
    }

    // ===== ESCREVER TEXTO =====
    private void writeText(PDPageContentStream content,
                           String text,
                           float x, float y) throws IOException {

        content.beginText();
        content.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA),11);
        content.newLineAtOffset(x,y);
        content.showText(text);
        content.endText();
    }
}