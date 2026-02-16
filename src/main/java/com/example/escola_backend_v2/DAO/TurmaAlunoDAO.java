package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.Util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TurmaAlunoDAO {
    Conexao conexao = new Conexao();
    public int atualizarNotas(int idAluno, int idTurma,
                              Double n1, Double n2, String desc) {

        Connection conn = conexao.conectar();

        String sql = "UPDATE turma_aluno " +
                "SET nota1 = ?, nota2 = ?, observacoes = ? " +
                "WHERE id_aluno = ? AND id_turma = ?";

        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            if (n1 != null)
                stmt.setDouble(1, n1);
            else
                stmt.setNull(1, java.sql.Types.NUMERIC);

            if (n2 != null)
                stmt.setDouble(2, n2);
            else
                stmt.setNull(2, java.sql.Types.NUMERIC);

            stmt.setString(3, desc);
            stmt.setInt(4, idAluno);
            stmt.setInt(5, idTurma);

            return stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }
    }

}
