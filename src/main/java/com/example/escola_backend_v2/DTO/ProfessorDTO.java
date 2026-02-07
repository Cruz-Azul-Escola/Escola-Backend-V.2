package com.example.escola_backend_v2.DTO;

import java.util.List;

public class ProfessorDTO {
    private int id;
    private String nome;
    private String email;
    private String senha;
    private boolean estaAtivo;
    private List<TurmaDTO> turmas;

    public ProfessorDTO() {
    }

    public ProfessorDTO(int id, String nome, String email, String senha, boolean estaAtivo, List<TurmaDTO> turmas) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.estaAtivo = estaAtivo;
        this.turmas = turmas;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
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

    public boolean isEstaAtivo() {
        return estaAtivo;
    }

    public void setEstaAtivo(boolean estaAtivo) {
        this.estaAtivo = estaAtivo;
    }

    public List<TurmaDTO> getTurmas() {
        return turmas;
    }

    public void setTurmas(List<TurmaDTO> turmas) {
        this.turmas = turmas;
    }

    @Override
    public String toString() {
        return "ProfessorDTO{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", email='" + email + '\'' +
                ", senha='" + senha + '\'' +
                ", estaAtivo=" + estaAtivo +
                ", turmas=" + turmas +
                '}';
    }
}
