import 'dart:io';

import 'package:adota_pets_mobile/view/services/pet_service.dart';
import 'package:adota_pets_mobile/view/widgets/campo_dropdown.dart';
import 'package:adota_pets_mobile/view/widgets/campo_formulario.dart';
import 'package:adota_pets_mobile/view/widgets/selecionar_porte.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BotaoCadastrarPet extends StatelessWidget {
  const BotaoCadastrarPet({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _abrirModal(context),
      backgroundColor: const Color(0xFFE8622A),
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  void _abrirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ModalCadastrarPet(),
    );
  }
}

class _ModalCadastrarPet extends StatefulWidget {
  const _ModalCadastrarPet();

  @override
  State<_ModalCadastrarPet> createState() => _ModalCadastrarPetState();
}

class _ModalCadastrarPetState extends State<_ModalCadastrarPet> {
  final PetService _petService = PetService();
  bool _carregando = false;

  // Mantida apenas esta variável unificada para a imagem
  XFile? _fotoSelecionada;

  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _descricaoController = TextEditingController();

  String? _especie;
  String? _sexo;
  String? _porte;
  bool _vacinado = false;
  bool _castrado = false;
  List<String> _temperamentos = [];

  static const _opcoesTemperamento = [
    'Brincalhão',
    'Calmo',
    'Carinhoso',
    'Curioso',
    'Dócil',
    'Energético',
    'Independente',
    'Inteligente',
    'Leal',
    'Protetor',
    'Sociável',
    'Tímido',
  ];

  final _picker = ImagePicker();

  @override
  void dispose() {
    _nomeController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    _localizacaoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarFoto() async {
    final XFile? imagem = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // Otimiza o tamanho da imagem enviado ao Firebase
    );

    if (imagem != null) {
      setState(() {
        _fotoSelecionada = imagem;
      });
    }
  }

  Future<void> _cadastrarPet() async {
    if (_nomeController.text.isEmpty ||
        _especie == null ||
        _sexo == null ||
        _idadeController.text.isEmpty ||
        _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos obrigatórios (*)!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _carregando = true);

    try {
      // O PetService agora recebe todas as propriedades tratadas
      await _petService.cadastrarPet(
        nome: _nomeController.text.trim(),
        especie: _especie!,
        sexo: _sexo!, // Passando o sexo selecionado no dropdown
        idade: _idadeController.text.trim(),
        porte: _porte ?? 'Médio',
        raca: _racaController.text.trim().isEmpty
            ? 'Sem raça definida'
            : _racaController.text.trim(),
        localizacao: _localizacaoController.text.trim(),
        descricao: _descricaoController.text.trim(),
        vacinado: _vacinado,
        castrado: _castrado,
        temperamentos: _temperamentos,
        imagemSelecionada: _fotoSelecionada, // Passando o arquivo XFile correto
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pet cadastrado com sucesso! 🐾"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (erro) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao salvar cadastro: ${erro.toString()}"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _carregando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: cores.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.grey[700]
                      : const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cadastrar Pet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ajude um pet a encontrar um lar',
                          style: TextStyle(
                            fontSize: 12,
                            color: cores.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey[800]
                              : const Color(0xFFF5F0EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Divider(height: 1, color: cores.outlineVariant),
              const SizedBox(height: 4),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Foto do Pet',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cores.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _selecionarFoto,
                        child: Container(
                          width: double.infinity,
                          height:
                              150, // Aumentado levemente para melhor preview da foto
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[900]
                                : const Color(0xFFF5F0EB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: cores.outline,
                              style: BorderStyle.solid,
                            ),
                          ),
                          // CORRIGIDO: Agora escuta a variável _fotoSelecionada correta
                          child: _fotoSelecionada != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: kIsWeb
                                      ? Image.network(
                                          _fotoSelecionada!.path,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(_fotoSelecionada!.path),
                                          fit: BoxFit.cover,
                                        ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_outlined,
                                      size: 28,
                                      color: cores.onSurfaceVariant,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Clique para enviar uma foto',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: cores.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      CampoFormulario(
                        label: 'Nome',
                        hint: 'Ex: Bolinha',
                        obrigatorio: true,
                        controller: _nomeController,
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: CampoDropdown(
                              label: 'Espécie',
                              obrigatorio: true,
                              valorSelecionado: _especie,
                              opcoes: const ['Cão', 'Gato', 'Pássaro', 'Outro'],
                              onChanged: (v) => setState(() => _especie = v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CampoDropdown(
                              label: 'Sexo',
                              obrigatorio: true,
                              valorSelecionado: _sexo,
                              opcoes: const ['Macho', 'Fêmea'],
                              onChanged: (v) => setState(() => _sexo = v),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: CampoFormulario(
                              label: 'Raça',
                              hint: 'Ex: Labrador',
                              controller: _racaController,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CampoFormulario(
                              label: 'Idade',
                              hint: 'Ex: 2 anos',
                              obrigatorio: true,
                              controller: _idadeController,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      SeletorPorte(
                        porteSelecionado: _porte,
                        onSelecionado: (v) => setState(() => _porte = v),
                      ),

                      const SizedBox(height: 16),

                      CampoFormulario(
                        label: 'Localização',
                        hint: 'Ex: Garanhuns, PE',
                        controller: _localizacaoController,
                      ),

                      const SizedBox(height: 16),

                      CampoFormulario(
                        label: 'Descrição',
                        hint:
                            'Conte sobre a personalidade e história do pet...',
                        obrigatorio: true,
                        controller: _descricaoController,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF2C2621)
                              : const Color(0xFFF5F0EB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cores.outlineVariant),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                              child: Text(
                                'Saúde',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: cores.onSurface,
                                ),
                              ),
                            ),
                            SwitchListTile(
                              value: _vacinado,
                              onChanged: (v) => setState(() => _vacinado = v),
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFFE8622A),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: isDarkMode
                                  ? Colors.grey[700]
                                  : const Color(0xFFDDDDDD),
                              title: Text(
                                'Vacinado',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: cores.onSurface,
                                ),
                              ),
                              subtitle: Text(
                                'Pet está com vacinas em dia',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: cores.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              indent: 16,
                              color: cores.outlineVariant,
                            ),
                            SwitchListTile(
                              value: _castrado,
                              onChanged: (v) => setState(() => _castrado = v),
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFFE8622A),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: isDarkMode
                                  ? Colors.grey[700]
                                  : const Color(0xFFDDDDDD),
                              title: Text(
                                'Castrado',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: cores.onSurface,
                                ),
                              ),
                              subtitle: Text(
                                'Pet foi castrado/esterilizado',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: cores.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Temperamento',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cores.onSurface,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _opcoesTemperamento.map((t) {
                          final selecionado = _temperamentos.contains(t);
                          return GestureDetector(
                            onTap: () => setState(() {
                              selecionado
                                  ? _temperamentos.remove(t)
                                  : _temperamentos.add(t);
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selecionado
                                    ? const Color(0xFFE8622A)
                                    : cores.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selecionado
                                      ? const Color(0xFFE8622A)
                                      : cores.outline,
                                ),
                              ),
                              child: Text(
                                t,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: selecionado
                                      ? Colors.white
                                      : cores.onSurface,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _carregando ? null : _cadastrarPet,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE8622A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          // ADICIONADO: Spinner de progresso se estiver salvando no banco
                          child: _carregando
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Cadastrar Pet',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
