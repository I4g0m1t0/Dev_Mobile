import 'package:flutter/material.dart';
import '../models/habito.dart';

class CadastroHabito extends StatefulWidget {
  const CadastroHabito({super.key});

  @override
  State<CadastroHabito> createState() => _CadastroHabitoState();
}

class _CadastroHabitoState extends State<CadastroHabito> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Hábito'), centerTitle: true),
      body: SingleChildScrollView(
        // Evita erro de teclado cobrindo a tela
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ícone decorativo no topo
            Icon(Icons.edit_calendar, size: 80, color: colorScheme.primary),
            const SizedBox(height: 32),

            // Campo Nome
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'O que você quer praticar?',
                hintText: 'Ex: Beber água, Academia...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true, // Dá um leve fundo ao campo
              ),
            ),
            const SizedBox(height: 20),

            // Campo Descrição
            TextField(
              controller: _descController,
              maxLines: 3, // Permite que o campo seja maior
              decoration: InputDecoration(
                labelText: 'Descrição ou Meta',
                hintText: 'Ex: 2 litros por dia',
                alignLabelWithHint:
                    true, // Alinha o label no topo em campos multiline
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 40),

            // Botão Salvar Estilizado
            ElevatedButton(
              onPressed: () {
                final nome = _nomeController.text;
                final desc = _descController.text;

                final novoHabito = Habito(nome: nome, descricao: desc);
                Navigator.pop(context, novoHabito);
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
                'Salvar Hábito',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
