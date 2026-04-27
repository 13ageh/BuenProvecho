import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [

              // 👋 SALUDO
              const Text(
                "Hola 👋",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text(
                "¿Lista para comer mejor hoy?",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // 🔍 BUSCADOR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Buscar recetas o lugares...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 💡 ACCESOS RÁPIDOS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  QuickButton(icon: Icons.restaurant, text: "Recetas"),
                  QuickButton(icon: Icons.map, text: "Mapa"),
                  QuickButton(icon: Icons.forum, text: "Foro"),
                ],
              ),

              const SizedBox(height: 25),

              // 💸 SECCIÓN PRESUPUESTO
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1B5E57),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Comer con 50",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 5),
                    Text("Ideas económicas y saludables",
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 🥗 RECETAS
              const Text(
                "Recetas recomendadas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const RecipeCard(title: "Ensalada con pollo", price: "\$45"),
              const RecipeCard(title: "Avena con fruta", price: "\$20"),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const QuickButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: Color(0xFF1B5E57)),
        ),
        const SizedBox(height: 5),
        Text(text)
      ],
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String price;

  const RecipeCard({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(price),
            ],
          )
        ],
      ),
    );
  }
}