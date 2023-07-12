package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin objeto) throws Exception {

		if (objeto.isNovo()) { /* Insere um novo registro */

			String sql = "INSERT INTO model_login(login, senha, nome, email) VALUES (?, ?, ?, ?)";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, objeto.getLogin());
			statement.setString(2, objeto.getSenha());
			statement.setString(3, objeto.getNome());
			statement.setString(4, objeto.getEmail());
			statement.execute();
			connection.commit();
		} else {
			String sql = "UPDATE model_login SET login=?, senha=?," + " nome=?, email=?	WHERE id = '" + objeto.getId()
					+ "'";
			PreparedStatement statement = connection.prepareStatement(sql);

			statement.setString(1, objeto.getLogin());
			statement.setString(2, objeto.getSenha());
			statement.setString(3, objeto.getNome());
			statement.setString(4, objeto.getEmail());
			statement.executeUpdate();
			connection.commit();
		}

		return this.consultausuario(objeto.getLogin());
	}

	public void deletarUsuario(String idUser) throws Exception {
		String sql = "DELETE FROM model_login	WHERE id = ?";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, Long.parseLong(idUser));

		statement.executeUpdate();
		connection.commit();

	}

	public List<ModelLogin> consultarUsuarioList(String nome) throws Exception {

		List<ModelLogin> retorno = new ArrayList<ModelLogin>();

		String sql = "select * from model_login where upper(nome) like upper (?)";

		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, "%" + nome + "%");

		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) { /* percorrer as linhas de resultado do sql */
			ModelLogin modelLogin = new ModelLogin();

			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setNome(resultado.getString("nome"));

			retorno.add(modelLogin);

		}
		return retorno;
	}

	public ModelLogin consultausuario(String login) throws Exception {

		ModelLogin modelLogin = new ModelLogin();

		String sql = "SELECT * FROM model_login where upper(login) = upper('" + login + "')";
		PreparedStatement statement = connection.prepareStatement(sql);

		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));

		}
		return modelLogin;
	}

	public boolean validarLogin(String login) throws Exception {
		String sql = "select count(1) > 0 as existe from model_login where upper(login) = upper('" + login + "')";

		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultado = statement.executeQuery();

		resultado.next();
		return resultado.getBoolean("existe");
	}
}
