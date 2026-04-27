import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
            ),

            const SizedBox(height: 10),

            const Text("Valeria",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Recetas favoritas"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}