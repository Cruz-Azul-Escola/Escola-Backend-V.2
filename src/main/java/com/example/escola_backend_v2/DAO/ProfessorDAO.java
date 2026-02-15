package com.example.escola_backend_v2.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.escola_backend_v2.DTO.ProfessorDTO;
import com.example.escola_backend_v2.Util.Conexao;

public class ProfessorDAO {
    Conexao conexao = new Conexao();

    //Método para atualizar nome
    public int editarNome(String nome, int id){
        Connection conn = conexao.conectar();
        String query = "UPDATE professor SET nome = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, nome);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para atualizar email
    public int editarEmail(String email, String nome){
        Connection conn = conexao.conectar();
        String query = "UPDATE professor SET email = ? WHERE nome = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, nome);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para atualizar senha
    public int editarSenha(String senha, String nome){
        Connection conn = conexao.conectar();
        String query = "UPDATE professor SET email = ? WHERE nome = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, senha);
            pstmt.setString(2, nome);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para desativar
    public int desativar(String nome){
        Connection conn = conexao.conectar();
        String query = "UPDATE professor SET esta_ativo = false WHERE nome = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, nome);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para vizualizar professor
    public int buscarProfessor(String nome){
        Connection conn = conexao.conectar();
        String query ="SELECT * FROM professor WHERE nome = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, nome);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return 1;
            }else{
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

    //Listar todos os Professores
    public List<ProfessorDTO> listarProfessores(){
        List<ProfessorDTO> professores = new ArrayList<>();
        Connection conn = conexao.conectar();
        String query = "SELECT * FROM professor";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ProfessorDTO professor = new ProfessorDTO();
                professor.setId(rs.getInt("id_professor"));
                professor.setNome(rs.getString("nome"));
                professor.setEmail(rs.getString("email"));
                professor.setSenha(rs.getString("senha"));
                professor.setEstaAtivo(rs.getBoolean("esta_ativo"));
                professores.add(professor);

            }
            return professores;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

}
