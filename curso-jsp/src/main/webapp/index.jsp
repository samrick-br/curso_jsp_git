<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<title>Curso Java-JSP com Maven</title>

<style type="text/css">
form, button {
	position: relative;
	top: 20%;
	justify-content: center;
	left: 3%;
	max-width: 95%;
}

h1 {
	position: relative;
	margin-top: 20%;
	justify-content: center;
	left: 3%;
	max-width: 95%;
}

h4 {
	color: red;
	position: relative;
	margin-top: 5%;
	justify-content: center;
	max-width: 95%;
	position: relative;
}

button {
	position: relative;
	left: 0%;
	max-width: 95%;
	left: 0%;
}
</style>

</head>
<body>
	<h1 align="center">Bem vindo ao curso de JSP!</h1>

	<form action="/curso-jsp/ServletLogin" method="post"
		class="row g-3 needs-validation" novalidate="novalidate">

		<div class="col-md-4">
			<label for="login" class="form-label">Login</label> <input
				name="login" type="text" class="form-control" id="login" required>
			<div class="valid-feedback">Login Ok!</div>
		</div>
		<div class="col-md-4">
			<label for="senha" class="form-label">Senha</label> <input
				name="senha" type="password" class="form-control" id="senha"
				required>
			<div class="valid-feedback">Senha Ok!</div>
		</div>

		<div class="row w-50" align="left">
			<button class="btn btn-primary" type="submit">Logar no
				sistema</button>
		</div>
	</form>

	<h4 align="center">${msg}</h4>
	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

</body>
<script type="text/javascript">
	(function() {
		'use strict'

		// Fetch all the forms we want to apply custom Bootstrap validation styles to
		var forms = document.querySelectorAll('.needs-validation')

		// Loop over them and prevent submission
		Array.prototype.slice.call(forms).forEach(function(form) {
			form.addEventListener('submit', function(event) {
				if (!form.checkValidity()) {
					event.preventDefault()
					event.stopPropagation()
				}

				form.classList.add('was-validated')
			}, false)
		})
	})()
</script>
</html>