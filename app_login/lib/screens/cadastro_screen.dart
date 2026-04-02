import 'package:flutter/material.dart';
import '../models/user.dart';

class CadastroUser extends StatefulWidget {
  const CadastroUser({super.key});

  @override
  State<CadastroUser> createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    double larguraDaTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Usuário'), centerTitle: true),
      body: SingleChildScrollView(
        // Evita erro de teclado cobrindo a tela
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            width: larguraDaTela * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ícone decorativo no topo
                Icon(Icons.person, size: 80, color: colorScheme.primary),
                const SizedBox(height: 32),

                // Campo Nome
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Informe seu Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true, // Dá um leve fundo ao campo
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Descrição
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Informe seu Email',
                    hintText: 'Ex: algumacoisa@email.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: 'Informe sua Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),

                // Botão Salvar Estilizado
                ElevatedButton(
                  onPressed: () {   
                    final nome = _nomeController.text;
                    final email = _emailController.text;
                    final senha = _senhaController.text;

                    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
                      // Exibe um aviso na parte de baixo da tela
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, preencha todos os campos!'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return; // Para a execução aqui e não fecha a tela
                    }

                    if (!email.contains('@')) {
                      // Exibe um aviso na parte de baixo da tela
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Digite um email válido'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return; // Para a execução aqui e não fecha a tela
                    }

                    final novoUsuario = User(
                      nome: nome,
                      email: email,
                      senha: senha,
                    );
                    Navigator.pop(context, novoUsuario);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Salvar Usuário',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
