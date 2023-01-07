public class PruebaConexion {
    private static Alumnos BD;

    public PruebaConexion() throws ClassNotFoundException,
            java.sql.SQLException, InstantiationException,
            IllegalAccessException {
        // Realizar la conexi n con la base de datos BD
        BD = new Alumnos();
    }

    public void buscarFilasEnAlumnos()
            throws java.sql.SQLException {
        System.out.println("\nBuscar:");
        String[] busquedas = { "cadenas que empiecen por...",
                "cadenas que contengan..." };
        int i = menu(busquedas, busquedas.length);

        System.out.print("> ");
        String subcadena = Leer.dato();

        BD.mostrarFilasDeAlumnos(subcadena, i);
    }

    public void insertarFilaEnAlumnos()
            throws java.sql.SQLException {
        int expediente, curso, faltas;
        String nombre, localidad, fecha_nac, direccion, nivel;

        System.out.print("\nExpediente: ");
        expediente = Leer.datoInt();
        System.out.print("Nombre: ");
        nombre = Leer.dato();
        System.out.print("Localidad: ");
        localidad = Leer.dato();
        System.out.print("Fecha nacimiento: ");
        fecha_nac = Leer.dato();
        System.out.print("Direccion: ");
        direccion = Leer.dato();
        System.out.print("Curso: ");
        curso = Leer.datoInt();
        System.out.print("Nivel: ");
        nivel = Leer.dato();
        System.out.print("Faltas: ");
        faltas = Leer.datoInt();

        BD.insertarFilaEnAlumnos(expediente, nombre, localidad, fecha_nac, direccion, curso, nivel, faltas);
    }

    public void borrarFilaEnAlumnos()
            throws java.sql.SQLException {
        int ID;

        System.out.print("\nIdentificador: ");
        ID = Leer.datoInt();
        BD.borrarFilaEnAlumnos(ID);
    }

    public void navegar() throws java.sql.SQLException {
        // Opciones del men
        String[] opciones = { "Siguiente",
                "Anterior",
                "Primero",
                " ltimo",
                "Salir." };
        int opcion = 0;
        do {
            switch (opcion = menu(opciones, opciones.length)) {
                case 1:
                    BD.siguiente();
                    break;
                case 2:
                    BD.anterior();
                    break;
                case 3:
                    BD.primero();
                    break;
                case 4:
                    BD.ultimo();
                    break;
            }
            if (opcion != 5)
                BD.mostrarFilaActual();
        } while (opcion != 5);
    }

    public static int menu(String[] opciones, int numOpciones) {
        int i = 0, opcion = 0;

        System.out.println("\n____________________________________\n");
        for (i = 1; i <= numOpciones; ++i) {
            System.out.print("    " + i + ". " + opciones[i - 1] + "\n");
        }
        System.out.println("____________________________________\n");
        do {
            System.out.print("\nOpci n (1 - " + numOpciones + "): ");
            opcion = Leer.datoInt();
        } while (opcion < 1 || opcion > numOpciones);
        return opcion;
    }

    public static void main(String args[]) {
        int i = 0, opcion = 0;
        PruebaConexion objAp = null;

        try {
            objAp = new PruebaConexion();

            // Opciones del menu
            String[] opciones = { "Datos de la tabla",
                    "Buscar filas en \"alumnos\"",
                    "Insertar fila en \"alumnos\"",
                    "Borrar fila en \"alumnos\"",
                    "Navegar",
                    "Salir." };
            // Nombre de las tablas de la base
            String[] tablas = BD.tablas();

            do {
                switch (opcion = PruebaConexion.menu(opciones, opciones.length)) {
                    case 1:
                        i = PruebaConexion.menu(tablas, tablas.length);
                        BD.mostrarTabla(tablas[i - 1]);
                        break;
                    case 2:
                        objAp.buscarFilasEnAlumnos();
                        break;
                    case 3:
                        objAp.insertarFilaEnAlumnos();
                        break;
                    case 4:
                        objAp.borrarFilaEnAlumnos();
                        break;
                    case 5:
                        i = PruebaConexion.menu(tablas, tablas.length);
                        BD.obtenerTabla(tablas[i - 1]);
                        objAp.navegar();
                        break;
                }
            } while (opcion != 6);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        } catch (InstantiationException e) {
            System.out.print(e.getMessage());
        } catch (IllegalAccessException e) {
            System.out.print(e.getMessage());
        } catch (java.sql.SQLException e) {
            System.out.print(e.getMessage());
        } finally { // pase lo que pase cerramos la conexión
            try {
                BD.cerrarConexion();
            } catch (java.sql.SQLException ignorada) {
            }
        }
    }
}