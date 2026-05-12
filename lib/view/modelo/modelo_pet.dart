class PetModel {
  final String nome;
  final String imageUrl;
  final String raca;
  final String especie;
  final String porte;
  final String sexo;
  final String idade;
  final String descricao;
  final List<String> temperamentos;
  final bool vacinado;
  final bool castrado;
  final String localizacao;
  final String publicadoPorTipo;
  final String publicadoPorEmail;
  final String? publicadoPorAvatarUrl;

  const PetModel({
    required this.nome,
    required this.imageUrl,
    required this.raca,
    required this.especie,
    required this.porte,
    required this.sexo,
    required this.idade,
    required this.descricao,
    required this.temperamentos,
    required this.vacinado,
    required this.castrado,
    required this.localizacao,
    required this.publicadoPorTipo,
    required this.publicadoPorEmail,
    this.publicadoPorAvatarUrl,
  });

  String get petSubtitle => '$raca • $idade • $sexo';
}