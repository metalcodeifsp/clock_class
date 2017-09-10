<!--<pre>
		<?php print_r($grau_id) ?>
</pre> -->
 <div class="col-xs=10 col-sm-10 col-md-10">
								<form  name="formCurso" method="post" action="<?= site_url('curso/salvar')?>">
										<div class="row">	
											<div class="col-xs-12 col-sm-12 col-md-11 form-group">
										
												<label>Nome:</label>
												<input class="form-control" placeholder="Nome" name="nome_curso" id="nome_curso" maxlength="75" required>
												
											</div>
										</div>
										<div class="row">
										  <div class="col-md-3 margin-top-error">
											<?= form_error('nome_curso') ?>
										  </div>
										</div>

										<div class="row">
											<div class="form-group col-sm-3 col-md-2">
											<label>Sigla</label>
												<input class="form-control" placeholder="ex: ADS" name="sigla_curso" id="sigla_curso" maxlength="3" required>
																		
											</div>
										</div>

										<div class="row">
										  <div class="col-md-3 margin-top-error">
											<?= form_error('sigla_curso') ?>
										  </div>
										</div>
										
										<div class="row">
											<div class="form-group col-sm-3 col-md-2">
											<label>Codigo</label>
												<input class="form-control" placeholder="ex: 123" type="number" name="codigo_curso" id="codigo_curso" maxlength="5"required>
																		
											</div>
										</div>

										<div class="row">
										  <div class="col-md-3 margin-top-error">
											<?= form_error('codigo_curso') ?>
										  </div>
										</div>


										<div class="row">
											<div class="form-group col-sm-3 col-md-2">
												<label>Quantidade de semestres</label>
												<input class="form-control" placeholder="ex: 2" type="number" name="qtd_semestre" id="qtd_semestre" maxlength="2" required>
												
											</div>
										</div>

										<div class="row">
										  <div class="col-md-3 margin-top-error">
											<?= form_error('qtd_semestre') ?>
										  </div>
										</div>
										<div class="row">	
										
											<div class="col-xs-12 col-sm-12 col-md-11 form-group">
												<label>Fechamento</label><br>
												<label><input type="radio" name="fechamento" id="radioBimestral" value="Bimestral">Bimestral</label>
												<label><input type="radio" name="fechamento" id="radioSemestral" value="Semestral">Semestral</label>
											</div>
										</div>
										
										<div class="row">
											<div class="form-group col-sm-5 col-md-4">
												<label>modalidade</label>
												<?= form_dropdown('modalidade', $grau_id, set_value('modalidade'), array('class' => 'form-control')) ?>
											</div>
										</div>

										<div class="row">
										  <div class="col-md-3 margin-top-error">
											<?= form_error('grau_id') ?>
										  </div>
										</div>
										
										<div class="row">
											<div class="col-md-12 form-group">
												<a class="btn btn-danger active" href="<?= base_url('index.php/Curso')?>" style="float: right;"><span class="glyphicon glyphicon-remove"></span> Cancelar</a>
												<button type="submit" class="btn btn-success active salvar" style="float: right; margin-right: 10px;"><span class="glyphicon glyphicon-floppy-disk"></span> Salvar</button>
											</div>
										</div>
										
								</form>
											
							</div>