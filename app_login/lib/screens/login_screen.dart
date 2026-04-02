import 'package:flutter/material.dart';
import '../models/user.dart';
import '../routes/routes.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // --- O "BANCO DE DADOS" TEMPORÁRIO ---
  // Criamos uma lista vazia que vai guardar todos os objetos User cadastrados
  final List<User> _usuariosCadastrados = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Multi-Usuário'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.group, size: 80, color: colorScheme.primary),
                const SizedBox(height: 32),

                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    // --- BOTÃO DE LOGIN ---
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final email = _emailController.text.trim();
                          final senha = _senhaController.text.trim();

                          if (email.isEmpty || senha.isEmpty) {
                            _mostrarErro("Preencha todos os campos!");
                            return;
                          }

                          // LÓGICA DE BUSCA NA LISTA:
                          // "Existe algum usuário na lista onde o email E a senha batem?"
                          try {
                            final usuarioEncontrado = _usuariosCadastrados
                                .firstWhere(
                                  (user) =>
                                      user.email == email &&
                                      user.senha == senha,
                                );

                            // 2. Se o código chegou aqui, é porque encontrou o usuário!
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.home,
                              (route) => false,
                              arguments: usuarioEncontrado.nome, // Enviando o nome real encontrado!
                            );
                          } catch (e) {
                            // 3. Se cair no catch, é porque o 'firstWhere' não achou ninguém
                            _mostrarErro(
                              "Usuário não encontrado ou senha incorreta!",
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // --- BOTÃO CRIAR CONTA ---
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          // Espera o novo usuário vir da tela de cadastro
                          final novo = await Navigator.pushNamed(
                            context,
                            AppRoutes.cadastro,
                          );

                          if (novo != null && novo is User) {
                            setState(() {
                              // ADICIONA na lista em vez de substituir
                              _usuariosCadastrados.add(novo);

                              // Opcional: já preenche os campos para o usuário
                              _emailController.text = novo.email;
                              _senhaController.text = novo.senha;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Usuário ${novo.nome} cadastrado!',
                                ),
                              ),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Cadastrar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Apenas para você debugar: mostra quantos usuários existem
                Text(
                  "Usuários na memória: ${_usuariosCadastrados.length}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarErro(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }
}
