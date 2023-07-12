package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {
	
	private static String banco = "jdbc:postgresql://localhost:5433/curso-jsp?autoReconnect=true";
	private static String usuario = "postgres";
	private static String senha = "admin";
	private static Connection connection = null;
	
	public static Connection getConnection() {
		return connection;
	}
	
	/* chama a classe diretamente */
	static {
		conectar();
	}
	
	/* instancia o objeto para fazer a conexão */
	public SingleConnectionBanco() {
		conectar();
	}
	
	private static void conectar() {
		try {
			if (connection == null) {
				Class.forName("org.postgresql.Driver"); /* carrega o driver de conexão do banco */
				connection = DriverManager.getConnection(banco, usuario, senha);
				connection.setAutoCommit(false); /* para não efetuar alterações no banco sem nosso comando*/
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();/*mostrar qualquer erro no momento de conectar*/
		}
	}

}
