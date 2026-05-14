import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _scoreController = TextEditingController();

  late Box<UserProfile> userBox;

  @override
  void initState() {
    super.initState();

    userBox = Hive.box<UserProfile>('userBox');
    _carregarPerfil();
  }

  void _carregarPerfil() {
    if (userBox.isNotEmpty) {
      final perfil = userBox.getAt(0);
      if (perfil != null) {
        _nameController.text = perfil.name;
        _emailController.text = perfil.email;
        _scoreController.text = perfil.score.toString();
      }
    }
  }

  void _salvarPerfil() async {
    if (_formKey.currentState!.validate()) {
      final novoPerfil = UserProfile(
        name: _nameController.text,
        email: _emailController.text,
        registrationDate: DateTime.now(),
        score: int.parse(_scoreController.text),
      );

      // O await garante que o banco apague o antigo ANTES de salvar o novo
      await userBox.clear();
      await userBox.add(novoPerfil);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil salvo com sucesso!')),
        );
      }
      setState(() {}); // Atualiza a tela
    }
  }

  void _limparDadosLGPD() async {
    // O await garante que a limpeza termine completamente antes de atualizar a tela
    await userBox.clear();
    
    _nameController.clear();
    _emailController.clear();
    _scoreController.clear();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos os dados foram apagados permanentemente.')),
      );
    }
    setState(() {}); // Atualiza a tela limpando as informações visuais
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _scoreController,
                decoration: const InputDecoration(labelText: 'Pontuação (ex: 100)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 24),
              
              ElevatedButton.icon(
                onPressed: _salvarPerfil,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Perfil'),
              ),
              const SizedBox(height: 16),
              
              const Divider(),
              const SizedBox(height: 16),
              
              // Botão LGPD de Direito ao Esquecimento
              OutlinedButton.icon(
                onPressed: _limparDadosLGPD,
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                label: const Text(
                  'Apagar meus dados (Direito ao esquecimento LGPD)', 
                  style: TextStyle(color: Colors.red)
                ),
              ),
              
              const SizedBox(height: 24),
              
              if (userBox.isNotEmpty) ...[
                const Text('Dados Salvos no Hive:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text('Nome: ${userBox.getAt(0)?.name}'),
                Text('E-mail: ${userBox.getAt(0)?.email}'),
                Text('Data de Cadastro: ${userBox.getAt(0)?.registrationDate.toString().split('.')[0]}'),
                Text('Pontuação: ${userBox.getAt(0)?.score}'),
              ]
            ],
          ),
        ),
      ),
    );
  }
}