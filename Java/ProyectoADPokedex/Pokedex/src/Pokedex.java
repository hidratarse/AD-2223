import java.sql.SQLException;
import java.util.Scanner;

//Clase principal 
public class Pokedex {
    // Objeto de tipo Pokemons para poder trabajar con la base de datos
    private static Pokemons BD;
    // Objeto de tipo scanner para poder recibir inputs del usuario
    private static Scanner sc;

    public static void main(String args[]) {
        // Variable que determinará la acción del usuario
        int opcion = 0;
        sc = new Scanner(System.in);
        try {
            BD = new Pokemons();
            // Opciones del menú
            String[] opciones = { "Pokedex",
                    "Buscar pokemon",
                    "Insertar pokemon",
                    "Borrar pokemon",
                    "Filtrar por tipos",
                    "Ordenar",
                    "Salir." };
            do {
                // Llamada al método menu que forma un menú con las opciones pasadas por
                // parámetro.
                // según la decición del usuario se realizará una acción sobre la base de datos
                switch (opcion = menu(opciones, opciones.length)) {
                    case 1:
                        BD.mostrarPokedex();
                        break;
                    case 2:
                        buscarPokemon();
                        break;
                    case 3:
                        insertarPokemon();
                        break;
                    case 4:
                        borrarPokemon();
                        break;
                    case 5:
                        filtrarPortipos();
                        break;
                    case 6:
                        ordenar();
                        break;
                }
            } while (opcion != 7);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        } catch (InstantiationException e) {
            System.out.print(e.getMessage());
        } catch (IllegalAccessException e) {
            System.out.print(e.getMessage());
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        } finally {
            try {
                BD.cerrarConexion();
            } catch (SQLException ignorada) {
            }
        }
    }

    // Método que pide por teclado el nombre del pokemon a buscar y hará la bsuqueda
    // con el objeto de tipo pokemon
    public static void buscarPokemon() throws SQLException {
        System.out.println("\nIntroduce el nombre del pokemon a buscar:");
        System.out.print("> ");
        String busqueda = sc.nextLine();

        BD.mostrarBusqueda(busqueda);
    }

    // Se pedirá por teclado los datos para hacer una inserción
    public static void insertarPokemon() throws SQLException {
        int entrada;
        String nombre, tipo1, tipo2, habilidad, region;
        float altura, peso;

        System.out.println("Entrada: ");
        entrada = sc.nextInt();
        sc.nextLine();
        System.out.println("Nombre: ");
        nombre = sc.nextLine();
        System.out.println("Tipo principal: ");
        tipo1 = sc.nextLine();
        System.out.println("Tipo secundario: ");
        tipo2 = sc.nextLine();
        System.out.println("Habilidad: ");
        habilidad = sc.nextLine();
        System.out.println("Region: ");
        region = sc.nextLine();
        System.out.println("Altura: ");
        altura = sc.nextFloat();
        System.out.println("Peso: ");
        peso = sc.nextFloat();
        BD.insertarPokemon(entrada, nombre, tipo1, tipo2, habilidad, region, altura, peso);
        sc.nextLine();
    }

    // Método que realizará una eliminación según la entrada de la pokedex
    // proporcionada
    public static void borrarPokemon() throws SQLException {
        int entrada;
        System.out.println("Entrada: ");
        entrada = sc.nextInt();
        sc.nextLine();
        BD.borrarPokemon(entrada);
    }

    // Se pide por teclado el tipo para filtrar y se hará la llamada al método del
    // mismo nombre
    public static void filtrarPortipos() throws SQLException {
        System.out.println("\nIntroduce el nombre del tipo: ");
        System.out.print("> ");
        System.out.println("Mostrando pokemons de tipo ");
        String tipo = sc.nextLine();
        BD.filtrarPortipos(tipo);
    }

    // El método invocará un submenú donde el usuario deberá indicar como quiere que
    // se ordenen los registros
    public static void ordenar() throws SQLException {
        String[] opciones = { "De último a primero",
                "Alfabeticamente ",
                "Por altura",
                "Por peso",
                "Salir." };
        int opcion = 0;
        do {
            // Las opciones están deficnidas en la clase Pokemons
            switch (opcion = menu(opciones, opciones.length)) {
                case 1:
                    BD.ultimoAprimero();
                    break;
                case 2:
                    BD.alfabeticamente();
                    break;
                case 3:
                    BD.altura();
                    break;
                case 4:
                    BD.peso();
                    break;
            }
        } while (opcion != 5);
    }

    // Método que construye un menú, el usuario meterá la opción deseada por
    // tecleado con el objeto escaner
    public static int menu(String[] opciones, int numOpciones) {
        int i = 0, opcion = 0;

        System.out.println("\n____________________________________\n");
        for (i = 1; i <= numOpciones; ++i) {
            System.out.print("    " + i + ". " + opciones[i - 1] + "\n");
        }
        System.out.println("____________________________________\n");
        do {
            System.out.print("\nOpci n (1 - " + numOpciones + "): ");
            opcion = sc.nextInt();
            sc.nextLine();
        } while (opcion < 1 || opcion > numOpciones);
        return opcion;
    }
}