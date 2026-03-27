import 'package:app_habits/models/habito.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalheHabito extends StatelessWidget {
  final Habito habito;

  const DetalheHabito({super.key, required this.habito});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Hábito'),
        backgroundColor: colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header com Ícone e Nome
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: habito.concluidoHoje 
                        ? colorScheme.primary 
                        : colorScheme.primaryContainer.withOpacity(0.3),
                    child: Icon(
                      Icons.directions_run, 
                      size: 40, 
                      color: habito.concluidoHoje ? colorScheme.onPrimary : colorScheme.primary
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    habito.nome,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            // Card de Informações
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Status de Conclusão
                    _buildInfoRow(
                      context,
                      icon: habito.concluidoHoje ? Icons.check_circle : Icons.radio_button_unchecked,
                      label: 'Status',
                      value: habito.concluidoHoje ? 'Concluído' : 'Pendente',
                      valueColor: habito.concluidoHoje ? Colors.greenAccent : colorScheme.error,
                    ),
                    const Divider(height: 30),
                    
                    // Descrição
                    _buildInfoRow(
                      context,
                      icon: Icons.description_outlined,
                      label: 'Descrição',
                      value: habito.descricao.isEmpty ? 'Sem descrição' : habito.descricao,
                    ),
                    const Divider(height: 30),

                    // Data
                    _buildInfoRow(
                      context,
                      icon: Icons.calendar_today_outlined,
                      label: 'Criado em',
                      value: DateFormat("dd/MM/yyyy").format(habito.criadoEm),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para criar as linhas de informação bonitinhas
  Widget _buildInfoRow(BuildContext context, 
      {required IconData icon, required String label, required String value, Color? valueColor}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colorScheme.primary, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}