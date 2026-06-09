import 'package:adota_pets_mobile/view/widgets/campo_dropdown.dart';
import 'package:adota_pets_mobile/view/widgets/campo_formulario.dart';
import 'package:adota_pets_mobile/view/widgets/seletor_porte.dart';
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
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _descricaoController = TextEditingController();

  String? _especie;
  String? _sexo;
  String? _porte;
  String? _fotoPath;
  bool _vacinado = false;
  bool _castrado = false;
  List<String> _temperamentos = [];

  static const _opcoesTemperamento = [
    'Brincalhão', 'Calmo', 'Carinhoso', 'Curioso', 'Dócil',
    'Energético', 'Independente', 'Inteligente', 'Leal',
    'Protetor', 'Sociável', 'Tímido',
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
    final foto = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (foto != null) setState(() => _fotoPath = foto.path);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cadastrar Pet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Ajude um pet a encontrar um lar',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF888888)),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F0EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.close,
                            size: 18, color: Color(0xFF444444)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              const SizedBox(height: 4),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Foto do Pet',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _selecionarFoto,
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F0EB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFDDDDDD),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: _fotoPath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(_fotoPath!,
                                      fit: BoxFit.cover),
                                )
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload_outlined,
                                        size: 28, color: Color(0xFF888888)),
                                    SizedBox(height: 6),
                                    Text(
                                      'Clique para enviar uma foto',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF888888)),
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
                              onChanged: (v) =>
                                  setState(() => _especie = v),
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
                        hint: 'Ex: São Paulo, SP',
                        controller: _localizacaoController,
                      ),

                      const SizedBox(height: 16),

                      CampoFormulario(
                        label: 'Descrição',
                        hint: 'Conte sobre a personalidade e história do pet...',
                        obrigatorio: true,
                        controller: _descricaoController,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFEEEEEE)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
                              child: Text(
                                'Saúde',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ),
                            SwitchListTile(
                              value: _vacinado,
                              onChanged: (v) =>
                                  setState(() => _vacinado = v),
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFFE8622A),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(0xFFDDDDDD),
                              title: const Text('Vacinado',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              subtitle: const Text(
                                  'Pet está com vacinas em dia',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF888888))),
                            ),
                            const Divider(
                                height: 1,
                                indent: 16,
                                color: Color(0xFFF0F0F0)),
                            SwitchListTile(
                              value: _castrado,
                              onChanged: (v) =>
                                  setState(() => _castrado = v),
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFFE8622A),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(0xFFDDDDDD),
                              title: const Text('Castrado',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              subtitle: const Text(
                                  'Pet foi castrado/esterilizado',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF888888))),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Temperamento',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
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
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: selecionado
                                    ? const Color(0xFFE8622A)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selecionado
                                      ? const Color(0xFFE8622A)
                                      : const Color(0xFFDDDDDD),
                                ),
                              ),
                              child: Text(
                                t,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: selecionado
                                      ? Colors.white
                                      : const Color(0xFF444444),
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE8622A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
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