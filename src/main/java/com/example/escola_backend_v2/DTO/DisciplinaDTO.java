package com.example.escola_backend_v2.DTO;

public class DisciplinaDTO {
    private int id;
    private String nome;

    public DisciplinaDTO(int id, String nome) {
        this.id = id;
        this.nome = nome;
    }

    public DisciplinaDTO() {
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

    @Override
    public String toString() {
        return "DisciplinaDTO{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                '}';
    }
}
