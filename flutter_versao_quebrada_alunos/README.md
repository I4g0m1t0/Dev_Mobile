# Otimização de Listas e Grids no Flutter 🚀

Este projeto demonstra na prática a diferença de performance entre a renderização de listas síncronas (*Eager Loading*) e a renderização sob demanda (*Lazy Loading*) no Flutter, focando em boas práticas para evitar travamentos e consumo excessivo de memória (RAM).

## ⚠️ O Problema

Muitas vezes, ao iniciarmos no Flutter, criamos listas e grids utilizando estruturas como `SingleChildScrollView` com `Column` ou `GridView.count`. 

O problema dessa abordagem é que o Flutter tenta construir **todos os itens e fazer o download de todas as imagens ao mesmo tempo**, mesmo que o usuário esteja vendo apenas os primeiros itens na tela. Em listas grandes (ex: 200+ itens), isso causa:
* Congelamento da interface (UI Thread bloqueada).
* Consumo altíssimo de memória RAM.
* Risco iminente de *crash* no aplicativo (*Out of Memory*).

## ✅ A Solução

A solução padrão ouro no Flutter é utilizar os construtores `.builder`, como `ListView.builder` e `GridView.builder`. 

Esses widgets são inteligentes e utilizam o conceito de **Lazy Loading**. Eles renderizam estritamente os itens que estão visíveis na tela no momento. Conforme o usuário faz o *scroll*, os itens antigos são destruídos da memória e os novos são criados, mantendo o consumo de recursos baixo e estável.

---

## 📊 Comparativo de Performance

| Métrica | ❌ Abordagem Antiga (`Column` / `.count`) | ✨ Abordagem Otimizada (`.builder`) |
| :--- | :--- | :--- |
| **Estratégia de Carregamento** | Tudo de uma vez (*Eager*) | Apenas o visível na tela (*Lazy*) |
| **Consumo de Memória (RAM)** | Altíssimo (Cresce com a lista) | Baixo e Estável |
| **Tempo de Abertura da Tela** | Lento (App pode engasgar) | Imediato |
| **Risco de Crash (OOM)** | Muito Alto | Quase Nulo |

---

## 💻 Exemplos de Código

### 1. Refatorando para `ListView.builder`
Substitui o `SingleChildScrollView` pelo builder, garantindo que o `Image.network` tenha um tamanho fixo para evitar "pulos" no *scroll*.

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 250, 
            width: double.infinity,
            child: Image.network(
              '[https://picsum.photos/800/600?random=$index](https://picsum.photos/800/600?random=$index)',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text('Item $index'),
        ],
      ),
    );
  },
)
```

# Otimização de Grids e Cache de Imagens no Flutter 🖼️⚡

Este documento detalha a refatoração de uma tela de galeria (Grid) no Flutter, saindo de uma implementação síncrona pesada para uma arquitetura escalável utilizando **Lazy Loading** e **Cache de Imagens**.

## ⚠️ O Problema: `GridView.count` e Imagens Nativas

A abordagem inicial utilizava o `GridView.count` combinado com o construtor padrão `Image.network`. Para uma lista de 200 itens, isso criava uma tempestade perfeita de problemas:

1. **Eager Loading (Carregamento Síncrono):** O `.map().toList()` forçava o Flutter a desenhar os 200 quadrados coloridos na memória antes mesmo do usuário rolar a tela.
2. **Sobrecarga de Rede:** O aplicativo disparava 200 requisições de download de imagens simultaneamente.
3. **Desperdício de Banda:** Como o `Image.network` não faz cache persistente em disco por padrão, se o usuário rolasse a tela para baixo e depois para cima, o app baixava as mesmas imagens repetidas vezes, gastando a internet do usuário.
4. **Experiência do Usuário (UX) Ruim:** Não havia nenhum indicador visual de que a imagem estava sendo carregada, deixando o layout em branco até o download terminar.

## ✅ A Solução: `GridView.builder` + `cached_network_image`

A refatoração ataca todos esses problemas em duas frentes:

### 1. Lazy Loading com `GridView.builder`
O construtor `builder` constrói sob demanda. Se a tela do celular comporta apenas 6 itens do grid, o Flutter processará apenas 6 itens. Conforme o usuário faz o scroll, os itens que saem da tela são descartados e os novos são gerados dinamicamente, mantendo o uso da memória RAM (RAM) perto de zero.

### 2. Cache e UX com `CachedNetworkImage`
Substituímos o widget nativo pelo pacote `cached_network_image`. Ele traz três vantagens matadoras:
* **Cache Automático:** Imagens baixadas são salvas no armazenamento local do celular. Se o usuário fechar o app e abrir de novo, ou simplesmente rolar a tela para cima, as imagens carregam instantaneamente sem gastar internet.
* **Placeholder:** Adicionamos um `CircularProgressIndicator()` para mostrar ao usuário que a imagem está a caminho.
* **Tratamento de Erro:** Caso o celular perca o sinal de internet no meio do download, exibimos um ícone de erro elegante em vez de quebrar o layout.

---

## 📊 Comparativo Técnico

| Métrica / Recurso | ❌ Código Antigo (`.count`) | ✨ Código Novo (`.builder` + Cache) |
| :--- | :--- | :--- |
| **Renderização** | 200 itens ao mesmo tempo | Apenas os itens visíveis na tela |
| **Uso de Dados (Internet)** | Alto (Baixa a mesma imagem várias vezes) | Otimizado (Baixa apenas 1 vez e salva) |
| **Feedback Visual (UX)** | Tela em branco até carregar | Mostra indicador de carregamento (Spinner) |
| **Desempenho (Scroll)** | Engasga devido aos downloads pesados | 100% Fluido (60fps) |
| **Tratamento de Falhas** | Silencioso / Layout quebrado | Mostra ícone de erro (`Icons.error`) |