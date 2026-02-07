package com.example.escola_backend_v2.DTO;

import java.util.List;

public class AlunoDTO {
    private int id;
    private String matricula;
    private String email;
    private String senha;
    private String nome;
    private String cpfSingnup;
    private int idSala;                 // sala escolhida
    private List<Integer> idsDisciplinas;
    private List<TurmaAlunoDTO> matriculas;
    private boolean estaAtivo;

    public AlunoDTO() {
    }


    public AlunoDTO(int id, String matricula, String email, String senha, String nome, String cpfSingnup, int idSala, List<Integer> idsDisciplinas, List<TurmaAlunoDTO> matriculas, boolean estaAtivo) {
        this.id = id;
        this.matricula = matricula;
        this.email = email;
        this.senha = senha;
        this.nome = nome;
        this.cpfSingnup = cpfSingnup;
        this.idSala = idSala;
        this.idsDisciplinas = idsDisciplinas;
        this.matriculas = matriculas;
        this.estaAtivo = estaAtivo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCpf() {
        return cpfSingnup;
    }

    public void setCpf(String cpf) {
        this.cpfSingnup = cpf;
    }

    public List<TurmaAlunoDTO> getDisciplinas() {
        return matriculas;
    }

    public void setDisciplinas(List<TurmaAlunoDTO> disciplinas) {
        this.matriculas = disciplinas;
    }

    public boolean isEsttaAtivo() {
        return estaAtivo;
    }

    public void setEstaAtivo(boolean esta_ativo) {
        this.estaAtivo = esta_ativo;
    }

    public String getCpfSingnup() {
        return cpfSingnup;
    }

    public void setCpfSingnup(String cpfSingnup) {
        this.cpfSingnup = cpfSingnup;
    }

    public List<TurmaAlunoDTO> getMatriculas() {
        return matriculas;
    }

    public void setMatriculas(List<TurmaAlunoDTO> matriculas) {
        this.matriculas = matriculas;
    }

    public boolean isEstaAtivo() {
        return estaAtivo;
    }

    public int getIdSala() {
        return idSala;
    }

    public void setIdSala(int idSala) {
        this.idSala = idSala;
    }

    public List<Integer> getIdsDisciplinas() {
        return idsDisciplinas;
    }

    public void setIdsDisciplinas(List<Integer> idsDisciplinas) {
        this.idsDisciplinas = idsDisciplinas;
    }

    @Override
    public String toString() {
        return "AlunoDTO{" +
                "id=" + id +
                ", matricula='" + matricula + '\'' +
                ", email='" + email + '\'' +
                ", senha='" + senha + '\'' +
                ", nome='" + nome + '\'' +
                ", cpfSingnup='" + cpfSingnup + '\'' +
                ", idSala=" + idSala +
                ", idsDisciplinas=" + idsDisciplinas +
                ", matriculas=" + matriculas +
                ", estaAtivo=" + estaAtivo +
                '}';
    }
}
