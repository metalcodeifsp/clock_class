		<script>
			$("#professorDisciplinas").multiSelect({
				selectableHeader: "<div class='multiselect'>Selecione as disciplinas</div>",
				selectionHeader: "<div class='multiselect'>Disciplinas selecionadas</div>"
			});
			$("#disciplinas").multiSelect({
				selectableHeader: "<div class='multiselect'>Selecione as disciplinas</div>",
				selectionHeader: "<div class='multiselect'>Disciplinas selecionadas</div>"
			});

			$('#professorDisciplinasView').multiSelect();
		</script>


		<script type="text/javascript">
			$('#exampleModal').on('show.bs.modal', function (event){
			  $("#professorDisciplinas").multiSelect('deselect_all')
			  var  button          =     $(event.relatedTarget) // Button that triggered the mod al
			  var  recipient       =    button.data('whatever') // Extract info from data-* attributes
			  // Foi criado todos os var caso seja necessario adicionar ou mudar os que já existem
			  var recipientnome = button.data('whatevernome')
			  var recipientmatricula = button.data('whatevermatricula')
			  var recipientnomeDisciplina = button.data('whatevernomeDisciplina')
			  var recipientnascimento = button.data('whatevernascimento')
			  var recipientemail = button.data('whateveremail')
			  var recipientnivelAcademico = button.data('whatevernivel')
			  var recipientregimeContrato = button.data('whatevercontrato')
			  var recipientcoordenador = button.data('whatevercoordenador')
			  var recipientIdCurso = button.data('whatevercurso')
			  var recipientid = button.data('whateverid')
			  var url = '<?= base_url('index.php/Professor/disciplinas/') ?>'+recipientid;
			  $.getJSON(url,function (response) {
				var disciplinas = [];
				$.each(response, function (index, value) {
				  disciplinas.push(value.id);
				});
			  $("#professorDisciplinas").multiSelect('select',disciplinas);
				});

			// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
			// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
			var modal = $(this)
			modal.find('.modal-title').text('Alterar Professores')
			// Foi criado todos os modal caso seja necessario adicionar ou mudar os que já existem
			modal.find('#recipient-nome').val(recipientnome)
			modal.find('#recipient-matricula').val(recipientmatricula)
			modal.find('#recipient-nomeDisciplina').val(recipientnomeDisciplina)
			modal.find('#recipient-nascimento').val(recipientnascimento)
			modal.find('#recipient-email').val(recipientemail)
			modal.find('select[name=recipient-nivelAcademico] option[value='+recipientnivelAcademico+']').prop('selected',true)
			modal.find('select[name=recipient-contrato] option[value='+recipientregimeContrato+']').prop('selected',true)
			modal.find('#recipient-id').val(recipientid)
			modal.find('#recipient-coordenador').prop('checked',recipientcoordenador)

			});


			  $('#exampleModal2').on('show.bs.modal', function (event){
			  $("#professorDisciplinas").multiSelect('deselect_all')
			  var  button          =     $(event.relatedTarget) // Button that triggered the mod al
			  var  recipient       =    button.data('whatever') // Extract info from data-* attributes
			  // Foi criado todos os var caso seja necessario adicionar ou mudar os que já existem
			  var recipientnome = button.data('whatevernome')
			  var recipientmatricula = button.data('whatevermatricula')
			  var recipientnomeDisciplina = button.data('whatevernomeDisciplina')
			  var recipientnascimento = button.data('whatevernascimento')
			  var recipientemail = button.data('whateveremail')
			  var recipientnivelAcademico = button.data('whatevernivel')
			  var recipientregimeContrato = button.data('whatevercontrato')
			  var recipientcoordenador = button.data('whatevercoordenador')
			  var recipientid = button.data('whateverid')
			  var recipientIdCurso = button.data('whatevercurso')
			  var url = '<?= base_url('index.php/Professor/disciplinas/') ?>'+recipientid;
			  $.getJSON(url,function (response) {
				var disciplinas = [];
				$.each(response, function (index, value) {
				  disciplinas.push(value.id);
				});
			  $("#professorDisciplinas").multiSelect('select',disciplinas);
			});

			// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
			// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
			var modal = $(this)
			modal.find('.modal-title').text('Visuzalizar Professor')
			// Foi criado todos os modal caso seja necessario adicionar ou mudar os que já existem
			modal.find('#recipient-nome').val(recipientnome)
			modal.find('#recipient-matricula').val(recipientmatricula)
			modal.find('#recipient-nomeDisciplina').val(recipientnomeDisciplina)
			modal.find('#recipient-nascimento').val(recipientnascimento)
			modal.find('#recipient-email').val(recipientemail)
			modal.find('select[name=recipient-nivelAcademico] option[value='+recipientnivelAcademico+']').prop('selected',true)
			modal.find('select[name=recipient-contrato] option[value='+recipientregimeContrato+']').prop('selected',true)
			modal.find('#recipient-id').val(recipientid)
			modal.find('#recipient-coordenador-view').prop('checked',recipientcoordenador)

			var url = '<?= base_url('index.php/Professor/disciplinas/') ?>'+recipientid;

			$('#disciplinaTable-view li').remove();
			$.getJSON(url,function (response) {
				var disciplinas = [];
				$.each(response, function (index, value) {
					var row = '<li>'+value.nome+'</li>';
					$('#disciplinaTable-view').prepend(row);
				});
			});

			});
		</script>


		<script type="text/javascript">
			$(document).ready(function () {
				$("#professorTable").DataTable({
					"language": {
						"url": "//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese-Brasil.json"
					}
				});
			});
		</script>

		<script type="text/javascript">
			function exclude(id) {
				bootbox.confirm({
					message: "Realmente deseja desativar esse Professor?",
					buttons: {
						confirm: {
							label: 'Sim',
							className: 'btn-success'
						},
						cancel: {
							label: 'Não',
							className: 'btn-danger'
						}
					},
					callback: function (result) {
						if (result)
							window.location.href = '<?= base_url('index.php/Professor/desativar/') ?>' + id
					}
				});
			}
			function able(id) {
				bootbox.confirm({
					message: "Realmente deseja ativar esse Professor?",
					buttons: {
						confirm: {
							label: 'Sim',
							className: 'btn-success'
						},
						cancel: {
							label: 'Não',
							className: 'btn-danger'
						}
					},
					callback: function (result) {
						if (result)
							window.location.href = 'Professor/ativar/' + id
					}
				});
			}
		</script>

		<script type="text/javascript">
			$(document).ready(function () {
				$("input[name=nascimento]").mask('00/00/0000', {placeholder: "__/__/____"});
			});
		</script>

		<script type="text/javascript">
			$(document).ready(function(){
				jQuery.validator.addMethod("exactlength", function(value, element, param) {
					return this.optional(element) || value.length == param;
				},
				$.validator.format("Insira exatamente {0} caracteres"));

				$.validator.addMethod("date", function(value, element) {
					var check = false;
				    var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
					if( re.test(value)){
						var adata = value.split('/');
						var gg = parseInt(adata[0],10);
						var mm = parseInt(adata[1],10);
						var aaaa = parseInt(adata[2],10);
						var xdata = new Date(aaaa,mm-1,gg);
						if ( ( xdata.getFullYear() == aaaa ) && ( xdata.getMonth () == mm - 1 ) && ( xdata.getDate() == gg ) && ( xdata.getFullYear() > 1917 ))
							check = true;
						else
							check = false;
					} else
						check = false;
					return this.optional(element) || check;
				},
				"Insira uma data válida");

				$('#cadastrarProfessor').validate({
					rules: {
						nome: { required: true, minlength: 5, maxlength: 255 },
						matricula: { required: true, minlength: 8, remote: '<?= base_url("index.php/Professor/verificaMatricula/") ?>' },
						email: { required: true, email: true, remote: '<?= base_url("index.php/Professor/verificaEmail/") ?>' },
						nascimento: { required: true, date: true},
						nivel: { required: true, min: 1 },
						contrato: { required: true, min: 1}
					},
					messages: {
						nome: { required: 'Campo obrigatório', minlength: 'O campo nome deve ter no mínimo 5 caracteres', maxlength: 'O campo nome deve ter no máximo 255 caracteres' },
						matricula: { required: 'Campo obrigatório' , minlength:'Insira exatamente 8 caracteres', remote: 'Esta matrícula já está em uso'},
						email: { required: 'Campo obrigatório', email: 'Insira um e-mail válido', remote: 'Este e-mail já está em uso' },
						nascimento: { required: 'Campo obrigatório'},
						nivel: { required: 'Campo obrigatório', min: 'Campo obrigatório'},
						contrato: { required: 'Campo obrigatório', min: 'Campo obrigatório'}
					}
				});


				$('#modalProfessor').validate({
					rules: {
						'recipient-nome': { required: true, minlength: 5, maxlength: 255 },
						'recipient-matricula': { required: true, minlength: 8},
						'recipient-email': { required: true, email: true },
						'recipient-nascimento': { required: true, date: true},
						'recipient-nivelAcademico': { required: true, min: 1 },
						'recipient-contrato': { required: true, min: 1}
					},
					messages: {
						'recipient-nome': { required: 'Campo obrigatório', minlength: 'O campo nome deve ter no mínimo 5 caracteres', maxlength: 'O campo nome deve ter no máximo 255 caracteres' },
						'recipient-matricula': { required: 'Campo obrigatório' , minlength:'Insira exatamente 8 caracteres' },
						'recipient-email': { required: 'Campo obrigatório', email: 'Insira um e-mail válido' },
						'recipient-nascimento': { required: 'Campo obrigatório' },
						'recipient-nivelAcademico': { required: 'Campo obrigatório', min: 'Campo obrigatório' },
						'recipient-contrato': { required: 'Campo obrigatório', min: 'Campo obrigatório' }
					}
				});

			});

		</script>
	</body>
</html>
