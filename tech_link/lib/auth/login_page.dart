import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_link/auth/sign_up_page.dart';
import 'package:tech_link/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userProvider = context.read<UserProvider>();
        await userProvider.loginUser(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/logo_T.png", width: screenSize.width * 0.8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login to your account",
                      style: GoogleFonts.chakraPetch(
                        fontSize: 32,
                        color: const Color.fromARGB(255, 7, 59, 58),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Enter your credentials to access account",
                      style: GoogleFonts.chakraPetch(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 7, 59, 58),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 8,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            style: GoogleFonts.chakraPetch(
                              color: Color.fromARGB(255, 7, 59, 58),
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),

                              labelText: "Enter Email address",
                              labelStyle: GoogleFonts.chakraPetch(
                                color: const Color.fromARGB(155, 12, 49, 22),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              prefixIcon: const Icon(Icons.email),
                              prefixIconColor: Color.fromARGB(255, 7, 59, 58),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 58),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 58),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            obscureText: !_isPasswordVisible,
                            style: GoogleFonts.chakraPetch(
                              color: Color.fromARGB(255, 7, 59, 58),
                            ),

                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),

                              labelText: "Enter Your Password",
                              labelStyle: GoogleFonts.chakraPetch(
                                color: const Color.fromARGB(155, 12, 49, 22),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              prefixIcon: const Icon(Icons.password),
                              prefixIconColor: Color.fromARGB(255, 7, 59, 58),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 58),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 58),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Forget Password?",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.chakraPetch(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 7, 59, 58),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor:
                              context.watch<UserProvider>().isLoading
                                  ? Colors.grey
                                  : Color.fromARGB(255, 11, 110, 79),
                        ),
                        child: Center(
                          child:
                              context.watch<UserProvider>().isLoading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    "LOGIN",
                                    style: GoogleFonts.chakraPetch(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.chakraPetch(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            "SignUp",
                            style: GoogleFonts.chakraPetch(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 7, 59, 58),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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
}
