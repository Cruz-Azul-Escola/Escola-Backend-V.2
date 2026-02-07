package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.Util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TurmaAlunoDAO {
    Conexao conexao = new Conexao();
    public int atualizarNotas(int idAluno, int idTurma, double n1, double n2, String desc) {
        Connection conn = conexao.conectar();
        String sql = "UPDATE TURMA_ALUNO nota1 = ?, nota2 = ?, observacoes = ? WHERE ID_ALUNO = ? AND id_turma = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setDouble(1, n1);
            stmt.setDouble(2, n2);
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
