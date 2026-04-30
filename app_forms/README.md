# 📝 App de Formulários e UX em Flutter

Um aplicativo desenvolvido em Flutter focado nas melhores práticas de criação de formulários e **Experiência do Usuário (UX)**. O projeto demonstra como gerenciar estados, aplicar formatações (máscaras) nativas, validar dados complexos e fornecer feedback visual intuitivo sem depender de pacotes de terceiros.

## ✨ Funcionalidades Implementadas

* **Validação Completa de Formulário:** Utilização de `Form` e `GlobalKey<FormState>` para validar múltiplos campos simultaneamente.
* **Máscaras Nativas (Sem Regex/Pacotes):** Implementação customizada de `TextInputFormatter` para aplicar máscaras de CPF (`###.###.###-##`) e Telefone (`(##) #####-####`) em tempo real.
* **Gerenciamento Inteligente de Foco:** Uso de `FocusNode` e `TextInputAction.next` para permitir que o usuário navegue fluidamente entre os campos usando o botão "Avançar" do teclado.
* **Feedback Visual Avançado:**
    * Integração de **SnackBars** para sucesso (verde) e erro (vermelho).
    * Estado de carregamento (Loading) simulado com `CircularProgressIndicator` no botão de envio, prevenindo múltiplos cliques indesejados.
* **Campos de Data com Validação:** Uso do `showDatePicker` acoplado a um `TextFormField` (modo *readOnly*) para garantir que a data entre no fluxo de validação obrigatória.
* **Múltiplos Tipos de Inputs:**
    * Text fields clássicos (Nome, Email, Senha).
    * Inputs formatados (CPF, Telefone).
    * Radio Buttons (Gênero).
    * Dropdown Menu (Cursos).
    * Checkbox (Termos de Uso).
* **Design Responsivo:** Formulário encapsulado em um `Container` centralizado com `BoxConstraints(maxWidth: 600)`, garantindo uma visualização elegante como um "Card" em telas grandes (Web/Desktop) ou mobile.
* **Tela de Resumo:** Navegação via `MaterialPageRoute` para uma página de resumo (`ResumoPage`) renderizando os dados aprovados em formato de lista.

## ✅ Requisitos Técnicos Atendidos

- [x] Uso de `Form` e `GlobalKey<FormState>`.
- [x] Mínimo de 8 campos com validações específicas:
  - **Nome:** Obrigatório, mínimo de 3 caracteres.
  - **Email:** Obrigatório, deve conter `@` e `.`.
  - **CPF:** Obrigatório, validação de tamanho (14 caracteres com máscara).
  - **Telefone:** Obrigatório, validação de tamanho (mínimo 14 caracteres com DDD).
  - **Data de Nascimento:** Obrigatório, seleção via calendário gerando formato `DD/MM/AAAA`.
  - **Senha:** Obrigatório, mínimo de 6 caracteres, campo ofuscado (`obscureText`).
  - **Confirmar Senha:** Obrigatório, validação cruzada para garantir que seja igual à Senha.
  - **Termos de Uso:** Checkbox obrigatório.
- [x] Navegação inteligente com `FocusNode` e descarte correto de memória (`dispose()`).
- [x] Validadores customizados retornando mensagens de erro claras (`String`) ou sucesso (`null`).
- [x] `ScaffoldMessenger` exibindo SnackBars com cores de contexto (Sucesso/Erro).
- [x] Bloqueio de envio múltiplo através da variável de estado `_enviando` atrelada à interface.

## 🛠️ Tecnologias Utilizadas

* **Flutter:** Framework UI toolkit.
* **Dart:** Linguagem de programação.
* Nenhum pacote de terceiros adicionado (100% nativo).

## 🚀 Como Executar o Projeto

1. Certifique-se de ter o [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
2. Clone este repositório.
3. Abra o terminal na pasta do projeto e execute:
   ```bash
   flutter pub get
   ```
4. Para rodar o aplicativo (em um emulador, dispositivo físico ou no Chrome), execute:
   ```bash
   flutter run
   ```