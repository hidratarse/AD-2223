// Clase base de datos alumnos (BDAlumnos). M todos:
//    constructor BDAlumnos: carga el controlador JDBC y conectar.
//    conectar: realiza la conexi n con la base de datos.
//    tablas: devuelve el conjunto de tablas disponibles en la BD.
//    obtenerTabla: obtiene todas las filas de la tabla.
//    buscarFilasEnAlumnos: obtiene determinadas filas de la tabla alumnos.
//    insertarFilaEnAlumnos: inserta una fila en la tabla alumnos.
//    borrarFilaEnAlumnos: borra una fila de la tabla alumnos.
//    mostrarTabla: visualiza todas las filas de una tabla.
//    mostrarFilasDeAlumnos: visualiza determinadas filas de la tabla alumnos.
//    mostrarFilaActual: muestra la fila actual de un ResultSet.
//    siguiente: mover el cursor a la fila siguiente.
//    anterior: mover el cursor a la fila anterior.
//    primero: mover el cursor a la primera fila.
//     ltimo: mover el cursor a la  ltima fila.
//    cerrarConexion: cerrar la conexi n con la base de datos.

public class Alumnos {
    private java.sql.Connection conexion;
    private java.sql.Statement sentenciaSQL;
    private java.sql.ResultSet cdr; // conjunto de resultados

    public Alumnos() throws ClassNotFoundException, java.sql.SQLException,
            InstantiationException, IllegalAccessException {
        // Cargar el controlador JDBC
        String controlador = "com.mysql.cj.jdbc.Driver";
        Class.forName(controlador).newInstance();
        conectar(); // conectar con la fuente de datos
    }

    public void conectar() throws java.sql.SQLException {
        String URL_bd = "jdbc:mysql://localhost:3306/AD";
        String usuario = "root";
        String pw = "shiav1";
        // Conectar con la BD
        conexion = java.sql.DriverManager.getConnection(
                URL_bd, usuario, pw);
        // Crear una sentencia SQL
        sentenciaSQL = conexion.createStatement(
                java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
                java.sql.ResultSet.CONCUR_UPDATABLE);
        System.out.println("\nConexion realizada con exito.\n");
        // Mostrar las tablas de la base de datos
        System.out.println("Tablas de la base de datos: ");
        String[] tabla = tablas();
        for (int i = 0; i < tabla.length; ++i)
            System.out.println(tabla[i]);
    }

    public void cerrarConexion() throws java.sql.SQLException {
        if (cdr != null)
            cdr.close();
        if (sentenciaSQL != null)
            sentenciaSQL.close();
        if (conexion != null)
            conexion.close();
    }

    public String[] tablas() throws java.sql.SQLException {
        cdr = sentenciaSQL.executeQuery("SHOW TABLES");
        cdr.last(); // mover el cursor a la ultima fila
        String[] tablas = new String[cdr.getRow()];
        cdr.beforeFirst(); // mover el cursor a su posici n inicial
        int i = 0;
        while (cdr.next())
            tablas[i++] = cdr.getString(1);
        return tablas;
    }

    public java.sql.ResultSet obtenerTabla(String tabla)
            throws java.sql.SQLException {
        cdr = sentenciaSQL.executeQuery(
                "SELECT * FROM " + tabla);
        return cdr;
    }

    public java.sql.ResultSet buscarFilasEnAlumnos(String subcad,
            int tipoBusqueda) throws java.sql.SQLException {
        String[] cadena = { "'" + subcad + "%'", "'%" + subcad + "%'" };
        cdr = sentenciaSQL.executeQuery(
                "SELECT * FROM " + "alumnos" +
                        " WHERE nombre LIKE " + cadena[tipoBusqueda - 1]);
        return cdr;
    }

    public void insertarFilaEnAlumnos(int expediente, String nombre, String localidad, String fecha_nac,
            String direccion, int curso, String nivel, int faltas)
            throws java.sql.SQLException {
        sentenciaSQL.executeUpdate("INSERT INTO " + "alumnos" +
                " VALUES (" + expediente + ", '" + nombre + "', '" + localidad + "', '" + fecha_nac + "', '" + direccion
                + "', " + curso + ", '" + nivel + "', " + faltas + ")");
    }

    public void borrarFilaEnAlumnos(int ID)
            throws java.sql.SQLException {
        sentenciaSQL.executeUpdate("DELETE FROM " + "alumnos" +
                " WHERE expediente = " + ID);
    }

    public void mostrarTabla(String tabla)
            throws java.sql.SQLException {
        cdr = obtenerTabla(tabla);
        while (cdr.next())
            mostrarFilaActual();
    }

    public void mostrarFilasDeAlumnos(String subcad, int tipoBusqueda)
            throws java.sql.SQLException {
        cdr = buscarFilasEnAlumnos(subcad, tipoBusqueda);
        while (cdr.next())
            mostrarFilaActual();
    }

    public void mostrarFilaActual() throws java.sql.SQLException {
        int nColumnas = cdr.getMetaData().getColumnCount();
        for (int i = 1; i <= nColumnas; ++i) {
            System.out.print(cdr.getString(i) + " ");
        }
        System.out.println();
    }

    public void siguiente() throws java.sql.SQLException {
        if (!cdr.isLast())
            cdr.next();
    }

    public void anterior() throws java.sql.SQLException {
        if (cdr.isBeforeFirst())
            cdr.first();
        if (!cdr.isFirst())
            cdr.previous();
    }

    public void primero() throws java.sql.SQLException {
        cdr.first();
    }

    public void ultimo() throws java.sql.SQLException {
        cdr.last();
    }
}