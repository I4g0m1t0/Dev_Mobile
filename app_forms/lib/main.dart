import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulários e UX',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const FormExamplePage(),
    );
  }
}

// --- MÁSCARAS NATIVAS ---
class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String numeros = '';
    for (int i = 0; i < newValue.text.length; i++) {
      if ('0123456789'.contains(newValue.text[i])) numeros += newValue.text[i];
    }
    if (numeros.length > 11) numeros = numeros.substring(0, 11);

    String mascara = '';
    for (int i = 0; i < numeros.length; i++) {
      if (i == 3 || i == 6) mascara += '.';
      if (i == 9) mascara += '-';
      mascara += numeros[i];
    }
    return TextEditingValue(text: mascara, selection: TextSelection.collapsed(offset: mascara.length));
  }
}

class TelefoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String numeros = '';
    for (int i = 0; i < newValue.text.length; i++) {
      if ('0123456789'.contains(newValue.text[i])) numeros += newValue.text[i];
    }
    if (numeros.length > 11) numeros = numeros.substring(0, 11);

    String mascara = '';
    for (int i = 0; i < numeros.length; i++) {
      if (i == 0) mascara += '(';
      if (i == 2) mascara += ') ';
      if (i == 7) mascara += '-';
      mascara += numeros[i];
    }
    return TextEditingValue(text: mascara, selection: TextSelection.collapsed(offset: mascara.length));
  }
}
// ------------------------

class CadastroData {
  final String nome;
  final String email;
  final String cpf;
  final String telefone;
  final String dataNascimento;
  final String curso;
  final String senha;
  final String confirmarSenha;
  final String genero;
  final bool aceitouTermos;

  CadastroData({
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
    required this.dataNascimento,
    required this.curso,
    required this.senha,
    required this.confirmarSenha,
    required this.genero,
    required this.aceitouTermos,
  });
}

class FormExamplePage extends StatefulWidget {
  const FormExamplePage({super.key});

  @override
  State<FormExamplePage> createState() => _FormExamplePageState();
}

class _FormExamplePageState extends State<FormExamplePage> {
  // Criar GlobalKey<FormState> para controlar o formulário
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  // Criar FocusNode para cada campo de texto
  final _nomeFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _cpfFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _dataNascimentoFocus = FocusNode();
  final _senhaFocus = FocusNode();
  final _confirmarSenhaFocus = FocusNode();

  String _genero = 'Masculino';
  String _curso = 'ADS';
  bool _aceitaTermos = false;
  
  // Criar variável booleana _enviando para controlar estado
  bool _enviando = false;

  @override
  void dispose() {
    // IMPORTANTE: Fazer dispose() de todos os FocusNodes e Controllers
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _dataNascimentoController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    
    _nomeFocus.dispose();
    _emailFocus.dispose();
    _cpfFocus.dispose();
    _telefoneFocus.dispose();
    _dataNascimentoFocus.dispose();
    _senhaFocus.dispose();
    _confirmarSenhaFocus.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (data != null) {
      setState(() {
        // Preenche o controller no formato DD/MM/AAAA
        final dia = data.day.toString().padLeft(2, '0');
        final mes = data.month.toString().padLeft(2, '0');
        final ano = data.year.toString();
        _dataNascimentoController.text = '$dia/$mes/$ano';
      });
      // Move o foco para a senha após escolher a data
      _senhaFocus.requestFocus();
    }
  }

  void _enviarFormulario() async {
    // Validar todos os campos ao mesmo tempo com _formKey.currentState!.validate()
    if (!_formKey.currentState!.validate() || !_aceitaTermos) {
      // SnackBar VERMELHO com mensagem de erro se formulário inválido
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifique os campos obrigatórios e aceite os termos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Mostrar feedback visual durante envio
    setState(() => _enviando = true);
    
    // Simular envio com Future.delayed(Duration(seconds: 2))
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    setState(() => _enviando = false);

    // SnackBar VERDE com mensagem de sucesso se formulário válido
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulário enviado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );

    final dados = CadastroData(
      nome: _nomeController.text,
      email: _emailController.text,
      cpf: _cpfController.text,
      telefone: _telefoneController.text,
      dataNascimento: _dataNascimentoController.text,
      genero: _genero,
      senha: _senhaController.text,
      confirmarSenha: _confirmarSenhaController.text,
      curso: _curso,
      aceitouTermos: _aceitaTermos,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResumoPage(dados: dados)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulários e UX')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            // Usar widget Form envolvendo todos os campos
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Usar TextFormField dentro do Form
                  TextFormField(
                    controller: _nomeController,
                    focusNode: _nomeFocus,
                    decoration: const InputDecoration(labelText: 'Nome completo'),
                    textInputAction: TextInputAction.next,
                    // onSubmitted para mover foco automaticamente com requestFocus()
                    onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                    // Retornar null se válido, String com mensagem de erro se inválido
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo obrigatório';
                      // Mínimo 3 caracteres
                      if (v.length < 3) return 'O nome deve ter pelo menos 3 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _cpfFocus.requestFocus(),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo obrigatório';
                      // Validar formato de email (contains '@' e '.')
                      if (!v.contains('@') || !v.contains('.')) return 'Email inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _cpfController,
                    focusNode: _cpfFocus,
                    inputFormatters: [CpfFormatter()],
                    decoration: const InputDecoration(labelText: 'CPF'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _telefoneFocus.requestFocus(),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo obrigatório';
                      // Validar CPF (11 dígitos, que com os pontos ficam 14 caracteres)
                      if (v.length < 14) return 'O CPF deve ter 11 dígitos';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _telefoneController,
                    focusNode: _telefoneFocus,
                    inputFormatters: [TelefoneFormatter()],
                    decoration: const InputDecoration(labelText: 'Telefone com DDD'),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _dataNascimentoFocus.requestFocus(),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo obrigatório';
                      if (v.length < 14) return 'Telefone inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  // Transformado em TextFormField para passar pela validação do _formKey
                  TextFormField(
                    controller: _dataNascimentoController,
                    focusNode: _dataNascimentoFocus,
                    decoration: const InputDecoration(
                      labelText: 'Data de nascimento',
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    readOnly: true, // Usuário não digita, apenas clica
                    onTap: _selecionarData,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo obrigatório';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _senhaController,
                    focusNode: _senhaFocus,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _confirmarSenhaFocus.requestFocus(),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Campo obrigatório';
                      // Validar senha (mínimo 6 caracteres)
                      if (v.length < 6) return 'Senha deve ter no mínimo 6 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmarSenhaController,
                    focusNode: _confirmarSenhaFocus,
                    decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirme sua senha';
                      // Confirmar senha (igual ao campo senha)
                      if (v != _senhaController.text) return 'As senhas não coincidem';
                      return null;
                    },
                  ),
                  const Divider(height: 32),
                  const Text('Gênero', style: TextStyle(fontWeight: FontWeight.bold)),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Masculino'),
                    value: 'Masculino',
                    groupValue: _genero,
                    onChanged: (v) => setState(() => _genero = v!),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Feminino'),
                    value: 'Feminino',
                    groupValue: _genero,
                    onChanged: (v) => setState(() => _genero = v!),
                  ),
                  const Divider(height: 32),
                  DropdownButtonFormField<String>(
                    value: _curso,
                    decoration: const InputDecoration(labelText: 'Curso'),
                    items: const [
                      DropdownMenuItem(value: 'ADS', child: Text('ADS')),
                      DropdownMenuItem(value: 'SI', child: Text('SI')),
                      DropdownMenuItem(value: 'REDES', child: Text('REDES')),
                    ],
                    onChanged: (v) => setState(() => _curso = v!),
                  ),
                  const Divider(height: 32),
                  // Checkbox aceitar termos de uso
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Aceito os termos de uso'),
                    value: _aceitaTermos,
                    onChanged: (v) => setState(() => _aceitaTermos = v!),
                  ),
                  const SizedBox(height: 24),
                  // Mostrar CircularProgressIndicator no botão enquanto _enviando == true
                  _enviando
                      ? const Center(child: CircularProgressIndicator())
                      : FilledButton(
                          onPressed: _enviarFormulario, // Desabilitado durante o envio pela troca de widget
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Enviar Cadastro', style: TextStyle(fontSize: 16)),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResumoPage extends StatelessWidget {
  final CadastroData dados;
  const ResumoPage({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do Cadastro')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(title: const Text('Nome'), subtitle: Text(dados.nome)),
                      ListTile(title: const Text('Email'), subtitle: Text(dados.email)),
                      ListTile(title: const Text('CPF'), subtitle: Text(dados.cpf)),
                      ListTile(title: const Text('Telefone'), subtitle: Text(dados.telefone)),
                      ListTile(title: const Text('Data de nascimento'), subtitle: Text(dados.dataNascimento)),
                      ListTile(title: const Text('Gênero'), subtitle: Text(dados.genero)),
                      ListTile(title: const Text('Curso'), subtitle: Text(dados.curso)),
                      ListTile(title: const Text('Aceitou os termos'), subtitle: Text(dados.aceitouTermos ? 'Sim' : 'Não')),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}