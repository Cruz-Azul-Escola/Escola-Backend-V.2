package com.example.escola_backend_v2.DAO;

import com.example.escola_backend_v2.DTO.*;
import com.example.escola_backend_v2.Util.Conexao;
import jakarta.mail.*;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class LogarCadastrarDAO {
    Conexao conexao = new Conexao();
    public Object logar(String email, String senha) {
        Connection conn = conexao.conectar();

        String sqlCheckAluno = "SELECT id_aluno FROM aluno WHERE email = ? AND senha = ? AND esta_ativo = TRUE";
        String sqlCheckProfessor = "SELECT id_professor FROM professor WHERE email = ? AND senha = ? AND esta_ativo = TRUE";

        String sqlAlunoCompleto =
                "SELECT " +
                        " a.id_aluno, a.nome AS aluno_nome, a.matricula, a.email, a.cpf_signup, " +
                        " t.id_turma, t.periodo_letivo, " +
                        " d.id_disciplina, d.nome_disciplina, d.carga_horaria, " +
                        " s.id_sala, s.nome_sala, " +
                        " ta.nota1, ta.nota2, ta.observacoes " +
                        "FROM aluno a " +
                        "JOIN turma_aluno ta ON ta.id_aluno = a.id_aluno " +
                        "JOIN turma t ON t.id_turma = ta.id_turma " +
                        "JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                        "JOIN sala s ON s.id_sala = t.id_sala " +
                        "WHERE a.id_aluno = ? " +
                        "ORDER BY d.nome_disciplina";

        String sqlProfessorCompleto =
                "SELECT " +
                        " p.id_professor, p.nome AS professor_nome, p.email, " +
                        " t.id_turma, t.periodo_letivo, " +
                        " d.id_disciplina, d.nome_disciplina, d.carga_horaria, " +
                        " s.id_sala, s.nome_sala " +
                        "FROM professor p " +
                        "JOIN professor_turma pt ON pt.professor_id = p.id_professor " +
                        "JOIN turma t ON t.id_turma = pt.turma_id " +
                        "JOIN disciplina d ON d.id_disciplina = t.id_disciplina " +
                        "JOIN sala s ON s.id_sala = t.id_sala " +
                        "WHERE p.id_professor = ? " +
                        "ORDER BY d.nome_disciplina";

        try {
            //primeiro eu vejo se é aluno
            PreparedStatement pstm = conn.prepareStatement(sqlCheckAluno);
            pstm.setString(1, email);
            pstm.setString(2, senha);
            ResultSet rs = pstm.executeQuery();

            if (rs.next()) {
                int idAluno = rs.getInt("id_aluno");

                PreparedStatement ptmt = conn.prepareStatement(sqlAlunoCompleto);
                ptmt.setInt(1, idAluno);
                ResultSet rsAluno = ptmt.executeQuery();

                AlunoDTO aluno = null;
                List<TurmaAlunoDTO> matriculas = new ArrayList<>();

                while (rsAluno.next()) {
                    //isso aqui garante que quando ele colocar os dados só do alno ele não muda mais, ai só vai adicionar notas, disciplinas ao mesmo
                    if (aluno == null) {
                        aluno = new AlunoDTO();
                        aluno.setId(rsAluno.getInt("id_aluno"));
                        aluno.setNome(rsAluno.getString("aluno_nome"));
                        aluno.setMatricula(rsAluno.getString("matricula"));
                        aluno.setEmail(rsAluno.getString("email"));
                        aluno.setCpf(rsAluno.getString("cpf_signup"));
                        aluno.setMatriculas(matriculas);
                    }

                    DisciplinaDTO disc = new DisciplinaDTO();
                    disc.setId(rsAluno.getInt("id_disciplina"));
                    disc.setNome(rsAluno.getString("nome_disciplina"));

                    SalaDTO sala = new SalaDTO();
                    sala.setId(rsAluno.getInt("id_sala"));
                    sala.setNome(rsAluno.getString("nome_sala"));

                    TurmaDTO turma = new TurmaDTO();
                    turma.setId(rsAluno.getInt("id_turma"));
                    turma.setPeriodoLetivo(rsAluno.getString("periodo_letivo"));
                    turma.setDisciplina(disc);
                    turma.setSala(sala);

                    TurmaAlunoDTO at = new TurmaAlunoDTO();
                    at.setTurma(turma);
                    at.setNota1(rsAluno.getDouble("nota1"));
                    at.setNota2(rsAluno.getDouble("nota2"));
                    at.setObservacoes(rsAluno.getString("observacoes"));

                    matriculas.add(at);
                }

                if (aluno != null) {
                    //no final retorno o DTO completo
                    System.out.println("Aluno logado: " + aluno.getNome());
                    return aluno;
                }
            }

            PreparedStatement pstm2 = conn.prepareStatement(sqlCheckProfessor);
            pstm2.setString(1, email);
            pstm2.setString(2, senha);
            ResultSet rs2 = pstm2.executeQuery();


            //depois tento com o professor
            if (rs2.next()) {
                int idProf = rs2.getInt("id_professor");

                PreparedStatement ptmt2 = conn.prepareStatement(sqlProfessorCompleto);
                ptmt2.setInt(1, idProf);
                ResultSet rsProf = ptmt2.executeQuery();

                ProfessorDTO prof = null;
                List<TurmaDTO> turmas = new ArrayList<>();

                while (rsProf.next()) {
                    //mesma coisa que com aluno
                    if (prof == null) {
                        prof = new ProfessorDTO();
                        prof.setId(rsProf.getInt("id_professor"));
                        prof.setNome(rsProf.getString("professor_nome"));
                        prof.setEmail(rsProf.getString("email"));
                        prof.setTurmas(turmas);
                    }

                    DisciplinaDTO disc = new DisciplinaDTO();
                    disc.setId(rsProf.getInt("id_disciplina"));
                    disc.setNome(rsProf.getString("nome_disciplina"));

                    SalaDTO sala = new SalaDTO();
                    sala.setId(rsProf.getInt("id_sala"));
                    sala.setNome(rsProf.getString("nome_sala"));

                    TurmaDTO turma = new TurmaDTO();
                    turma.setId(rsProf.getInt("id_turma"));
                    turma.setPeriodoLetivo(rsProf.getString("periodo_letivo"));
                    turma.setDisciplina(disc);
                    turma.setSala(sala);

                    turmas.add(turma);
                }

                if (prof != null) {
                    System.out.println("Professor logado: " + prof.getEmail());
                    return prof;
                }
            }

            return null;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao logar: " + e.getMessage(), e);
        } finally {
            conexao.desconectar(conn);
        }
    }
    public int logarAdm(String email, String senha) {
        Connection conn = conexao.conectar();
        String sql = "SELECT admin_id FROM ADMIN WHERE EMAIL=? AND SENHA=?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, email);
            pstm.setString(2, senha);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt("admin_id");
            }
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }
    }

    public int enviarEmail(String destino, String hash){
        try {
            Properties prop = new Properties();
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            Session session = Session.getInstance(prop, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("iagonsiodiniz@gmail.com", "mfkl jtvq tcaf yxtx");
                }
            });
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("iago.diniz@germinare.org"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destino));
            message.setSubject("RECUPERAÇÃO SENHA");
            message.setText("CODIGO: "+ hash);

            Transport.send(message);
            return 1;
        } catch (AddressException e) {
            throw new RuntimeException(e);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }


    }

    public int chekarParaEnvio(String email){
        AlunoDAO alunoDAO = new AlunoDAO();
        Connection conn = conexao.conectar();
        int resultado =alunoDAO.buscarPorEmail(email);
        String hash = String.valueOf((int) (Math.random() * 900000) + 100000);
        try {
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ALUNO SET troca_senha_hash=? WHERE EMAIL=?");
            pstmt.setString(1, hash);
            pstmt.setString(2, email);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            conexao.desconectar(conn);
        }

        int resultado2=enviarEmail(email, hash);

        if (resultado >0 && resultado2>0){
            return 1;
        }
        return 0;
    }

    public int verificar(String email, String hash){
        Connection conn = conexao.conectar();
        System.out.println(email+hash);
        String sql="SELECT id_aluno from aluno WHERE EMAIL=? AND troca_senha_hash=?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, email);
            pstm.setString(2, hash);
            ResultSet rs = pstm.executeQuery();
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


}

