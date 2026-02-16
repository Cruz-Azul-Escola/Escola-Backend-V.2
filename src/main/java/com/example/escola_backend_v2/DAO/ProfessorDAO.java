package com.example.escola_backend_v2.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.escola_backend_v2.DTO.*;
import com.example.escola_backend_v2.Util.Conexao;
import org.python.antlr.ast.Str;

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

    public ProfessorDTO buscarPorId( int id){
        Connection conn = conexao.conectar();
        String sql= "SELECT\n" +
                "    p.id_professor,\n" +
                "    p.nome AS nome_professor,\n" +
                "    p.email,\n" +
                "    p.esta_ativo,\n" +
                "\n" +
                "    t.id_turma,\n" +
                "    t.periodo_letivo,\n" +
                "\n" +
                "    d.id_disciplina,\n" +
                "    d.nome_disciplina,\n" +
                "    d.carga_horaria,\n" +
                "\n" +
                "    s.id_sala,\n" +
                "    s.nome_sala,\n" +
                "\n" +
                "    a.id_aluno,\n" +
                "    a.nome AS nome_aluno,\n" +
                "    a.matricula,\n" +
                "    a.email AS email_aluno,\n" +
                "    a.esta_ativo AS aluno_ativo,\n" +
                "\n" +
                "    ta.nota1,\n" +
                "    ta.nota2,\n" +
                "    ta.observacoes\n" +
                "\n" +
                "FROM professor p\n" +
                "LEFT JOIN professor_turma pt \n" +
                "    ON pt.professor_id = p.id_professor\n" +
                "LEFT JOIN turma t \n" +
                "    ON t.id_turma = pt.turma_id\n" +
                "LEFT JOIN disciplina d \n" +
                "    ON d.id_disciplina = t.id_disciplina\n" +
                "LEFT JOIN sala s \n" +
                "    ON s.id_sala = t.id_sala\n" +
                "LEFT JOIN turma_aluno ta \n" +
                "    ON ta.id_turma = t.id_turma\n" +
                "LEFT JOIN aluno a \n" +
                "    ON a.id_aluno = ta.id_aluno\n" +
                "WHERE p.id_professor = ?\n" +
                "ORDER BY t.id_turma, a.nome;";

        ProfessorDTO professor = null;
        Map<Integer, TurmaDTO> mapaTurmas = new HashMap<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()){
                //serve para não ficar substituindo o profesor pelo msm
                if (professor == null) {
                    professor = new ProfessorDTO();
                    professor.setId(rs.getInt("id_professor"));
                    professor.setNome(rs.getString("nome_professor"));
                    professor.setEmail(rs.getString("email"));
                    professor.setEstaAtivo(rs.getBoolean("esta_ativo"));
                    professor.setTurmas(new ArrayList<>());
                }
                int idTurma = (Integer) rs.getObject("id_turma");
                if (idTurma != 0) {

                    TurmaDTO turma = mapaTurmas.get(idTurma);

                    if (turma == null) {
                        turma = new TurmaDTO();
                        turma.setId(idTurma);
                        turma.setPeriodoLetivo(rs.getString("periodo_letivo"));

                        // Disciplina
                        DisciplinaDTO disciplina = new DisciplinaDTO();
                        disciplina.setId(rs.getInt("id_disciplina"));
                        disciplina.setNome(rs.getString("nome_disciplina"));
                        disciplina.setCargaHoraria(rs.getInt("carga_horaria"));
                        turma.setDisciplina(disciplina);

                        // Sala
                        SalaDTO sala = new SalaDTO();
                        sala.setId(rs.getInt("id_sala"));
                        sala.setNome(rs.getString("nome_sala"));
                        turma.setSala(sala);

                        turma.setAlunos(new ArrayList<>());
                        turma.setProfessores(new ArrayList<>());

                        mapaTurmas.put(idTurma, turma);
                        professor.getTurmas().add(turma);
                    }

                    Integer idAluno = (Integer) rs.getObject("id_aluno");

                    if (idAluno != null) {

                        AlunoDTO aluno = new AlunoDTO();
                        aluno.setId(idAluno);
                        aluno.setNome(rs.getString("nome_aluno"));
                        aluno.setMatricula(rs.getString("matricula"));
                        aluno.setEmail(rs.getString("email_aluno"));
                        aluno.setEstaAtivo(rs.getBoolean("aluno_ativo"));
                        TurmaAlunoDTO turmaAluno = new TurmaAlunoDTO();
                        turmaAluno.setAluno(aluno);
                        turmaAluno.setTurma(turma);
                        turmaAluno.setNota1(rs.getDouble("nota1"));
                        turmaAluno.setNota2(rs.getDouble("nota2"));
                        turmaAluno.setObservacoes(rs.getString("observacoes"));

                        turma.getAlunos().add(turmaAluno);
                    }

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return professor;
    }

    public int contarTotalAlunosDoProfessor(int idProfessor) {
        Connection conn = conexao.conectar();
        String sql = "SELECT COUNT(DISTINCT ta.id_aluno) AS total\n" +
                "FROM professor_turma pt\n" +
                "INNER JOIN turma_aluno ta ON ta.id_turma = pt.turma_id\n" +
                "WHERE pt.professor_id = ?";

        int total = 0;

        try{
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idProfessor);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public List<TurmaDTO> listarTurmasDoProfessor(int idProfessor) {
        List<TurmaDTO> turmas = new ArrayList<>();
        Connection conn = conexao.conectar();
        String sql = "SELECT t.id_turma, t.periodo_letivo, " +
                "d.id_disciplina, d.nome_disciplina, " +
                "s.id_sala, s.nome_sala " +
                "FROM professor_turma pt " +
                "JOIN turma t ON t.id_turma = pt.turma_id " +
                "JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                "JOIN sala s ON s.id_sala = t.id_sala " +
                "WHERE pt.professor_id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idProfessor);
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

                turmas.add(t);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }

        return turmas;
    }

    public void vincularProfessorTurma(int idProfessor, int idTurma) {

        Connection conn = conexao.conectar();
        String sql = "INSERT INTO professor_turma (professor_id, turma_id) VALUES (?, ?)";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idProfessor);
            pstmt.setInt(2, idTurma);
            pstmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }
    }


    public void criarProfessorCompleto(ProfessorDTO professor, List<Integer> turmaIds) {
        Connection conn = conexao.conectar();
        PreparedStatement ptmt = null;

        try {
            String sqlInsertProfessor = "INSERT INTO professor (nome, email, senha, esta_ativo) VALUES (?, ?, ?, ?)";
            ptmt = conn.prepareStatement(sqlInsertProfessor, Statement.RETURN_GENERATED_KEYS);
            ptmt.setString(1, professor.getNome());
            ptmt.setString(2, professor.getEmail());
            ptmt.setString(3, professor.getSenha());
            ptmt.setBoolean(4, professor.isEstaAtivo());
            int affectedRows = ptmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha ao criar professor, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = ptmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    professor.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Falha ao criar professor, nenhum ID retornado.");
                }
            }

            if (turmaIds != null && !turmaIds.isEmpty()) {
                String sqlInsertProfessorTurma = "INSERT INTO professor_turma (professor_id, turma_id) VALUES (?, ?)";
                ptmt = conn.prepareStatement(sqlInsertProfessorTurma);

                for (Integer idTurma : turmaIds) {
                    ptmt.setInt(1, professor.getId());
                    ptmt.setInt(2, idTurma);
                    ptmt.addBatch();
                }

                ptmt.executeBatch();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao criar professor completo: " + e.getMessage(), e);
        } finally {
            try {
                if (ptmt != null) ptmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            conexao.desconectar(conn);
        }
    }



}
