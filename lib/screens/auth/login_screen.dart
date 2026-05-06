import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/register_screen.dart';
import 'package:flutter_application_1/screens/auth/forgot_password_screen.dart';
import 'package:flutter_application_1/screens/navigation/main_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFDF6EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // ICONO / GIF
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 253, 171, 49),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/bague.gif',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // TITULO
              const Text(
                "Bienvenido a BuenProvecho",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Inicia sesión para continuar",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // EMAIL
              TextField(
                decoration: InputDecoration(
                  hintText: "Correo electrónico",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // PASSWORD
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // BOTON LOGIN
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 83, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    print("LOGIN FUNCIONA");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigation(),
                      ),
                    );
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // OLVIDASTE PASSWORD
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text("¿Olvidaste tu contraseña?"),
              ),

              // REGISTRO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿No tienes cuenta? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Regístrate",
                      style: TextStyle(
                        color: Color(0xFF0B5351),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}