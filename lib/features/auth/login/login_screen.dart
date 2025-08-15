import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rumo/core/asset_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26, top: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetImages.logo,
                        width: 134,
                        height: 52,
                      ),
                      const Text(
                        'Memórias na',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.68,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'palma da mão.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.68,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  AssetImages.loginCharacter,
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 12),
                    child: IconButton.filled(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      color: const Color(0xFF383838),
                      icon: const Icon(Icons.chevron_left),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem vindo (a) de volta!',
                          style: TextStyle(
                            color: const Color(0xFF1E1E1E),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.20,
                            letterSpacing: -0.48,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Preencha com seus dados.',
                          style: TextStyle(
                            color: const Color(0xFF1E1E1E),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          child: Column(
                            spacing: 16,
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'E-mail',
                                ),
                                validator: (value) {
                                  final invalidEmailText =
                                      'Insira um e-mail válido';

                                  if (value == null || value.trim().isEmpty) {
                                    return invalidEmailText;
                                  }

                                  final email = value.trim();

                                  if (!email.contains('@') ||
                                      !email.contains('.')) {
                                    return invalidEmailText;
                                  }

                                  final parts = email.split('@');
                                  final firstPart = parts[0];

                                  if (firstPart.trim().isEmpty) {
                                    return invalidEmailText;
                                  }

                                  final lastPart = parts[1];

                                  if (lastPart.trim().isEmpty ||
                                      !lastPart.contains('.')) {
                                    return invalidEmailText;
                                  }

                                  if (lastPart.startsWith('.') ||
                                      lastPart.endsWith('.')) {
                                    return invalidEmailText;
                                  }

                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Senha',
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Por favor, insira uma senha';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 62),
                        SizedBox(
                          width: double.maxFinite,
                          child: FilledButton(
                            onPressed: () async {
                              final isValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (isValid) {
                                setState(() {
                                  isLoading = true;
                                });

                                await Future.delayed(Duration(seconds: 2));

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Builder(
                              builder: (context) {
                                if (isLoading) {
                                  return const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                return const Text('Entrar');
                              },
                            )
                            
                            ,
                          ),
                        ),
                        // const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Esqueci minha senha'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
