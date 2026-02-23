
package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.DTO.ProfessorDTO;
import com.example.escola_backend_v2.DTO.ProfessorTurmaDTO;
import com.example.escola_backend_v2.DTO.TurmaDTO;
import com.example.escola_backend_v2.Util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProfessorTurmaDAO {
    List<ProfessorTurmaDTO> professorTurmas = new ArrayList<>();
    Conexao conexao = new Conexao();

    public List<ProfessorTurmaDTO> buscarPorProfessor(int idProfessor) {
        String sql = "SELECT * FROM professor_turma WHERE professor_id = ?";
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setInt(1, idProfessor);
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                ProfessorTurmaDTO professorTurma = new ProfessorTurmaDTO();
                ProfessorDTO professor = new ProfessorDTO();
                professor.setId(rs.getInt("professor_id"));
                TurmaDTO turma = new TurmaDTO();
                turma.setId(rs.getInt("turma_id"));
                professorTurma.setProfessor(professor);
                professorTurma.setTurma(turma);

                professorTurmas.add(professorTurma);

            }
            return professorTurmas;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }
    }
}