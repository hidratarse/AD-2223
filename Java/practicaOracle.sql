/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package practicaoracle;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author iesjdc
 */
public class PracticaOracle {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conexion = DriverManager.getConnection
                    ("jdbc:oracle:thin:@localhost:1521:XE","miguel","contra");
            System.out.println("conexion correcta");
            
            Statement st = conexion.createStatement();
            ResultSet rs = st.executeQuery("SELECT ENAME, DEPTNO FROM EMP WHERE DEPTNO = 30");
            
            while (rs.next()) {
                String nombre = rs.getString("ENAME");
                int dept = rs.getInt("DEPTNO");
                System.out.println(" "+nombre+" "+dept);
            }
            st.close();
            conexion.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PracticaOracle.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PracticaOracle.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}