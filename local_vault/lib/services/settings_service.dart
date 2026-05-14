import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// O ChangeNotifier permite que o app "escute" quando alguma configuração mudar
class SettingsService extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'Português';
  bool _notificationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;

  SettingsService() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _language = prefs.getString('language') ?? 'Português';
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    
    // Avisa o app que os dados terminaram de carregar para atualizar a tela
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value); 
    notifyListeners(); // Atualiza a tela
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', value); 
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    notifyListeners();
  }
}