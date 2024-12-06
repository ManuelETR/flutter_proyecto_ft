
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/screens/login/login_screen.dart';
import 'package:flutter_proyecto_ft/services/auth_service.dart';
import 'package:flutter_proyecto_ft/widgets/login/form_cointainer.dart';
import 'package:flutter_proyecto_ft/widgets/login/toast.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {

  static const String name = "sign_screen";
  
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Registro",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              FormContainerWidget(
                controller: _usernameController,
                hintText: "Nombre de usuario",
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Correo electrónico",
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Contraseña",
                isPasswordField: true,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                controller: _confirmPasswordController,
                hintText: "Confirmar contraseña",
                isPasswordField: true,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _signUp();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isSigningUp
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿Ya tienes una cuenta?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(LoginPage.name);
                    },
                    child: const Text(
                      "Iniciar sesión",
                      style: TextStyle(
                          color: Color(0xFFb40506),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
  setState(() {
    isSigningUp = true;
  });

  String username = _usernameController.text.trim();
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();
  String confirmPassword = _confirmPasswordController.text.trim();

  if (username.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    showToast(message: "Por favor completa todos los campos.");
    setState(() {
      isSigningUp = false;
    });
    return;
  }

  if (password != confirmPassword) {
    showToast(message: "Las contraseñas no coinciden.");
    setState(() {
      isSigningUp = false;
    });
    return;
  }

  if (password.length < 6) {
    showToast(message: "La contraseña debe tener al menos 6 caracteres.");
    setState(() {
      isSigningUp = false;
    });
    return;
  }

  try {
    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      // Puedes guardar el nombre de usuario en Firestore u otra base de datos aquí.
      showToast(message: "El usuario se ha creado exitosamente.");
      // Navegar a la pantalla de login y limpiar la pila de navegación
      context.goNamed(LoginPage.name);  // Aquí LoginPage.name es el nombre de la ruta de la pantalla de login
    } else {
      showToast(message: "Error al crear el usuario.");
    }
  } catch (e) {
    showToast(message: "Error: ${e.toString()}");
  } finally {
    setState(() {
      isSigningUp = false;
    });
  }
}
}