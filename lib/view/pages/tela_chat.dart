import 'dart:io';

import 'package:adota_pets_mobile/view/modelo/modelo_mensagem.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/widgets/bolha_mensagem.dart';
import 'package:adota_pets_mobile/view/widgets/chat_cabe%C3%A7alho.dart';
import 'package:adota_pets_mobile/view/widgets/chat_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class TelaChat extends StatefulWidget {
  final PetModel pet;

  const TelaChat({super.key, required this.pet});

  @override
  State<TelaChat> createState() => _TelaChatState();
}

class _TelaChatState extends State<TelaChat> {
  final List<ModeloMensagem> _mensagens = [
    // Mensagem inicial do abrigo
    ModeloMensagem(
      id: '0',
      texto:
          'Olá! Vi que você tem interesse em adotar ${''/* preenchido no initState */}. Como posso te ajudar?',
      tipo: TipoMensagem.texto,
      isMinha: false,
      horario: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _mensagens[0] = ModeloMensagem(
      id: '0',
      texto:
          'Olá! Vi que você tem interesse em adotar ${widget.pet.nome}. Como posso te ajudar?',
      tipo: TipoMensagem.texto,
      isMinha: false,
      horario: DateTime.now().subtract(const Duration(minutes: 5)),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _adicionarMensagem(ModeloMensagem mensagem) {
    setState(() => _mensagens.add(mensagem));
    Future.delayed(const Duration(milliseconds: 100), _scrollParaBaixo);
  }

  void _scrollParaBaixo() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _onEnviarTexto(String texto) {
    _adicionarMensagem(ModeloMensagem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      texto: texto,
      tipo: TipoMensagem.texto,
      isMinha: true,
      horario: DateTime.now(),
    ));
  }

  Future<void> _onEnviarImagem() async {
    final XFile? imagem =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (imagem == null) return;

    _adicionarMensagem(ModeloMensagem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      texto: '',
      imagemUrl: imagem.path, 
      tipo: TipoMensagem.imagem,
      isMinha: true,
      horario: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: ChatCabecalho(
        petNome: widget.pet.nome,
        petImageUrl: widget.pet.imageUrl,
        contatoNome: widget.pet.publicadoPorTipo,
      ),
      body: Column(
        children: [
          // Lista de mensagens
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _mensagens.length,
              itemBuilder: (context, index) {
                return BolhaMensagem(mensagem: _mensagens[index]);
              },
            ),
          ),

          // Campo de input
          ChatInput(
            onEnviarTexto: _onEnviarTexto,
            onEnviarImagem: _onEnviarImagem,
          ),
        ],
      ),
    );
  }
}