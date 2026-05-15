enum TipoMensagem { texto, imagem }

class ModeloMensagem {
  final String id;
  final String texto;
  final String? imagemUrl;
  final TipoMensagem tipo;
  final bool isMinha;
  final DateTime horario;

  const ModeloMensagem({
    required this.id,
    required this.texto,
    this.imagemUrl,
    required this.tipo,
    required this.isMinha,
    required this.horario,
  });

  String get horarioFormatado {
    final h = horario.hour.toString().padLeft(2, '0');
    final m = horario.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}