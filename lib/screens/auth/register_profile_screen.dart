import 'package:flutter/material.dart';

class RegisterProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String username;
  final String password;

  const RegisterProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  State<RegisterProfileScreen> createState() =>
      _RegisterProfileScreenState();
}

class _RegisterProfileScreenState
    extends State<RegisterProfileScreen> {
  String? selectedAvatar;

  // =========================
  // AVATAR GRANDE
  // =========================
  Widget avatarPreview() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => avatarSelector(),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: const Color.fromARGB(255, 245, 205, 195),
            child: selectedAvatar == null
                ? const Icon(Icons.person,
                    size: 70, color: Color(0xFFBA2D0B))
                : Text(
                    selectedAvatar!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 150, 64, 6),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Escoge tu avatar",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF0B5351),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // SELECTOR DE AVATARES
  // =========================
  Widget avatarSelector() {
    final avatars = List.generate(10, (i) => "A${i + 1}");

    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        itemCount: avatars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final id = avatars[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatar = id;
              });
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 35,
              backgroundColor: const Color.fromARGB(255, 167, 212, 197),
              child: Text(
                id,
                style: const TextStyle(color: Color.fromARGB(255, 13, 126, 90)),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3ED),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5351),
        title: const Text(
          "Completa tu perfil",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // =========================
            // AVATAR
            // =========================
            avatarPreview(),

            const SizedBox(height: 40),

            // =========================
            // BOTÓN
            // =========================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBB13C),
                foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text("Finalizar registro"),
              onPressed: () {
                final user = {
                  "name": widget.name,
                  "email": widget.email,
                  "username": widget.username,
                  "password": widget.password,
                  "avatar": selectedAvatar,
                };

                print(user);

                Navigator.pushReplacementNamed(context, "/home");
              },
            )
          ],
        ),
      ),
    );
  }
}