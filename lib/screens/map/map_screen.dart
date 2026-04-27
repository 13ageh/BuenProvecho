import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme/app_colors.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Mapa"),
        backgroundColor: AppColors.background,
      ),
      body: const Center(
        child: Text(
          "Aquí irá el mapa 🗺️\n(Mercados, fonditas, lugares baratos)",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}