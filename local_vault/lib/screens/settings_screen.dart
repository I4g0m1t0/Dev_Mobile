import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Modo Escuro'),
            value: settings.isDarkMode,
            onChanged: (value) => settings.toggleDarkMode(value),
          ),
          
          ListTile(
            title: const Text('Idioma'),
            trailing: DropdownButton<String>(
              value: settings.language,
              items: const [
                DropdownMenuItem(value: 'Português', child: Text('Português')),
                DropdownMenuItem(value: 'Inglês', child: Text('Inglês')),
              ],
              onChanged: (newValue) {
                if (newValue != null) {
                  settings.setLanguage(newValue);
                }
              },
            ),
          ),
          
          SwitchListTile(
            title: const Text('Notificações'),
            value: settings.notificationsEnabled,
            onChanged: (value) => settings.toggleNotifications(value),
          ),
        ],
      ),
    );
  }
}