import 'package:flutter/material.dart';
import 'register_profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final bool _obscurePassword = true;
  final bool _obscureConfirm = true;

  bool isCheckingUser = false;
  bool usernameAvailable = true;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  final List<String> usuariosExistentes = ["vale", "admin", "test"];

  // =========================
  // INPUT STYLE (COLORES)
  // =========================
  InputDecoration customInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.green),
      filled: true,
      fillColor: Colors.green.shade50,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.green),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.green.shade100),
      ),
    );
  }

  Future<void> checkUsername(String value) async {
    setState(() => isCheckingUser = true);

    await Future.delayed(const Duration(milliseconds: 600));

    setState(() {
      usernameAvailable = !usuariosExistentes.contains(value.toLowerCase());
      isCheckingUser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3ED),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 129, 74),
        title: const Text("Registro", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: customInput("Nombre completo", Icons.person),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: emailCtrl,
                decoration: customInput("Email", Icons.email),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: usernameCtrl,
                decoration: customInput("Usuario", Icons.alternate_email),
                onChanged: checkUsername,
                validator: (_) {
                  if (!usernameAvailable) {
                    return "Usuario no disponible";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: passCtrl,
                obscureText: _obscurePassword,
                decoration: customInput("Contraseña", Icons.lock),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: confirmCtrl,
                obscureText: _obscureConfirm,
                decoration: customInput("Confirmar", Icons.lock_outline),
                validator: (v) => v != passCtrl.text ? "No coincide" : null,
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 65, 179, 122),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Siguiente"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterProfileScreen(
                          name: nameCtrl.text,
                          email: emailCtrl.text,
                          username: usernameCtrl.text,
                          password: passCtrl.text,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
