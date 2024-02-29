import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() => {
        'nome': _nome,
      };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() => {
        'nome': _nome,
        'dependentes': _dependentes.map((dependente) => dependente.toJson()).toList(),
      };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() => {
        'nomeProjeto': _nomeProjeto,
        'funcionarios': _funcionarios.map((funcionario) => funcionario.toJson()).toList(),
      };
}

void main() {
  // 1. Criar varios objetos Dependentes
  var dependente1 = Dependente('Filho 1');
  var dependente2 = Dependente('Filho 2');
  var dependente3 = Dependente('Filho 3');

  // 2. Criar varios objetos Funcionario
  var funcionario1 = Funcionario('NICOLAS', [dependente1]);
  var funcionario2 = Funcionario('FARLEY', [dependente2]);
  var funcionario3 = Funcionario('SOPHIA', [dependente3]);

  // 3. Associar os Dependentes criados aos respectivos funcionarios
  // Isso já foi feito ao criar os objetos Funcionário

  // 4. Criar uma lista de Funcionarios
  var listaFuncionarios = [funcionario1, funcionario2, funcionario3];

  // 5. criar um objeto Equipe Projeto chamando o metodo construtor que da nome ao projeto e insere uma coleção de funcionario
  var equipeProjeto = EquipeProjeto('Projeto de Desenvolvimento', listaFuncionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  print(jsonEncode(equipeProjeto.toJson()));
}
