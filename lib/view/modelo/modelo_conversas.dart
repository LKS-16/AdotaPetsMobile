class ModeloConversa {
  final String id;
  final String petNome;
  final String petImageUrl;
  final String contatoNome;
  final String ultimaMensagem;
  final DateTime horario;
  final int mensagensNaoLidas;

  const ModeloConversa({
    required this.id,
    required this.petNome,
    required this.petImageUrl,
    required this.contatoNome,
    required this.ultimaMensagem,
    required this.horario,
    this.mensagensNaoLidas = 0,
  });

  String get horarioFormatado {
    final agora = DateTime.now();
    final diferenca = agora.difference(horario);

    if (diferenca.inMinutes < 60) {
      return '${diferenca.inMinutes}m';
    } else if (diferenca.inHours < 24) {
      return '${diferenca.inHours}h';
    } else {
      final d = horario.day.toString().padLeft(2, '0');
      final m = horario.month.toString().padLeft(2, '0');
      return '$d/$m';
    }
  }
}