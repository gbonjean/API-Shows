import 'package:digital_paca_test/services/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: 'test-tech-dp-api_front@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '#j3apZAYBAm@Q4T2C!dQa');
  bool _isLogin = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLogin = true);
      final error = await apiService.login(
          _emailController.text, _passwordController.text);
      if (error.isNotEmpty) {
        _showError(error);
      }
      setState(() => _isLogin = false);
    }
  }

  bool _isValidEmail(input) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration getDecoration(String hint) {
      return InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: GoogleFonts.roboto(
          color: const Color(0xFFBDBDBD),
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF03A9F4),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/logo.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Se connecter :',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 28),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.75,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: getDecoration('Adresse mail'),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !_isValidEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      FractionallySizedBox(
                        widthFactor: 0.75,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: getDecoration('Mot de passe'),
                          textAlign: TextAlign.center,
                          autocorrect: false,
                          obscureText: true,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      _isLogin
                          ? const SizedBox(
                              height: 28,
                              width: 28,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : TextButton(
                              onPressed: _login,
                              child: Text(
                                'Ok',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
