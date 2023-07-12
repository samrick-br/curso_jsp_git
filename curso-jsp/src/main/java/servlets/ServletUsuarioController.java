package servlets;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

@WebServlet("/ServletUsuarioController")
public class ServletUsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

	public ServletUsuarioController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao");

			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				String idUser = request.getParameter("id");
				daoUsuarioRepository.deletarUsuario(idUser);
				request.setAttribute("msg", "Usuário deletado com sucesso! Operação não poderá ser desfeita.");
				request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarAjax")) {
				String idUser = request.getParameter("id");
				daoUsuarioRepository.deletarUsuario(idUser);
				response.getWriter().write("Usuário deletado com sucesso! Operação não poderá ser desfeita.");
			}
			else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("BuscarUserAjax")) {
				String nomeBusca = request.getParameter("nomeBusca");
				System.out.println(nomeBusca);
			    List<ModelLogin> dadosJsonUser =  daoUsuarioRepository.consultarUsuarioList(nomeBusca);
			    
			    /* adicionar dependencia Jacson Json no pom do maven */
			    ObjectMapper mapper = new ObjectMapper();
			    String json = mapper.writeValueAsString(dadosJsonUser);
			    
				response.getWriter().write(json);
			}
			else {
				request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String msg = "Operação realizada com sucesso!";

			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");

			ModelLogin modelLogin = new ModelLogin();

			/* verificação se o id não é vazio nem nulo, então passa nulo */
			modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelLogin.setNome(nome);
			modelLogin.setEmail(email);
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);

			if (daoUsuarioRepository.validarLogin(modelLogin.getLogin())
					&& modelLogin.getId() == null) { /* verifica se existe o usuario e se está cadastrando um novo */
				msg = "Já existe um usuário com este login, informe um login diferente!";
			} else {
				if (modelLogin.isNovo()) {
					msg = "Novo usuário gravado com sucesso!";
				} else {
					msg = "Usuario atualizado com sucesso!";
				}
				modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin);
			}

			request.setAttribute("msg", msg);
			RequestDispatcher redirecionar = request.getRequestDispatcher("principal/usuario.jsp");
			request.setAttribute("modelLogin", modelLogin);
			redirecionar.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
