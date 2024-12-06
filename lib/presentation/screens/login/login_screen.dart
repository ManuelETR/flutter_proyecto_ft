import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/screens/home/home_screen.dart';
import 'package:flutter_proyecto_ft/presentation/screens/login/sign_screen.dart';
import 'package:flutter_proyecto_ft/services/auth_service.dart';
import 'package:flutter_proyecto_ft/widgets/login/form_cointainer.dart';
import 'package:flutter_proyecto_ft/widgets/login/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {


  static const String name = "login_screen";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoggingIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const SizedBox(height: 50), // Espacio adicional arriba de la imagen
                Container(
                  width: 330,
                  height: 280,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/LogoF.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 32, 
                    fontWeight: FontWeight.bold
                    ),
                ),
                const SizedBox(height: 30),
                // Campo de correo electrónico
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Correo Electrónico",
                  isPasswordField: false,
                ),
                const SizedBox(height: 10),
                // Campo de contraseña
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Contraseña",
                  isPasswordField: true,
                ),
                const SizedBox(height: 30),
                // Botón de iniciar sesión con correo y contraseña
                GestureDetector(
                  onTap: () {
                    _logIn();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isLoggingIn
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Ingresar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Opción para iniciar sesión con Google
                GestureDetector(
                  onTap: _signInWithGoogle,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.google, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "Iniciar sesión con Google",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Enlace para ir al registro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿No tienes una cuenta?"),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(SignUpPage.name);
                      },
                      child: const Text(
                        "Registrarse",
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
      ),
    );
  }

  void _logIn() async {
    setState(() {
      isLoggingIn = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showToast(message: "Por favor completa todos los campos.");
      setState(() {
        isLoggingIn = false;
      });
      return;
    }

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        showToast(message: "Inicio de sesión exitoso");
        // Navegar a la pantalla principal
        context.goNamed(HomeScreen.name); // Aquí HomeScreen.name es el nombre de la ruta de la pantalla de inicio
      }
    } catch (e) {
      showToast(message: "Error: ${e.toString()}");
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  // Función para iniciar sesión con Google
  void _signInWithGoogle() async {
    setState(() {
      isLoggingIn = true;
    });

    try {
      User? user = await _auth.signInWithGoogle();
      if (user != null) {
        showToast(message: "Inicio de sesión exitoso con Google");
        // Navegar a la pantalla principal
        context.goNamed(HomeScreen.name);
      }
    } catch (e) {
      showToast(message: "Error al iniciar sesión con Google: ${e.toString()}");
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }
}
