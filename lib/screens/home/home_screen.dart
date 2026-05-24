import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            /// 👋 SALUDO
            const Text(
              "Bienvenido,",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "¿Que se te antoja hoy?",
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            ),

            const SizedBox(height: 25),

            /// 🔥 HERO PRINCIPAL
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B5E57), Color(0xFF2E7D6F)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Comer con \$50 hoy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Opciones económicas y nutritivas",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF1B5E57),
                    ),
                    child: const Text("Ver opciones"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

          

          

            /// 🥗 RECETA DEL DÍA
            sectionTitle("🥗 Receta del día"),
            RecipeHighlight(
              title: "Avena con fruta",
              price: "\$20",
              time: "10 min",
            ),

            const SizedBox(height: 25),

            /// 📍 CERCA DE TI
            sectionTitle("📍 Cerca de ti"),
            NearbyCard(
              title: "Tianguis local",
              subtitle: "A 5 min caminando",
            ),

            const SizedBox(height: 25),

            /// 💬 COMUNIDAD
            sectionTitle("💬 Tip de la comunidad"),
            TipCard(
              tip:
                  "Compra frutas y verduras de temporada para ahorrar más dinero 🥦",
            ),

            const SizedBox(height: 25),

            /// 🍽 MÁS RECETAS
            sectionTitle("🍽 Más recetas económicas"),
            const RecipeCard(title: "Ensalada con pollo", price: "\$45"),
            const RecipeCard(title: "Tacos de frijol", price: "\$30"),
          ],
        ),
      ),
    );
  }

  /// TITULOS
  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// 🔘 BOTONES RÁPIDOS
class QuickButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const QuickButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
              )
            ],
          ),
          child: Icon(icon, color: const Color(0xFF1B5E57)),
        ),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}

/// ⭐ RECETA DESTACADA
class RecipeHighlight extends StatelessWidget {
  final String title;
  final String price;
  final String time;

  const RecipeHighlight({
    super.key,
    required this.title,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.fastfood, size: 40),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("$price • $time"),
            ],
          )
        ],
      ),
    );
  }
}

/// 📍 LUGARES
class NearbyCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NearbyCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.red),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle),
            ],
          )
        ],
      ),
    );
  }
}

/// 💬 TIP
class TipCard extends StatelessWidget {
  final String tip;

  const TipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(tip),
    );
  }
}

/// 🍽 RECETAS LISTA
class RecipeCard extends StatelessWidget {
  final String title;
  final String price;

  const RecipeCard({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.fastfood),
          const SizedBox(width: 10),
          Text(title),
          const Spacer(),
          Text(price,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}