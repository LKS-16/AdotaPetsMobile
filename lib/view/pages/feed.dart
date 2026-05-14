import 'package:adota_pets_mobile/view/modelo/pet.dart';
import 'package:adota_pets_mobile/view/widgets/app_drawer.dart';
import 'package:adota_pets_mobile/view/widgets/filtros.dart';
import 'package:adota_pets_mobile/view/widgets/pet_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  Feed({super.key});

  final List<Pet> pets = [
    Pet(
      nome: "Shadow",
      especie: "Gato",
      raca: "Black Shorthair",
      idade: "4 anos",
      endereco: "New York, NY",
      imageUrl:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=500",
      tags: ["Carinhoso", "Leal", "Calmo"],
    ),
    Pet(
      nome: "Patrasche",
      especie: "Dragão da Terra",
      raca: "Daina",
      idade: "5 anos",
      endereco: "Reino de Lugnica",
      imageUrl:
          "https://static.wikia.nocookie.net/rezero/images/6/6b/Patrasche_Anime.png/revision/latest?cb=20180731160807",
      tags: ["Docil", "Leal"],
    ),
    Pet(
      nome: "Lobinho",
      especie: "Cachorro",
      raca: "Hasky Siberiano",
      idade: "1 mês",
      endereco: "Lajedo - PE",
      imageUrl:
          "https://th.bing.com/th/id/R.b0368a3645e368c63b9486419cc918b1?rik=cAQ3N1VciHAGDQ&riu=http%3a%2f%2fperros.mascotahogar.com%2fImagenes%2fcachorro-de-husky-siberiano.jpg&ehk=yvt4v1XLjZ%2flJRSSRozMxZsJiNwQfL6BCW4nb4DeBNc%3d&risl=&pid=ImgRaw&r=0",
      tags: ["Bagunceiro", "Fofinho"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        //leading: const Icon(Icons.menu),
        title: const Text(
          "PawFinder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Encontre Seu Novo ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
      ),
    );
  }
}
