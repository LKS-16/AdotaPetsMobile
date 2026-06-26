import 'package:flutter/material.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';

class FavoritosController extends ChangeNotifier {
  final List<PetModel> _petsFavoritos = [];

  List<PetModel> get petsFavoritos => _petsFavoritos;

  bool isFavoritado(PetModel pet) {
    return _petsFavoritos.any((p) => p.nome == pet.nome);
  }

  void alternarFavorito(PetModel pet) {
    final jaExiste = isFavoritado(pet);

    if (jaExiste) {
      _petsFavoritos.removeWhere((p) => p.nome == pet.nome);
    } else {
      _petsFavoritos.add(pet);
    }

    notifyListeners();
  }
}
