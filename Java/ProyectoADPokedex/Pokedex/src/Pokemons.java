import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Pokemons {
    // Declaración de objetos que usaremos para manejar la base de datos
    private Connection conexion;
    private Statement st;
    private ResultSet rs;

    // Constructor del objeto Pokemons
    public Pokemons() throws ClassNotFoundException,
            SQLException, InstantiationException, IllegalAccessException {
        // Driver de mysql
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        conectar();
    }

    // Método que conecta a la base de datos
    public void conectar() throws SQLException {
        // Establezco ruta, usuario y contraseña
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/Pokedex", "root", "shiav1");
        // Mantengo esto del código de ejemplo ya que permite hacer que el cursor sea
        // bidireccional y que el objeto se actualizable
        st = conexion.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        System.out.println("\nConexion realizada con exito.\n "
                + "\nAccediendo a la Pokedex");
    }

    // Método que cierra los objetos de tipo sql cuando se termina de usar la app
    public void cerrarConexion() throws SQLException {
        if (rs != null)
            rs.close();
        if (st != null)
            st.close();
        if (conexion != null)
            conexion.close();
    }

    // A partir de aquí se definen métodos que usan la BBDD con querys

    // Método que muestra todos los datos de la base de datos
    public void mostrarPokedex() throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON");
        while (rs.next())
            mostrarFilaActual();
    }

    // Método que muestra los datos de la posición del cursor rs
    public void mostrarFilaActual() throws SQLException {
        int nColumnas = rs.getMetaData().getColumnCount();
        for (int i = 1; i <= nColumnas; ++i) {
            System.out.print(rs.getString(i) + " ");
        }
        System.out.println();
    }

    // Método que buscará según el nombre recibido
    public void mostrarBusqueda(String busqueda) throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON WHERE NOMBRE LIKE '" + busqueda.toUpperCase() + "'");
        if (!rs.next()) {
            System.out.println("No se encuentra el pokemon con ese nombre");
        } else {
            mostrarFilaActual();
        }
    }
    //Método de de inserción
    public void insertarPokemon(int entrada, String nombre, String tipo1, String tipo2, String habilidad, String region,
            float altura, float peso) throws SQLException {
        st.executeUpdate(
                "INSERT INTO POKEMON VALUES (" + entrada + ", '" + nombre.toUpperCase() + "', '" + tipo1.toUpperCase() + "', '" + tipo2.toUpperCase() +
                        "', '" + habilidad.toUpperCase() + "', '" + region.toUpperCase() + "', " + altura + ", " + peso + ")");
    }
    //Método de eliminación
    public void borrarPokemon(int entrada) throws SQLException {
        st.executeUpdate("DELETE FROM " + "POKEMON" +
                " WHERE ENTRADA = " + entrada);
    }
    //Este método mostrará por pantalla los registros que cumplan el tipo especificado en el parámetro
    public void filtrarPortipos(String tipo) throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON WHERE TIPO_PRINCIPAL LIKE '"+tipo.toUpperCase()+
        "' OR TIPO_SECUNDARIO LIKE '"+tipo.toUpperCase()+"' ;");
        if (!rs.next()) {
            System.out.println("No hay almacenados pokemon con ese tipo");
        } else {
            mostrarFilaActual();
            while(rs.next()){
                mostrarFilaActual();
            };
        }
    }
    //Método que ordena pro orden de entrada de mayor a menor
    public void ultimoAprimero() throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON ORDER BY ENTRADA DESC");
        while (rs.next())
            mostrarFilaActual();
    }
    //Ordenación alfabetica
    public void alfabeticamente() throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON ORDER BY NOMBRE");
        while (rs.next())
            mostrarFilaActual();
    }
    //Ordenación de más pequeño al más alto
    public void altura() throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON ORDER BY ALTURA");
        while (rs.next())
            mostrarFilaActual();
    }
    //Ordenación del más ligero al más pesado
    public void peso() throws SQLException {
        rs = st.executeQuery("SELECT * FROM POKEMON ORDER BY PESO");
        while (rs.next())
            mostrarFilaActual();
    }
}