<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Pessoa extends MY_Controller {
    private $id_docente = 1;

    function index() {
        $pessoas = Pessoa_model::all();
        $this->load->template('pessoas/pessoas', compact('pessoas'),'pessoas/js_pessoas');
    }

    function cadastrar() {
        $tipos = Tipo_model::all();
        $this->load->template('pessoas/cadastrar', compact('tipos'),'pessoas/js_pessoas');
    }

    function salvar() {
        DB::transaction(function() {
            // Se o docente estiver na lista de tipos
            $has_docente = in_array($this->id_docente, $this->request('tipos'));

            $this->set_validations([
                ['nome', 'nome', 'required|min_length[5]'],
                ['prontuario', 'prontuário', 'required|is_unique[pessoa.prontuario]|exact_length[7]'],
                ['senha', 'senha', 'required|min_length[6]'],
                ['data_nascimento', 'data de nascimento', 'required|valid_date'],
                ['email', 'email', 'required|valid_email'],
            ]);

            if($has_docente) {
                $this->set_validations([
                    ['data_ingresso_campus', 'data de ingresso no câmpus', 'required|valid_date'],
                    ['data_ingresso_ifsp', 'data de ingresso no IFSP', 'required|valid_date'],
                    ['area', 'área', 'required'],
                    ['regime_contrato', 'regime de contrato', 'required|in_list[20, 40]'],
                ]);
            }

            $this->run_validation();

            $pessoa = Pessoa_model::create($this->request_all());
            if($has_docente) {
                $docente = Docente_model::create($this->request_all());
            }

            // Monta as relações de tipo
            $pessoa->tipos()->sync($this->request('tipos'));

            $this->session->set_flashdata('success', 'Pessoa cadastrada com sucesso');
        });
    }

    function editar($id) {
        $pessoa = Pessoa_model::findOrFail($id);
        $tipos = Tipo_model::all();
        $this->load->template('pessoas/editar', compact('pessoa', 'tipos'));
    }

    function atualizar($id) {
        DB::transaction(function() use ($id) {
            $pessoa = Pessoa_model::findOrFail($id);
            $has_docente = in_array($this->id_docente, $this->request('tipos')); // Se o docente estiver na lista de tipos

            $this->set_validations([
                'nome', 'nome', 'required|min_length[5]',
                'prontuario', 'prontuário', 'required|exact_length[7]',
                'senha', 'senha', 'required|min_length[6]',
                'data_nascimento', 'data de nascimento', 'required|valid_date',
                'email', 'email', 'required|valid_email',
            ]);

            if($has_docente) {
                $this->set_validations([
                    'data_ingresso_campus', 'data de ingresso no câmpus', 'required|valid_date',
                    'data_ingresso_ifsp', 'data de ingresso no IFSP', 'required|valid_date',
                    'area', 'área', 'required',
                    'regime_contrato', 'regime de contrato', 'required|in_list[20, 40]',
                ]);
            }

            $this->run_validation();

            $pessoa->update($this->request_all());
            if($has_docente) {
                $docente = $pessoa->docente;
                $docente->update($this->request_all());
            } else if(!is_null($pessoa->docente)){
                $pessoa->docente->delete();
            }

            // Realinha os tipos
            $pessoa->tipos()->sync($this->request('tipos'));

            $this->session->set_flashdata('success', 'Pessoa atualizada com sucesso');
        });
    }

    function deletar($id) {
        Pessoa_model::findOrFail($id)->delete();
        $this->session->set_flashdata('success', 'Pessoa deletada com sucesso');
    }

    /**
     * Ativa a Pessoa
     * @author Denny Azevedo
     * @since 2017/09/11
     * @param ID da Pessoa
    */
    function ativar ($id) {
        Pessoa_model::withTrashed()->findOrFail($id)->restore();
        $this->session->set_flashdata('success','Pessoa ativada com sucesso');
    }

}
