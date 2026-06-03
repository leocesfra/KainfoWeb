import 'package:flutter/material.dart';
import 'package:front/views/screens/admin_home.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isFormValid = false; // Controla si el botón está habilitado

  // Regex básico para validar email
  final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  void _validateForm() {
    setState(() {
      final emailValid = _emailRegex.hasMatch(_emailController.text);
      final passwordValid = _passwordController.text.length >= 6;
      _isFormValid = emailValid && passwordValid;
    });
  }

  Future<void> _handleLogin() async {
    if (!_isFormValid) return;

    setState(() => _isLoading = true);

    try {
      // Llamada real al backend
      final response = await http.post(
        Uri.parse(
          'http://localhost:8080/api/users/login',
        ), // Ajusta tu puerto si es necesario
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rol = data['rol']; // Recogemos el rol ("admin")

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Acceso concedido. Bienvenido $rol.',
              style: AppTypography.colorWhite.bodyLarge,
            ),
            backgroundColor: Colors.green,
          ),
        );
        // TODO: Navegar al panel de control
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
        );
      } else {
        // Error 401 (No autorizado)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email o contraseña incorrectos.',
              style: AppTypography.colorWhite.bodyLarge,
            ),
            backgroundColor: AppColors.secondaryColorDark,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error de conexión con el servidor.',
            style: AppTypography.colorWhite.bodyLarge,
          ),
          backgroundColor: AppColors.secondaryColorDark,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400, // Ancho fijo para mantener la proporción de la tarjeta
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: BoxDecoration(
              color: AppColors.secondaryColorLight, // Fondo de la tarjeta
              borderRadius: BorderRadius.circular(2), // Bordes 2px
              border: Border.all(
                color: AppColors.secondaryColorLight,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              onChanged:
                  _validateForm, // Llama a la validación en cada pulsación de tecla
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Superior
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 64,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.admin_panel_settings,
                        size: 64,
                        color: AppColors.primaryColorDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Título
                  Center(
                    child: Text(
                      'Hola, de nuevo',
                      style: AppTypography.colorBlack.headlineLarge,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Label Email
                  Text('Correo', style: AppTypography.colorBlack.headlineSmall),
                  const SizedBox(height: 8),

                  // Input Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTypography.colorBlack.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'emailejemplo@email.es',
                      hintStyle: AppTypography.colorBlack.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: AppColors.whiteColor, // Fondo blanco del input
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: AppColors.secondaryColorDark,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColorLight,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Label Contraseña
                  Text(
                    'Contraseña',
                    style: AppTypography.colorBlack.headlineSmall,
                  ),
                  const SizedBox(height: 8),

                  // Input Contraseña
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: AppTypography.colorBlack.bodyLarge,
                    decoration: InputDecoration(
                      hintText: '***********',
                      hintStyle: AppTypography.colorBlack.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: AppColors.secondaryColorDark,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColorLight,
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.secondaryColorDark,
                        ),
                        onPressed: () {
                          setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botón Acceder
                  SizedBox(
                    width: double.infinity,
                    height: 52, // Altura solicitada
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColorLight,
                        disabledBackgroundColor: AppColors.primaryColorLight
                            .withValues(
                              alpha: 0.5,
                            ), // Color apagado si es inválido
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            2,
                          ), // Borde ligeramente redondeado
                        ),
                      ),
                      // El botón es null (deshabilitado) si el form no es válido o está cargando
                      onPressed: (_isFormValid && !_isLoading)
                          ? _handleLogin
                          : null,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.whiteColor,
                                strokeWidth: 3,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.login,
                                  color: AppColors.whiteColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Acceder',
                                  style:
                                      AppTypography.colorWhite.headlineMedium,
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
