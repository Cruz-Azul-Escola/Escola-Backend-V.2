package com.example.escola_backend_v2.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.escola_backend_v2.DTO.ProfessorDTO;
import com.example.escola_backend_v2.DTO.SalaDTO;
import com.example.escola_backend_v2.Util.Conexao;

public class SalaDAO {

    Conexao conexao = new Conexao();

    //Método para inserir sala
    public void adicionarSala(String sala, int capacidade){
        Connection conn = conexao.conectar();
        String query = "INSERT INTO sala(nome_sala, capacidade) VALUES(?,?)";

        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, sala);
            pstmt.setInt(2, capacidade);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para editar nome da sala
    public int editarNome(String sala, int id) {
        Connection conn = conexao.conectar();
        String query = "UPDATE sala SET nome_sala = ? WHERE id_sala = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, sala);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

    //Método para editar capacidade da sala
    public int editarSala(int capacidade, int id) {
        Connection conn = conexao.conectar();
        String query = "UPDATE sala SET capacidade = ? WHERE id_sala = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, capacidade);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

    //Método para excluir sala
    public void excluirSala(String sala) {
        Connection conn = conexao.conectar();
        String query = "DELETE FROM sala WHERE sala = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, query);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }

    //Método para buscar sala
    public int buscarSala(String sala){
        Connection conn = conexao.conectar();
        String query = "SELECT * FROM sala WHERE sala = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, sala);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return 1;
            } else{
                return 0;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{
            conexao.desconectar(conn);
        }
    }

    //Método para listar todas as salas
    public List<SalaDTO> listarSalas(){
        List<SalaDTO> salas = new ArrayList<>();
        Connection conn = conexao.conectar();
        String query = "SELECT * FROM sala";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                SalaDTO sala = new SalaDTO();
                sala.setId(rs.getInt("id_sala"));
                sala.setNome(rs.getString("nome_sala"));
                sala.setCapacidade(rs.getInt("capacidade"));
                salas.add(sala);
            }
            return salas;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            conexao.desconectar(conn);
        }
    }
}
