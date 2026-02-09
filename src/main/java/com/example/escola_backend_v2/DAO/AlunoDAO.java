package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.DTO.*;
import com.example.escola_backend_v2.Util.Conexao;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class AlunoDAO {
    Conexao conexao= new Conexao();
    public int buscarPorEmail(String email) {
        Connection conn = conexao.conectar();
        String sql = "SELECT  id_aluno FROM ALUNO WHERE email = ?";
        try {

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return 1;
            }else {
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }
    }
    public int editarSenha(int id, String senha){
        String sql = "UPDATE ALUNO SET SENHA=? WHERE  id_aluno=?";
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, senha);
            pstm.setInt(2, id);
            return pstm.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }
    }

    public AlunoDTO preCadastro(AlunoDTO alunoDTO) {
        Connection conn = conexao.conectar();

        String sqlInsertAluno =
                "INSERT INTO aluno (nome, cpf_signup, matricula, esta_ativo) " +
                        "VALUES (?, ?, ?, TRUE)";

        String sqlBuscarTurmasSala =
                "SELECT id_turma FROM turma WHERE id_sala = ?";

        String sqlInsertTurmaAluno =
                "INSERT INTO turma_aluno (id_aluno, id_turma, nota1, nota2, observacoes) " +
                        "VALUES (?, ?, NULL, NULL, '')";

        try {
            //gerando uma matricula
            String matricula = UUID.randomUUID().toString().substring(0, 8).toUpperCase();

            //primeiro crio o aluno em si
            PreparedStatement psAluno = conn.prepareStatement(sqlInsertAluno, Statement.RETURN_GENERATED_KEYS);
            psAluno.setString(1, alunoDTO.getNome());
            psAluno.setString(2, alunoDTO.getCpf());
            psAluno.setString(3, matricula);

            psAluno.executeUpdate();

            ResultSet rs = psAluno.getGeneratedKeys();
            if (!rs.next()) {
                throw new RuntimeException("Falha ao gerar ID do aluno.");
            }
            int idAluno = rs.getInt(1);
            alunoDTO.setId(idAluno);
            alunoDTO.setMatricula(matricula);
            PreparedStatement psTurmas = conn.prepareStatement(sqlBuscarTurmasSala);
            psTurmas.setInt(1, alunoDTO.getIdSala());
            ResultSet rsTurmas = psTurmas.executeQuery();
            PreparedStatement psInsertTurmaAluno = conn.prepareStatement(sqlInsertTurmaAluno);

            while (rsTurmas.next()) {
                int idTurma = rsTurmas.getInt("id_turma");

                psInsertTurmaAluno.setInt(1, idAluno);
                psInsertTurmaAluno.setInt(2, idTurma);
                psInsertTurmaAluno.executeUpdate();
            }

            return alunoDTO;

        } catch (SQLException e) {
            throw new RuntimeException("Erro no pré-cadastro do aluno: " + e.getMessage(), e);
        } finally {
            conexao.desconectar(conn);
        }
    }

    public int Cadastro(String email, String senha, int idAluno) {
        Connection conn = conexao.conectar();

        String sql = "UPDATE aluno " +
                "SET email = ?, senha = ? " +
                "WHERE id_aluno = ?";

        try {
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, email);
            ptmt.setString(2, senha);
            ptmt.setInt(3, idAluno);

            if (ptmt.executeUpdate() > 0) {
                return 1;
            }
            return 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao finalizar cadastro: " + e.getMessage(), e);
        } finally {
            conexao.desconectar(conn);
        }
    }

    public int buscarPorCpf(String cpf){
        Connection conn = conexao.conectar();
        String sql = "SELECT id_aluno FROM ALUNO WHERE cpf_signup=? AND EMAIL IS NULL AND SENHA IS NULL";
        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cpf);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                return rs.getInt("id_aluno");
            }
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }
    }

    public AlunoDTO buscarAlunoPorId(int idAluno) {
        Connection conn = conexao.conectar();

        String sql =
                "SELECT " +
                        "    a.id_aluno, " +
                        "    a.nome, " +
                        "    a.matricula, " +
                        "    a.email, " +
                        "    a.senha, " +
                        "    a.cpf_signup, " +
                        "    t.id_turma, " +
                        "    t.periodo_letivo, " +
                        "    d.id_disciplina, " +
                        "    d.nome_disciplina, " +
                        "    s.id_sala, " +
                        "    s.nome_sala, " +
                        "    ta.nota1, " +
                        "    ta.nota2, " +
                        "    ta.observacoes " +
                        "FROM aluno a " +
                        "LEFT JOIN turma_aluno ta ON ta.id_aluno = a.id_aluno " +
                        "LEFT JOIN turma t ON t.id_turma = ta.id_turma " +
                        "LEFT JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                        "LEFT JOIN sala s ON s.id_sala = t.id_sala " +
                        "WHERE a.id_aluno = ? " +
                        "ORDER BY d.nome_disciplina";

        try {
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, idAluno);
            ResultSet rs = ptmt.executeQuery();

            AlunoDTO aluno = null;
            List<TurmaAlunoDTO> matriculas = new ArrayList<>();

            while (rs.next()) {
                if (aluno == null) {
                    aluno = new AlunoDTO();
                    aluno.setId(rs.getInt("id_aluno"));
                    aluno.setNome(rs.getString("nome"));
                    aluno.setMatricula(rs.getString("matricula"));
                    aluno.setEmail(rs.getString("email"));
                   // aluno.setSenha(rs.getString("senha"));
                    aluno.setCpf(rs.getString("cpf_signup"));
                    aluno.setMatriculas(matriculas); // lista de TurmaAlunoDTO
                }

                int idTurma = rs.getInt("id_turma");
                if (!rs.wasNull()) {
                    // disciplina
                    DisciplinaDTO d = new DisciplinaDTO();
                    d.setId(rs.getInt("id_disciplina"));
                    d.setNome(rs.getString("nome_disciplina"));

                    // sala
                    SalaDTO s = new SalaDTO();
                    s.setId(rs.getInt("id_sala"));
                    s.setNome(rs.getString("nome_sala"));

                    // turma
                    TurmaDTO t = new TurmaDTO();
                    t.setId(rs.getInt("id_turma"));
                    t.setPeriodoLetivo(rs.getString("periodo_letivo"));
                    t.setDisciplina(d);
                    t.setSala(s);

                    // notas
                    BigDecimal bdNota1 = rs.getBigDecimal("nota1");
                    BigDecimal bdNota2 = rs.getBigDecimal("nota2");

                    Double nota1 = (bdNota1 != null) ? bdNota1.doubleValue() : null;
                    Double nota2 = (bdNota2 != null) ? bdNota2.doubleValue() : null;

                    double media;
                    if (nota1 != null && nota2 != null) {
                        media = (nota1 + nota2) / 2.0;
                    } else {
                        media = -1; // ainda não disponível
                    }

                    TurmaAlunoDTO ta = new TurmaAlunoDTO();
                    ta.setAluno(aluno);
                    ta.setTurma(t);
                    ta.setNota1(nota1);
                    ta.setNota2(nota2);
                    ta.setMedia(media);
                    ta.setObservacoes(rs.getString("observacoes"));

                    matriculas.add(ta);
                }
            }

            return aluno;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar aluno: " + e.getMessage(), e);
        } finally {
            conexao.desconectar(conn);
        }
    }
    public boolean alterarAlunoCompleto(AlunoDTO aluno) {
        Connection conn = conexao.conectar();

        String sqlUpdateAluno =
                "UPDATE aluno SET nome = ?, email = ?, cpf_signup = ?, matricula = ?, esta_ativo = ? " +
                        "WHERE id_aluno = ?";

        String sqlDeleteVinculos =
                "DELETE FROM turma_aluno WHERE id_aluno = ?";

        String sqlInsertVinculo =
                "INSERT INTO turma_aluno (id_aluno, id_turma, nota1, nota2, observacoes) " +
                        "VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement psAluno = conn.prepareStatement(sqlUpdateAluno);
            psAluno.setString(1, aluno.getNome());
            psAluno.setString(2, aluno.getEmail());
            psAluno.setString(3, aluno.getCpf());
            psAluno.setString(4, aluno.getMatricula());
            psAluno.setBoolean(5, aluno.isEstaAtivo());
            psAluno.setInt(6, aluno.getId());

            psAluno.executeUpdate();
            PreparedStatement psDel = conn.prepareStatement(sqlDeleteVinculos);
            psDel.setInt(1, aluno.getId());
            psDel.executeUpdate();

            if (aluno.getMatriculas() != null && !aluno.getMatriculas().isEmpty()) {
                PreparedStatement psIns = conn.prepareStatement(sqlInsertVinculo);

                for (TurmaAlunoDTO ta : aluno.getMatriculas()) {
                    psIns.setInt(1, aluno.getId());
                    psIns.setInt(2, ta.getTurma().getId());

                    if (ta.getNota1() != null) {
                        psIns.setDouble(3, ta.getNota1());
                    } else {
                        psIns.setNull(3, java.sql.Types.NUMERIC);
                    }

                    if (ta.getNota2() != null) {
                        psIns.setDouble(4, ta.getNota2());
                    } else {
                        psIns.setNull(4, java.sql.Types.NUMERIC);
                    }

                    psIns.setString(5, ta.getObservacoes());

                    psIns.addBatch();
                }

                psIns.executeBatch();
            }

            return true;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar aluno completo: " + e.getMessage(), e);
        } finally {
            conexao.desconectar(conn);
        }
    }

    public int excluir(int id){
        Connection conn = conexao.conectar();
        String sql="UPDATE ALUNO SET esta_ativo=FALSE WHERE id_aluno = ?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            if (pstm.executeUpdate()>0){
                return 1;
            }
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            conexao.desconectar(conn);
        }
    }

    public boolean notasFaltando(int id){
        String sql = "SELECT COUNT(*) AS faltando FROM turma_aluno WHERE id_aluno =? AND (nota1 IS NULL OR nota2 IS NULL)";
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt= conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                int faltando = rs.getInt(1);
                return faltando==0;
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }
    }

    public List<TurmaAlunoDTO> buscarBoletim(int id) {
        int idAluno=0;
        List<TurmaAlunoDTO> lista = new ArrayList<>();
        Connection conn = conexao.conectar();
        String sql="SELECT " +
                " a.id_aluno, a.nome AS nome_aluno, " +
                " ta.nota1, ta.nota2, ta.observacoes, " +
                " s.id_sala, s.nome_sala, " +
                " d.id_disciplina, d.nome_disciplina, " +
                " t.id_turma, t.periodo_letivo " +
                "FROM aluno a " +
                "JOIN turma_aluno ta ON a.id_aluno = ta.id_aluno " +
                "JOIN turma t ON t.id_turma = ta.id_turma " +
                "JOIN sala s ON s.id_sala = t.id_sala " +
                "JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                "WHERE a.id_aluno = ? " +
                "ORDER BY d.nome_disciplina";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                AlunoDTO alunoDTO = new AlunoDTO();
                DisciplinaDTO disciplinaDTO = new DisciplinaDTO();
                SalaDTO salaDTO = new SalaDTO();
                TurmaDTO turmaDTO = new TurmaDTO();
                TurmaAlunoDTO taDTO = new TurmaAlunoDTO();


                alunoDTO.setId(rs.getInt("id_aluno"));
                alunoDTO.setNome(rs.getString("nome_aluno"));
                disciplinaDTO.setId(rs.getInt("id_disciplina"));
                disciplinaDTO.setNome(rs.getString("nome_disciplina"));
                salaDTO.setId(rs.getInt("id_sala"));
                salaDTO.setNome(rs.getString("nome_sala"));
                turmaDTO.setId(rs.getInt("id_turma"));
                turmaDTO.setPeriodoLetivo(rs.getString("periodo_letivo"));
                turmaDTO.setDisciplina(disciplinaDTO);
                turmaDTO.setSala(salaDTO);
                taDTO.setAluno(alunoDTO);
                taDTO.setTurma(turmaDTO);
                Double nota1 = rs.getObject("nota1") != null ? rs.getDouble("nota1") : null;
                Double nota2 = rs.getObject("nota2") != null ? rs.getDouble("nota2") : null;
                taDTO.setNota1(nota1);
                taDTO.setNota2(nota2);
                taDTO.setObservacoes(rs.getString("observacoes"));
                if (nota1 != null && nota2 != null) {
                    taDTO.setMedia((nota1 + nota2) / 2.0);
                } else {
                    taDTO.setMedia(-1.0);
                }
                lista.add(taDTO);
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            conexao.desconectar(conn);
        }

    }





}
