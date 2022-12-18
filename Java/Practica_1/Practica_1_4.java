/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package acceso_a_datos.practica_1;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author iesjdc
 */
public class Practica_1_4 {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost:3306/Acceso_A_Datos?serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(url,"root","");
            Statement st = conn.createStatement();
            
            String select="SELECT * FROM vendedores";
            String delete = "DELETE FROM vendedores WHERE nombre='Miguel A. Segovia'";
            
            st.executeUpdate(delete);
            ResultSet rs = st.executeQuery(select);
            
            while(rs.next()) {
                int id = rs.getInt("id");
                String nombre = rs.getString("nombre");
                Date fecha = rs.getDate("fecha_ingreso");
                float salario = rs.getFloat("salario");
                System.out.println(id + " " + nombre + " " + fecha + " " + salario);
            }
            
            st.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException | IllegalAccessException | InstantiationException e) {
            System.out.println("No se creó la conexión");
        }
    }
}