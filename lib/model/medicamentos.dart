class Medicamentos {
  String id;
  String nomeComercial;
  String laboratorio;
  String nomePrincipioAtivo;
  String formaFarmaceutica;
  bool generico;

  Medicamentos({
    this.id,
    this.nomeComercial,
    this.laboratorio,
    this.nomePrincipioAtivo,
    this.formaFarmaceutica,
    this.generico,
  });

  Medicamentos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeComercial = json['nomeComercial'];
    laboratorio = json['laboratorio'];
    generico = json['generico'];
    nomePrincipioAtivo = json['principioAtivo'][0] != null
        ? json['principioAtivo'][0]['nome']
        : '';
    formaFarmaceutica = json['formaFarmaceutica'][0];
  }

  @override
  String toString() {
    return 'NOME COMERCIAL: ${this.nomeComercial}';
  }
}
