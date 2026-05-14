# Local Vault - Atividade de Armazenamento Local

**Aluno:** Iago Rech Tramontin
**Descrição:** Aplicativo Flutter desenvolvido para demonstrar na prática diferentes métodos de persistência de dados locais, aplicando boas práticas e conceitos de privacidade (LGPD).

---

## 🛠️ Justificativas Técnicas de Armazenamento

**1. Por que foi escolhido SharedPreferences para configurações?** O SharedPreferences é a ferramenta ideal para armazenar configurações simples (como preferências de tema e idioma). Ele salva os dados no formato chave-valor (ex: `isDarkMode: true`) de forma leve e rápida. Como configurações de interface não são dados sensíveis ou complexos, usar um banco de dados completo para isso seria um exagero.

**2. Por que foi escolhido Hive para o perfil do usuário?** O perfil do usuário contém dados mais estruturados (Nome, E-mail, Data, Pontuação). O Hive é um banco de dados NoSQL local extremamente rápido que permite salvar "Objetos" inteiros do Dart nativamente. Ele facilita a organização e recuperação de modelos de dados complexos em comparação ao SharedPreferences, que exigiria converter tudo para texto (JSON) antes de salvar.

**3. Por que foi escolhido flutter_secure_storage para o token?** Tokens de autenticação são dados sensíveis. Se alguém tiver acesso aos arquivos do celular, poderia roubar o token e se passar pelo usuário. O `flutter_secure_storage` resolve isso criptografando os dados usando a segurança nativa do próprio sistema operacional (Keystore no Android e Keychain no iOS), garantindo que apenas o aplicativo tenha acesso àquela informação legível.

---

## 🚀 Como rodar o projeto

1. Clone o repositório.
2. Abra o terminal na pasta do projeto e baixe as dependências:
```
   flutter pub get
```

3. Gere o arquivo do adaptador do Hive (necessário para o modelo UserProfile):
```
dart run build_runner build --delete-conflicting-outputs

```


4. Execute o aplicativo (pode ser rodado no Chrome/Edge para testes rápidos ou no emulador Android/iOS):
```
flutter run
```

---

## 🔒 Reflexão: LGPD e Privacidade

**Se este app fosse publicado na Play Store, quais dados ele estaria coletando e armazenando?** O aplicativo estaria coletando dados de preferência de uso (tema, idioma), dados de identificação pessoal (Nome e E-mail) e dados de engajamento (Data de Cadastro e Pontuação). Além disso, guardaria um Token de Autenticação para acesso a serviços externos.

**Como você garantiria que o usuário está ciente disso e pode excluir seus dados?** Para garantir a ciência do usuário conforme a LGPD, o aplicativo deveria exibir uma **Política de Privacidade e Termos de Uso** logo no primeiro acesso, exigindo um consentimento explícito (opt-in) antes de salvar o Perfil.

Para a exclusão, garanti o **Direito ao Esquecimento** (Art. 18 da LGPD) disponibilizando um botão claro e acessível na tela de Perfil ("Apagar meus dados"). Ao clicar neste botão, o app executa o método `userBox.clear()`, que apaga os registros do banco de dados local permanentemente, sem deixar rastros.

---

## 📸 Capturas de Tela

![Video](/local_vault/screenshots/vid.gif)