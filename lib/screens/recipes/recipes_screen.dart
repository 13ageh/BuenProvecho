import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme/app_colors.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Recetas para ti 🥗"),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            "Sugerencias basadas en tu presupuesto",
            style: TextStyle(color: Color(0xFF0B5351)),
          ),

          SizedBox(height: 16),

          RecipeCard(
            title: "Avena con fruta",
            price: "\$20",
            time: "10 min",
            image:
                "https://images.unsplash.com/photo-1517673400267-0251440c45dc",
            isRecommended: true,
          ),

          RecipeCard(
            title: "Ensalada con pollo",
            price: "\$45",
            time: "20 min",
            image: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
          ),

          RecipeCard(
            title: "Tostadas saludables",
            price: "\$30",
            time: "15 min",
            image:
                "https://images.unsplash.com/photo-1490645935967-10de6ba17061",
            isRecommended: true,
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String price;
  final String time;
  final String image;
  final bool isRecommended;

  const RecipeCard({
    super.key,
    required this.title,
    required this.price,
    required this.time,
    required this.image,
    this.isRecommended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              /// 📸 IMAGEN SEGURA
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,

                  /// 🔄 LOADING
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[100],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },

                  /// ❌ ERROR
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                        size: 35,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              /// 📄 INFO
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "$price • $time",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              /// ❤️ FAVORITO
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
