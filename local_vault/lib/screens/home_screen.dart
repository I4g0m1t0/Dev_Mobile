import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storageService = StorageService();
  final TextEditingController _tokenController = TextEditingController();
  
  String _displayedToken = 'Nenhum token carregado';

  void _salvarToken() async {
    if (_tokenController.text.isNotEmpty) {
      await _storageService.saveToken(_tokenController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token salvo de forma segura!')),
      );
      _tokenController.clear();
    }
  }

  void _recuperarToken() async {
    final token = await _storageService.getToken();
    setState(() {
      _displayedToken = token ?? 'Nenhum token encontrado';
    });
  }

  void _deletarToken() async {
    await _storageService.deleteToken();
    setState(() {
      _displayedToken = 'Token deletado';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Token excluído do armazenamento!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Vault'),
        actions: [
          // Adicione este botão de Perfil
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          // Botão de engrenagem que já estava aí
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Área Segura (Token)', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Campo de texto para o Token
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'Digite um token fictício',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Botões de ação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _salvarToken, 
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: _recuperarToken, 
                  child: const Text('Recuperar'),
                ),
                ElevatedButton(
                  onPressed: _deletarToken,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Deletar'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Área para exibir o token recuperado
            const Text(
              'Status do Token:', 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_displayedToken),
            ),
          ],
        ),
      ),
    );
  }
}