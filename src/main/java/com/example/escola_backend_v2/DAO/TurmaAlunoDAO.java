package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.DTO.AlunoDTO;
import com.example.escola_backend_v2.DTO.TurmaAlunoDTO;
import com.example.escola_backend_v2.DTO.TurmaDTO;
import com.example.escola_backend_v2.Util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TurmaAlunoDAO {
    Conexao conexao = new Conexao();
    public int atualizarNotas(int idAluno, int idTurma, Double n1, Double n2, String desc) {

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


    public List<TurmaAlunoDTO> buscaPorProfessorTurma(TurmaDTO turma) {
        List<TurmaAlunoDTO> turmaAlunos = new ArrayList<>();
        String sql = "SELECT ta.*, a.nome, a.email, a.matricula FROM turma_aluno ta JOIN aluno a on ta.id_aluno = a.id_aluno WHERE ta.id_turma = ?";
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setInt(1, turma.getId());
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                TurmaAlunoDTO turmaAluno = new TurmaAlunoDTO();
                turmaAluno.setTurma(turma);
                turmaAluno.setNota1(rs.getDouble("nota1"));
                turmaAluno.setNota2(rs.getDouble("nota2"));
                turmaAluno.setObservacoes(rs.getString("observacoes"));
                AlunoDTO aluno = new AlunoDTO();
                aluno.setId(rs.getInt("id_aluno"));
                aluno.setMatricula(rs.getString("matricula"));
                aluno.setNome(rs.getString("nome"));
                aluno.setEmail(rs.getString("email"));
                turmaAluno.setAluno(aluno);
                turmaAlunos.add(turmaAluno);
            }
            return turmaAlunos;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }
    }

}
