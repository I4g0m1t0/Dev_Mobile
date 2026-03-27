import 'package:flutter/material.dart';
import '../models/habito.dart';
import '../routes/app_routes.dart';

class ListaHabitos extends StatefulWidget {
  const ListaHabitos({super.key});

  @override
  State<ListaHabitos> createState() => _ListaHabitosState();
}

class _ListaHabitosState extends State<ListaHabitos> {
  List<Habito> habitos = [];
  bool carregando = true; // Controle para o estado de carregamento

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais(); // Chama a simulação ao iniciar a tela
  }

  // Atende ao requisito: Simular carregamento inicial usando async/await e Future.delayed
  Future<void> _carregarDadosIniciais() async {
    await Future.delayed(const Duration(seconds: 2)); // Simula atraso de rede/banco

    setState(() {
      habitos = [
        Habito(nome: 'Beber Água', descricao: 'Meta de 2L por dia'),
        Habito(nome: 'Exercícios', descricao: '30 min de caminhada'),
        Habito(nome: 'Estudar Flutter', descricao: 'Concluir o miniprojeto'),
      ];
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Hábitos')),
      
      // Exibe o loading ou a lista/mensagem de vazio
      body: carregando 
        ? const Center(child: CircularProgressIndicator()) 
        : habitos.isEmpty 
          ? const Center(child: Text('Nenhum hábito cadastrado.'))
          : ListView.builder(
              itemCount: habitos.length,
              itemBuilder: (context, index) {
                final habito = habitos[index];
                final colorScheme = Theme.of(context).colorScheme;

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withOpacity(0.2),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: habito.concluidoHoje
                          ? colorScheme.primary.withOpacity(0.1)
                          : colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.directions_run,
                        color: habito.concluidoHoje
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    title: Text(
                      habito.nome,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: habito.concluidoHoje ? TextDecoration.lineThrough : null,
                        color: habito.concluidoHoje
                            ? colorScheme.onSurface.withOpacity(0.4)
                            : colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      habito.descricao,
                      style: TextStyle(
                        decoration: habito.concluidoHoje ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: Checkbox(
                      value: habito.concluidoHoje,
                      onChanged: (bool? valor) {
                        setState(() {
                          habito.alternarConclusao();
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detalhes,
                        arguments: habito,
                      );
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final habitoRetornado = await Navigator.pushNamed(
            context,
            AppRoutes.cadastro,
          );

          if (habitoRetornado != null && habitoRetornado is Habito) {
            setState(() {
              habitos.add(habitoRetornado);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}