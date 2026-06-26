import 'package:adota_pets_mobile/view/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_mensagem.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/widgets/bolha_mensagem.dart';
import 'package:adota_pets_mobile/view/widgets/chat_cabe%C3%A7alho.dart';
import 'package:adota_pets_mobile/view/widgets/chat_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class TelaChat extends StatefulWidget {
  final PetModel pet;
  final String chatId;

  const TelaChat({super.key, required this.pet, required this.chatId});

  @override
  State<TelaChat> createState() => _TelaChatState();
}

class _TelaChatState extends State<TelaChat> {
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final String? _meuEmail = FirebaseAuth.instance.currentUser?.email;

  String _chatId = '';

  @override
  void initState() {
    super.initState();
    _chatId = widget.chatId;

    _chatService.criarConversaSeNaoExistir(
      chatId: _chatId,
      donoNome: widget.pet.publicadoPorTipo,
      donoEmail: widget.pet.publicadoPorEmail,
      petNome: widget.pet.nome,
      petImageUrl: widget.pet.imageUrl,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  void _onEnviarTexto(String texto) async {
    if (texto.trim().isEmpty) return;
    await _chatService.enviarMensagem(
      chatId: _chatId,
      texto: texto,
      tipo: 'texto',
    );
    _scrollParaBaixo();
  }

  Future<void> _onEnviarImagem() async {
    final XFile? imagem = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (imagem == null) return;

    await _chatService.enviarMensagem(
      chatId: _chatId,
      texto: '',
      imagemUrl: imagem.path,
      tipo: 'imagem',
    );
    _scrollParaBaixo();
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatService.escutarMensagens(_chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE8622A)),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _scrollParaBaixo(),
                );

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final dados = docs[index].data() as Map<String, dynamic>;

                    final ModeloMensagem mensagem = ModeloMensagem(
                      id: docs[index].id,
                      texto: dados['texto'] ?? '',
                      imagemUrl: dados['imagemUrl'],
                      tipo: dados['tipo'] == 'imagem'
                          ? TipoMensagem.imagem
                          : TipoMensagem.texto,
                      isMinha: dados['enviadoPorEmail'] == _meuEmail,
                      horario:
                          (dados['criadoEm'] as Timestamp?)?.toDate() ??
                          DateTime.now(),
                    );

                    return BolhaMensagem(mensagem: mensagem);
                  },
                );
              },
            ),
          ),
          ChatInput(
            onEnviarTexto: _onEnviarTexto,
            onEnviarImagem: _onEnviarImagem,
          ),
        ],
      ),
    );
  }
}
