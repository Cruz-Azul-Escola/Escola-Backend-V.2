package com.example.escola_backend_v2.DTO;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.*;

class EscolaModelsTest {

    @Test
    @DisplayName("Deve instanciar e validar os atributos de AlunoDTO corretamente")
    void deveValidarAlunoDTO() {
        AlunoDTO aluno = new AlunoDTO(
                1,
                "2026001",
                "aluno@cruzazul.edu.br",
                "senhaSegura123",
                "Rafael Takematsu",
                "123.456.789-00",
                10,
                Arrays.asList(1, 2),
                Collections.emptyList(),
                true
        );

        assertEquals(1, aluno.getId());
        assertEquals("2026001", aluno.getMatricula());
        assertEquals("aluno@cruzazul.edu.br", aluno.getEmail());
        assertEquals("Rafael Takematsu", aluno.getNome());
        assertEquals("123.456.789-00", aluno.getCpf());
        assertEquals(10, aluno.getIdSala());
        assertEquals(2, aluno.getIdsDisciplinas().size());
        assertTrue(aluno.isEstaAtivo());
        assertTrue(aluno.toString().contains("Rafael Takematsu"));
    }

    @Test
    @DisplayName("Deve instanciar e validar DisciplinaDTO e SalaDTO")
    void deveValidarDisciplinaESalaDTO() {
        DisciplinaDTO disciplina = new DisciplinaDTO(5, "Desenvolvimento de Sistemas", 80);
        SalaDTO sala = new SalaDTO(3, "2º Ano DS", 35, Collections.emptyList());

        assertEquals(5, disciplina.getId());
        assertEquals("Desenvolvimento de Sistemas", disciplina.getNome());
        assertEquals(80, disciplina.getCargaHoraria());

        assertEquals(3, sala.getId());
        assertEquals("2º Ano DS", sala.getNome());
        assertEquals(35, sala.getCapacidade());
        assertNotNull(sala.getAnulos());
    }

    @Test
    @DisplayName("Deve associar TurmaDTO com DisciplinaDTO, SalaDTO e ProfessorDTO")
    void deveValidarTurmaEProfessorDTO() {
        DisciplinaDTO disciplina = new DisciplinaDTO(1, "DevOps & CI/CD", 60);
        SalaDTO sala = new SalaDTO(2, "Lab 01", 30, Collections.emptyList());
        ProfessorDTO professor = new ProfessorDTO(
                10,
                "Prof. DevOps",
                "prof@cruzazul.edu.br",
                "hash123",
                true,
                Collections.emptyList()
        );

        TurmaDTO turma = new TurmaDTO(
                100,
                "2026/2",
                disciplina,
                sala,
                Collections.emptyList(),
                Collections.singletonList(professor)
        );

        assertEquals(100, turma.getId());
        assertEquals("2026/2", turma.getPeriodoLetivo());
        assertEquals("DevOps & CI/CD", turma.getDisciplina().getNome());
        assertEquals("Lab 01", turma.getSala().getNome());
        assertEquals(1, turma.getProfessores().size());
        assertEquals("Prof. DevOps", turma.getProfessores().get(0).getNome());
    }
}
