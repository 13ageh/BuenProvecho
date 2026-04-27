import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme/app_colors.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Foro"),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ForumPost(
            "¿Qué desayunan con 30?",
            "Busco ideas saludables y baratas",
          ),
          ForumPost(
            "Recetas para la semana",
            "Compartan sus meal prep 🙏",
          ),
        ],
      ),
    );
  }
}

class ForumPost extends StatelessWidget {
  final String title;
  final String content;

  const ForumPost(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(content),
        ],
      ),
    );
  }
}