<?php defined('BASEPATH') OR exit('No direct script access allowed');

  /**
   *  Essa classe é responsavel por todas regras de negócio sobre disciplinas.
   *  @since 2017/03/17
   *  @author Caio de Freitas
   */
  class Disciplina extends CI_Controller {

    public function index () {
      $this->cadastro();
    }


    // =========================================================================
    // ==========================CRUD de disciplinas============================
    // =========================================================================

    /**
      * Valida os dados do forumulário de cadastro de disciplinas.
      * Caso o formulario esteja valido, envia os dados para o modelo realizar
      * a persistencia dos dados.
      * @author Caio de Freitas
      * @since 2017/03/17
      */
    public function cadastro () {
      // Carrega a biblioteca para validação dos dados.
      $this->load->library(array('form_validation','session'));
      $this->load->helper(array('form','url'));
      $this->load->model(array('Disciplina_model'));

      // Definir as regras de validação para cada campo do formulário.
      $this->form_validation->set_rules('nome', 'nome da disciplina', array('required','min_length[5]','ucwords'));
      $this->form_validation->set_rules('sigla', 'sigla', array('required', 'max_length[5]', 'is_unique[Disciplina.sigla]','strtoupper'));
      $this->form_validation->set_rules('qtdProf', 'quantidade de professores', array('required', 'integer', 'greater_than[0]', 'less_than[10]'));
      // Definição dos delimitadores
      $this->form_validation->set_error_delimiters('<p class="text-danger">','</p>');

      // Verifica se o formulario é valido
      if ($this->form_validation->run() == FALSE) {

        $this->session->set_flashdata('formDanger','<strong>Não foi possível cadastrar a disciplina, pois existe(m) erro(s) no formulário:</strong>');

        $dados['disciplinas'] = $this->Disciplina_model->getAll();
	      $this->load->view('disciplinas', $dados);

      } else {

        // Pega os dados do formulário
        $disciplina = array(
          'nome'      => $this->input->post("nome"),
          'sigla'     => $this->input->post('sigla'),
          'qtdProf'   => $this->input->post("qtdProf")
        );

        if ($this->Disciplina_model->insert($disciplina)){
          $this->session->set_flashdata('success','Disciplina cadastrada com sucesso');
        } else {
          $this->session->set_flashdata('danger','Não foi possível cadastrar a disciplina, tente novamente ou entre em contato com o administrador do sistema.');
        }

        redirect('/');

      }
    }

    /**
      * Deleta uma disciplina.
      * @author Caio de Freitas
      * @since  2017/03/21
      * @param $id ID da disciplina
      */
    public function desativar ($id) {
      // Carrega os modelos necessarios
      $this->load->model(array('Disciplina_model'));

      if ( $this->Disciplina_model->disable($id) )
        $this->session->set_flashdata('success','Disciplina desativada com sucesso');
      else
        $this->session->set_flashdata('danger','Não foi possível desativar a disciplina, tente novamente ou entre em contato com o administrador do sistema.');

      redirect('/');
    }

    public function ativar ($id) {
      $this->load->model('Disciplina_model');

      if ( $this->Disciplina_model->able($id) )
        $this->session->set_flashdata('success','Disciplina ativada com sucesso!');
      else
        $this->session->set_flashdata('danger','Não foi possível ativar a disciplina, tente novamente ou entre em contato com o administrador do sistema');

      redirect('Disciplina');
    }

    /**
      * Altera os dado da disciplina.
      * @author Caio de Freitas
      * @since 2017/03/21
      * @param $id ID da disciplina
      */
    public function atualizar () {

      $this->load->library('form_validation');
      $this->load->model(array('Disciplina_model'));

      // Definir as regras de validação para cada campo do formulário.
      $this->form_validation->set_rules('recipient-nome', 'nome', array('required','min_length[5]','ucwords'));
      $this->form_validation->set_rules('recipient-sigla', 'sigla', array('required', 'max_length[5]','strtoupper'));
      $this->form_validation->set_rules('recipient-qtd-prof', 'quantidade de professores', array('required', 'integer', 'greater_than[0]'));
      // Definição dos delimitadores
      $this->form_validation->set_error_delimiters('<p class="text-danger">','</p>');

      // Verifica se o formulario é valido
      if ($this->form_validation->run() == FALSE) {

        $this->session->set_flashdata('formDanger','<strong>Não foi possível atualizar os dados da disciplina:</strong>');

        $dados['disciplinas'] = $this->Disciplina_model->getAll();
        $this->load->view('disciplinas', $dados);
      } else {

        $id = $this->input->post('recipient-id');

        // Pega os dados do formulário
        $disciplina = array(
          'nome'        => $this->input->post("recipient-nome"),
          'sigla'       => $this->input->post('recipient-sigla'),
          'qtdProf'     => $this->input->post("recipient-qtd-prof")
        );

        if ( $this->Disciplina_model->update($id, $disciplina) )
          $this->session->set_flashdata('success', 'Disciplina atualizada com sucesso');
        else
          $this->session->set_flashdata('danger','Não foi possível atualizar os dados da disciplina, tente novamente ou entre em contato com o administrador do sistema.');

        redirect('/');

      }
    }



  }

?>
