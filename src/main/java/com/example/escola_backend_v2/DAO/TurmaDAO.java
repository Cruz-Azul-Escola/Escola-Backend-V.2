package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.DTO.DisciplinaDTO;
import com.example.escola_backend_v2.DTO.SalaDTO;
import com.example.escola_backend_v2.DTO.TurmaDTO;
import com.example.escola_backend_v2.Util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TurmaDAO {
    Conexao conexao = new Conexao();
    public void adicionarTurma(int idDisciplina, int idSala, String periodoLetivo) {
        Connection conn = conexao.conectar();
        String sql = "INSERT INTO turma (id_disciplina, id_sala, periodo_letivo) VALUES (?, ?, ?)";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idDisciplina);
            pstmt.setInt(2, idSala);
            pstmt.setString(3, periodoLetivo);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }
    }

    public List<TurmaDTO> listarTurmas() {
        List<TurmaDTO> lista = new ArrayList<>();
        Connection conn = conexao.conectar();

        String sql = "SELECT t.id_turma, t.periodo_letivo, " +
                "d.id_disciplina, d.nome_disciplina, " +
                "s.id_sala, s.nome_sala " +
                "FROM turma t " +
                "JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                "JOIN sala s ON s.id_sala = t.id_sala";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                DisciplinaDTO d = new DisciplinaDTO();
                d.setId(rs.getInt("id_disciplina"));
                d.setNome(rs.getString("nome_disciplina"));

                SalaDTO s = new SalaDTO();
                s.setId(rs.getInt("id_sala"));
                s.setNome(rs.getString("nome_sala"));

                TurmaDTO t = new TurmaDTO();
                t.setId(rs.getInt("id_turma"));
                t.setPeriodoLetivo(rs.getString("periodo_letivo"));
                t.setDisciplina(d);
                t.setSala(s);

                lista.add(t);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }

        return lista;
    }
    public List<TurmaDTO> buscarPorId(int id) {
        List<TurmaDTO> lista = new ArrayList<>();
        Connection conn = conexao.conectar();

        String sql = "SELECT t.id_turma, t.periodo_letivo, " +
                "d.id_disciplina, d.nome_disciplina, " +
                "s.id_sala, s.nome_sala " +
                "FROM turma t " +
                "JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                "JOIN sala s ON s.id_sala = t.id_sala " +
                "WHERE id_turma = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                DisciplinaDTO d = new DisciplinaDTO();
                d.setId(rs.getInt("id_disciplina"));
                d.setNome(rs.getString("nome_disciplina"));

                SalaDTO s = new SalaDTO();
                s.setId(rs.getInt("id_sala"));
                s.setNome(rs.getString("nome_sala"));

                TurmaDTO t = new TurmaDTO();
                t.setId(rs.getInt("id_turma"));
                t.setPeriodoLetivo(rs.getString("periodo_letivo"));
                t.setDisciplina(d);
                t.setSala(s);

                lista.add(t);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }

        return lista;
    }
}
