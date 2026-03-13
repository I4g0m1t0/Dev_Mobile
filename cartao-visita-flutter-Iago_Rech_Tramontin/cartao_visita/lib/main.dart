import 'package:flutter/material.dart';

void main() {
  runApp(const CartaoVisita());
}

class CartaoVisita extends StatelessWidget {
  const CartaoVisita({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cartão de Visita',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 8. Scaffold para estrutura básica
      appBar: AppBar(
        title: const Text("Meu Cartão de Visita"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // 9. Container com Column
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajusta o tamanho ao conteúdo
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 10. Elementos estilizados
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20), // Espaçamento
              const Text(
                "Iago Rech Tramontin",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const Text(
                "Desenvolvedor Protheus ADVPL",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  letterSpacing: 1.5,
                ),
              ),
              const Divider(height: 30, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.email, color: Colors.indigo),
                  SizedBox(width: 10),
                  Text("iagorechtramontin@gmail.com", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.indigo),
                  SizedBox(width: 10),
                  Text("(47) 99904-0362"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}