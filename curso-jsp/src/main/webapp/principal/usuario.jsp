<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<jsp:include page="head.jsp"></jsp:include>

<body>
	<!-- Pre-loader start -->
	<jsp:include page="theme-loader.jsp"></jsp:include>
	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navbarmymenu.jsp"></jsp:include>

					<div class="pcoded-content">
						<!-- Page-header start -->
						<jsp:include page="page-header.jsp"></jsp:include>
						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">
										<div class="row">
											<div class="col-sm-12">
												<h3 style="color: red" id="msg">${msg}</h3>
												<!-- Basic Form Inputs card start -->
												<div class="card">
													<div class="card-header">
														<h5>Cadastro de usuário</h5>
													</div>
													<div class="card-block">
														<form
															action="<%=request.getContextPath()%>/ServletUsuarioController"
															method="post" class="form-material" id="formUsuario">
															<input type="hidden" name="acao" id="acao" value="">

															<div class="form-group form-default form-static-label">
																<input type="text" name="id" id="id"
																	value="${modelLogin.id}" class="form-control"
																	readonly="readonly"> <span class="form-bar"></span>
																<label class="float-label">ID:</label>
															</div>

															<div class="form-group form-default">
																<input type="text" name="nome" id="nome"
																	autocomplete="off" value="${modelLogin.nome}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Nome:</label>
															</div>
															<div class="form-group form-default">
																<input type="email" name="email" id="email"
																	autocomplete="off" value="${modelLogin.email}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Email:
																	(exemplo@gmail.com)</label>
															</div>
															<div class="form-group form-default">
																<input type="text" name="login" id="login"
																	autocomplete="off" value="${modelLogin.login}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Login:</label>
															</div>
															<div class="form-group form-default">
																<input type="password" name="senha" id="senha"
																	autocomplete="off" value="${modellogin.senha}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Senha:</label>
															</div>

															<!-- botões -->

															<button
																class="btn waves-effect waves-light btn-grd-primary"
																type="button" onclick="limparForm();">Novo</button>
															<button type="button" data-toggle="modal"
																data-target="#myModal"
																class="btn waves-effect waves-light btn-grd-info">Pesquisar</button>
															<button
																class="btn waves-effect waves-light btn-grd-success">Salvar</button>
															<button
																class="btn waves-effect waves-light btn-grd-danger"
																type="button" onclick="criarDeleteComAjax();">Excluir</button>
														</form>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div id="styleSelector"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="javascriptfile.jsp"></jsp:include>

	<div class="modal fade" id="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Pesquisar Usuário por nome:</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Usuário"
							id="nomeBusca" aria-label="Recipient's username"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn waves-effect waves-light btn-grd-info"
								type="button" onclick="buscarUsuario();">Buscar</button>
						</div>
					</div>
					<table class="table table-sm table-responsive table-hover"
						style="height: 300px; overflow: auto;" id="tabelaResultadosUser">
						<thead class="table-waves-effect waves-light btn-grd-info">
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Nome</th>
								<th scope="col">Login</th>
								<th scope="col">Selecionar</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<span style="align-content: flex-start;" id="totalResultados"></span>
					<button type="button"
						class="btn waves-effect waves-light btn-grd-inverse"
						data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function verEditar(id) {

			var urlAction = document.getElementById('formUsuario').action;
			window.location.href = urlAction + '?acao=buscarEditar&id=' + id;

		}

		function buscarUsuario() {
			var nomeBusca = document.getElementById('nomeBusca').value;
			if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != '') { /* Validando que o campo tem que ter valor para buscar no banco*/
				var urlAction = document.getElementById('formUsuario').action;

				$
						.ajax(
								{
									method : "get",
									url : urlAction,
									data : "nomeBusca=" + nomeBusca
											+ '&acao=BuscarUserAjax',
									success : function(response) {
										var json = JSON.parse(response);

										$('#tabelaResultadosUser > tbody > tr')
												.remove();
										for (var p = 0; p < json.length; p++) {
											$('#tabelaResultadosUser > tbody')
													.append(
															'<tr> <td>'
																	+ json[p].id
																	+ '</td> <td>'
																	+ json[p].nome
																	+ '</td> <td>'
																	+ json[p].login
																	+ '</td> <td><button type="button" onclick="verEditar('
																	+ json[p].id
																	+ ')" class="btn waves-effect waves-light btn-grd-success">Ver</button></td> </tr>');
										}
										document
												.getElementById('totalResultados').textContent = json.length
												+ ' usuarios encontrados.';
									}
								}).fail(
								function(xhr, status, errorThrown) {
									alert('Erro ao buscar o usuário por nome: '
											+ xhr.responseText);
								});
			}
		}

		/* criando o delete com Ajax, necessário ter o jquery*/

		function criarDeleteComAjax() {
			if (confirm('Deseja realmente excluir os dados?')) {
				var urlAction = document.getElementById('formUsuario').action;
				var idUser = document.getElementById('id').value;
				$.ajax({
					method : "get",
					url : urlAction,
					data : "id=" + idUser + '&acao=deletarAjax',
					success : function(response) {
						limparForm();
						document.getElementById('msg').textContext = response;
						alert(response);
					}
				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao deletar o usuário por ID: '
									+ xhr.responseText);
						});
			}

		}

		function criarDelete() {
			if (confirm('Realmente deseja excluir os dados? Operação não poderá ser desfeita.')) {
				document.getElementById("formUsuario").method = 'get';
				document.getElementById("acao").value = 'deletar';
				document.getElementById("formUsuario").submit();
				limparForm();
			}
		}

		function limparForm() {
			var elementos = document.getElementById("formUsuario").elements; /* retorna os elementos html dentro do form*/

			for (var p = 0; p < elementos.length; p++) {
				elementos[p].value = '';
			}
		}
	</script>

</body>

</html>
