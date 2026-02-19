package com.example.escola_backend_v2.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.escola_backend_v2.DTO.DisciplinaDTO;
import com.example.escola_backend_v2.Util.Conexao;

public class DisciplinaDAO {
    Conexao conexao = new Conexao();

    //Método para inserir
    public void adicionarDisciplina(String disciplina, int cargaHoraria){
        Connection conn = conexao.conectar();
        String query = "INSERT INTO disciplina(nome_disciplina, carga_horaria) VALUES(?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, disciplina);
            pstmt.setInt(2, cargaHoraria);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

    //Método para editar nome
    public int editarNome (String disciplina, int id) {
        Connection conn = conexao.conectar();
        String query = "UPDATE disciplina SET disciplina_nome = ? WHERE id_disciplina = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, disciplina);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }
    public int editarDisciplina(DisciplinaDTO disciplina) {

        Connection conn = conexao.conectar();

        String query =
                "UPDATE disciplina SET nome_disciplina = ?, carga_horaria = ? " +
                        "WHERE id_disciplina = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, disciplina.getNome());
            pstmt.setInt(2, disciplina.getCargaHoraria());
            pstmt.setInt(3, disciplina.getId());

            return pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }
    }

    //Método para editar carga horária
    public int editarCargaHorária (int cargaHoraria, int id) {
        Connection conn = conexao.conectar();
        String query = "UPDATE disciplina SET carga_horaria = ? WHERE id_disciplina = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, cargaHoraria);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

    //Método para excluir disciplina
    public void excluirDisciplina(int id) {
        Connection conn = conexao.conectar();
        String query = "DELETE FROM disciplina WHERE disciplina_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para consultar disciplina
    public DisciplinaDTO buscar(int id){
        Connection conn = conexao.conectar();
        String query = "SELECT * FROM disciplina WHERE id_disciplina = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            DisciplinaDTO disciplinaDTO = new DisciplinaDTO();
            if (rs.next()){
                disciplinaDTO.setId(rs.getInt("id_disciplina"));
                disciplinaDTO.setNome(rs.getString("nome_disciplina"));
                disciplinaDTO.setCargaHoraria(rs.getInt("carga_horaria"));
                return disciplinaDTO;
            }
            return null;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }
    }

    //Método para listar disciplinas 
     public List<DisciplinaDTO> listarDisciplina() {
        List<DisciplinaDTO> disciplinas = new ArrayList<>();
        Connection conn = conexao.conectar();
        String query = "SELECT * FROM disciplina";

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                DisciplinaDTO disciplina = new DisciplinaDTO();
                disciplina.setId(rs.getInt("id_disciplina"));
                disciplina.setNome(rs.getString("nome_disciplina"));
                disciplina.setCargaHoraria(rs.getInt("carga_horaria"));
                disciplinas.add(disciplina);
            }
            return disciplinas;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
     }
}
