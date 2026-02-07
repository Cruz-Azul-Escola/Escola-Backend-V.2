package com.example.escola_backend_v2.DTO;

import java.util.List;

public class SalaDTO {
    private int id;
    private String nome;
    private int capacidade;
    private List<AlunoDTO> anulos;

    public SalaDTO(int id, String nome, int capacidade, List<AlunoDTO> anulos) {
        this.id = id;
        this.nome = nome;
        this.capacidade = capacidade;
        this.anulos = anulos;
    }

    public SalaDTO() {
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

    public int getCapacidade() {
        return capacidade;
    }

    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }

    public List<AlunoDTO> getAnulos() {
        return anulos;
    }

    public void setAnulos(List<AlunoDTO> anulos) {
        this.anulos = anulos;
    }

    @Override
    public String toString() {
        return "SalaDTO{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", capacidade=" + capacidade +
                ", anulos=" + anulos +
                '}';
    }
}
