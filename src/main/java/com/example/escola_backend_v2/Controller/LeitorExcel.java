package com.example.escola_backend_v2.Controller;

import com.example.escola_backend_v2.DAO.AlunoDAO;
import com.example.escola_backend_v2.DAO.SalaDAO;
import com.example.escola_backend_v2.DTO.AlunoDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileOutputStream;
import java.io.IOException;

import java.io.IOException;
import java.io.InputStream;

@WebServlet(urlPatterns = {"/ImportarAlunosServlet"})
@MultipartConfig
public class LeitorExcel extends HttpServlet {
    AlunoDAO alunoDAO = new AlunoDAO();
    SalaDAO salaDAO = new SalaDAO();


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part arquivo = request.getPart("arquivoExcel");

        // Uso do Try-with-resources para garantir que o InputStream e o Workbook fechem sozinhos
        try (InputStream inputStream = arquivo.getInputStream();
             Workbook workbook = new XSSFWorkbook(inputStream)) {

            Sheet sheet = workbook.getSheetAt(0);

            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // Pula cabeçalho

                // Tratando as células para aceitar tanto texto quanto número
                String nome = getCellValueAsString(row.getCell(0));
                String cpf = getCellValueAsString(row.getCell(1));
                String matricula = getCellValueAsString(row.getCell(2));
                String nomeSala = getCellValueAsString(row.getCell(3));

                if (nome.isEmpty()) continue; // Pula linha vazia

                int idSala = salaDAO.buscarSalaPorNome(nomeSala);

                AlunoDTO aluno = new AlunoDTO();
                aluno.setNome(nome);
                aluno.setCpf(cpf);
                aluno.setMatricula(matricula);
                aluno.setIdSala(idSala);

                alunoDAO.preCadastro(aluno);
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("admin");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Log detalhado no console
            response.sendRedirect("admin");
        }
    }

    // Método auxiliar essencial para evitar o
    private String getCellValueAsString(org.apache.poi.ss.usermodel.Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                // Converte número para String sem casas decimais
                return String.format("%.0f", cell.getNumericCellValue());
            case BLANK:
                return "";
            default:
                return "";
        }
    }


}