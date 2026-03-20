import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

// Modelo de dados simples para a Tarefa
class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({required this.titulo, this.concluida = false});
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const TelaTarefas(),
    );
  }
}

class TelaTarefas extends StatefulWidget {
  const TelaTarefas({super.key});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  final List<Tarefa> _tarefas = [];

  final TextEditingController _controladorTexto = TextEditingController();

  // Função 1. Adicionar Tarefas
  void _adicionarTarefa() {
    if (_controladorTexto.text.trim().isEmpty) return;

    setState(() {
      _tarefas.add(Tarefa(titulo: _controladorTexto.text.trim()));
    });

    _controladorTexto.clear();
  }

  // Função 3. Marcar como Concluída
  void _alternarConclusao(int index, bool? valor) {
    setState(() {
      _tarefas[index].concluida = valor ?? false;
    });
  }

  // Função 4. Remover Tarefas
  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  void dispose() {
    _controladorTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Área de Input e Botão de Adicionar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controladorTexto,
                    decoration: const InputDecoration(
                      hintText: 'Digite o nome da tarefa...',
                      border: OutlineInputBorder(),
                    ),
                    // Permite adicionar também pressionando "Enter" no teclado
                    onSubmitted: (_) => _adicionarTarefa(),
                  ),
                ),
                const SizedBox(width: 16),
                // Botão para adicionar a tarefa
                FloatingActionButton(
                  onPressed: _adicionarTarefa,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // Área da Lista
          Expanded(
            child: _tarefas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma tarefa adicionada ainda.\nQue tal começar?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = _tarefas[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: tarefa.concluida,
                            onChanged: (valor) =>
                                _alternarConclusao(index, valor),
                          ),
                          title: Text(
                            tarefa.titulo,
                            style: TextStyle(
                              decoration: tarefa.concluida
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: tarefa.concluida
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removerTarefa(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
