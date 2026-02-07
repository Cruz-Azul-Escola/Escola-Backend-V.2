package com.example.escola_backend_v2.Util;

import java.sql.*;
import java.util.Objects;
import io.github.cdimascio.dotenv.Dotenv;
public class Conexao {

    Dotenv dotenv = Dotenv.configure()
            .directory("/")
            .ignoreIfMissing()
            .load();

    public Connection conectar() {
        Connection conn;
        try {

            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(
                    Objects.requireNonNull(dotenv.get("DB_URL")),
                    dotenv.get("DB_USER"),
                    dotenv.get("DB_PASSWORD")
            );

            System.out.println("conectou!");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
        return conn;
    }


    public void desconectar(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {

                System.out.println("desconectou!");
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
