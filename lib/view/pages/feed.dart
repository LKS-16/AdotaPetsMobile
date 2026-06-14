import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/widgets/filtros.dart';
import 'package:adota_pets_mobile/view/widgets/pet_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  Feed({super.key});

  final List<PetModel> pets = [
    PetModel(
      nome: "Shadow",
      especie: "Gato",
      raca: "Black Shorthair",
      idade: "4 anos",
      localizacao: "New York, NY",
      imageUrl:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=500",
      temperamentos: ["Carinhoso", "Leal", "Calmo"],
      porte: "Médio",
      sexo: "Macho",
      descricao: "Um gatinho muito docil.",
      vacinado: true,
      castrado: true,
      publicadoPorTipo: "ONG",
      publicadoPorEmail: "ongdeadocao.com",
      publicadoPorAvatarUrl: null,
    ),
    PetModel(
      nome: "Patrasche",
      especie: "Dragão da Terra",
      raca: "Daina",
      idade: "5 anos",
      localizacao: "Reino de Lugnica",
      imageUrl:
          "https://static.wikia.nocookie.net/rezero/images/6/6b/Patrasche_Anime.png/revision/latest?cb=20180731160807",
      temperamentos: ["Docil", "Leal"],
      sexo: "Fêmea",
      porte: "Grande",
      descricao: "Um dragão muito foda.",
      vacinado: false,
      castrado: false,
      publicadoPorTipo: "PESSOA",
      publicadoPorEmail: "barusu@gmail.com",
      publicadoPorAvatarUrl: null,
    ),
    PetModel(
      nome: "Lobinho",
      especie: "Cachorro",
      raca: "Hasky Siberiano",
      idade: "1 mês",
      localizacao: "Lajedo - PE",
      imageUrl:
          "https://th.bing.com/th/id/R.b0368a3645e368c63b9486419cc918b1?rik=cAQ3N1VciHAGDQ&riu=http%3a%2f%2fperros.mascotahogar.com%2fImagenes%2fcachorro-de-husky-siberiano.jpg&ehk=yvt4v1XLjZ%2flJRSSRozMxZsJiNwQfL6BCW4nb4DeBNc%3d&risl=&pid=ImgRaw&r=0",
      temperamentos: ["Bagunceiro", "Fofinho"],
      sexo: "Macho",
      porte: "Pequeno",
      descricao: "Um filhote super ativo e brincalhão.",
      vacinado: true,
      castrado: true,
      publicadoPorTipo: "PESSOA",
      publicadoPorEmail: "pessoa@gmail.com",
      publicadoPorAvatarUrl: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Encontre Seu Novo ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: "Melhor Amigo",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD35400),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Conheça pets adoráveis que buscam um lar para sempre",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 25),
          const FiltroAnimais(),
          const SizedBox(height: 25),
          ...pets.map((p) => PetCard(pet: p)),
        ],
      ),
    );
  }
}
