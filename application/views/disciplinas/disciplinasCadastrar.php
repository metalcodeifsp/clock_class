  <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10" style="padding-top: 5px">  

            <form id="formDisciplina" class="form-Control" action="<?= site_url('Disciplina/salvar')?>" method="post">
            		<h1>Cadastrar Disciplina</h1>
				
					<div class="form-group">
						<label>Nome</label>
						<input type="text" class="form-control" id="nome_curso" name="nome_disciplina" placeholder="Nome" >
					</div>

					<div class="form-group">
						<label>Sigla</label>
						<input type="text" class="form-control" id="sigla_curso" name="sigla_disciplina" placeholder="ex: LOPA1" style="max-width:300px;" >
					</div>

					<div class="form-group">
						<label>Curso</label>	
						<select name="curso_id" id="curso_id" class="form-control" style="max-width:400px;">
                            
							  <option>Selecione</option>
                            <?php foreach($data['cursos'] as $curso){ ?>
								<option value="<?=$curso['id'] ?>"><?=$curso['nome_curso'] ?></option>    
							<?php }?>
						</select>
					</div>	
			
					<div class="form-group">
						<label>Quantidade de professores</label>
						<input type="number" class="form-control" id="qtd_professor" name="qtd_professor" placeholder="ex: 1" style="max-width:300px;">
					</div>
									
					<div class="form-group">
						<label>Módulo</label>
						<input type="number" class="form-control" id="modulo" name="modulo" placeholder="ex: 6" style="max-width: 300px">
					</div>
									
					<div class="form-group">
						<label>Qtd. Aulas por Semana</label>
						<input type="number" class="form-control" id="qtd_aulas" name="qtd_aulas" placeholder="ex: 4" style="max-width:300px;">
					</div>

					<div class="form-group">
						<label>Tipo de sala Necessária</label>	
						<select name="tipo_sala_id" id="tipo_sala_id" class="form-control" style="max-width:400px;">
                            
							  <option>Selecione</option>
                            <?php foreach($data['tipo_salas'] as $curso){ ?>
								<option value="<?=$curso['id'] ?>"><?=$curso['nome_tipo_sala'] ?></option>    
							<?php }?>
						</select>
					</div>	
									
                	<div class="form-group">
						<a class="btn btn-danger active" href="<?= base_url('index.php/Disciplina')?>" style="float: right;"><span class="glyphicon glyphicon-remove"></span> Cancelar</a>
						<button type="submit" class="btn btn-success active salvar" style="float: right; margin-right: 10px;"><span class="glyphicon glyphicon-floppy-disk"></span> Salvar</button>
					</div>
            </form>
        </div>