# Plano de ação — Registro de Demandas do Ensino

**Situação:** plano completo, do kickoff à v1.0.0. O escopo da v1.0.0 ainda depende das decisões da plateia (DEC-01 a DEC-04). Deploy real fica fora deste plano.

**Desenho:** [plano_de_acao.excalidraw](plano_de_acao.excalidraw). Os IDs (D, A, B, F, I, C, T, E) e os marcos (M1 a M5) são os mesmos nos dois arquivos.

**Fontes:** [user stories](user_stories.md), [requisitos funcionais](requisitos_funcionais.md), [requisitos não funcionais](requisitos_nao_funcionais.md) e [transcrição do kickoff](../meetings/kickoff_meeting/transcricao.md).

## 1. Visão geral

| Fase | O que entrega | Marco de saída |
| --- | --- | --- |
| 01 · Documentação e especificação | Escopo decidido, requisitos consolidados, diagramas, ADRs, contrato da API e backlog | **M1** · Especificação suficiente para a entrega escolhida |
| 02 · Fluxo agêntico | `AGENTS.md` raiz e por diretório, modelo de tarefa, skills e ciclo de revisão | **M2** · Agentes com contexto, limites e revisão definidos |
| 03 · Codificação | Backend, frontend e infra em trilhas paralelas, integradas por incremento | **M3** · Produto integrado rodando em Docker |
| 04 · Testes | Unitários, integração com banco real e E2E executado por uma pessoa | **M4** · Aceite humano registrado |
| 05 · Entrega da v1.0.0 | Versão reproduzível, notas de versão, tag e demonstração | **M5** · Entrega reproduzível |

Regras que valem para o plano inteiro:

1. **Decisão de produto é humana.** Uma decisão pendente (DEC-01 a DEC-04) bloqueia só as tarefas que dependem dela. O agente não preenche a lacuna por conta própria.
2. **Uma fonte por assunto.** Requisito fica em `docs/`, contrato da API em `docs/api/`, decisão técnica em `docs/adr/`. Código e documento mudam juntos.
3. **Fatia vertical primeiro.** O primeiro caso (registrar uma demanda) atravessa banco, API e tela antes de os demais casos começarem.
4. **Dados fictícios sempre** (RNF-07). Nenhum nome, foto ou relato real em seeds, testes, capturas ou slides.
5. **Pronto significa verificado.** Uma tarefa só fecha com o critério de pronto atendido e a revisão feita.

## 2. Estrutura do repositório da aplicação

Atende RT-01 a RT-05. PostgreSQL e pgAdmin usam imagens prontas; Dockerfile próprio só para frontend e backend.

```text
registro-demandas/
├── AGENTS.md                  # A01 · regras gerais para agentes
├── README.md                  # E01 · como subir, testar e usar
├── CHANGELOG.md               # E03 · notas de versão
├── docs/
│   ├── user_stories.md · requisitos_funcionais.md · requisitos_nao_funcionais.md
│   ├── decisoes.md            # D02 · respostas da plateia (DEC-01 a DEC-04)
│   ├── escopo_v1.md           # D03 · histórias selecionadas e cenário de aceite
│   ├── diagramas/             # D05–D06, B02, B03, F02 (Mermaid)
│   ├── adr/                   # D07 · decisões técnicas
│   ├── api/                   # D07 · contrato entre frontend e backend
│   ├── backlog.md             # D08 · tarefas, dependências e estimativas
│   └── testes/                # T01, T04 · matriz e roteiros E2E
├── backend/
│   ├── AGENTS.md              # A02
│   ├── Dockerfile             # I03
│   └── src/ · tests/ · migrations/
├── frontend/
│   ├── AGENTS.md              # A02
│   ├── Dockerfile             # I04
│   └── src/ · tests/
└── infra/
    ├── AGENTS.md              # A02
    ├── docker-compose.yml     # I02–I04
    └── .env.example           # I01 · valores fictícios, sem segredos
```

Esboço do Compose (portas, versões e variáveis são definidas em I02; os valores abaixo são proposta):

```yaml
services:
  db:
    image: postgres:17
    env_file: .env
    volumes: [db-data:/var/lib/postgresql/data]   # RT-05
    healthcheck: { test: ["CMD-SHELL", "pg_isready -U $${POSTGRES_USER}"] }
  pgadmin:
    image: dpage/pgadmin4
    env_file: .env
    ports: ["5050:80"]
    depends_on: [db]
  backend:
    build: ../backend        # RT-02
    env_file: .env
    depends_on: { db: { condition: service_healthy } }
    ports: ["8080:8080"]
  frontend:
    build: ../frontend       # RT-02
    ports: ["3000:3000"]
    depends_on: [backend]
volumes:
  db-data:
```

O backend acessa o banco por `db:5432`, nome do serviço na rede do Compose. O navegador acessa a API por `localhost:8080`. Essa distinção é o que RT-04 pede.

## 3. Fase 01 · Documentação e especificação

Objetivo: chegar a uma especificação que baste para construir **o escopo escolhido**, não todo o sistema institucional.

| ID | Tarefa | Entrada | Saída | Pronto quando |
| --- | --- | --- | --- | --- |
| D01 | Revisar o kickoff e os documentos iniciais | Transcrição, formulários, US, RF, RNF | Lista de dúvidas por documento | Cada dúvida aponta o trecho de origem |
| D02 | Conduzir as decisões da plateia | DEC-01 a DEC-04 | `docs/decisoes.md` | Cada DEC está decidida ou explicitamente adiada, com as dúvidas restantes |
| D03 | Consolidar o escopo da v1.0.0 | D02 | `docs/escopo_v1.md`: histórias selecionadas, adiadas e descartadas; cenário de aceite | O cenário de aceite cabe numa página e usa só histórias selecionadas |
| D04 | Atualizar histórias e requisitos | D02, D03 | US novas dos temas da plateia; RF/RNF revisados; campos obrigatórios e validações | Toda história selecionada tem RF e critério de aceite verificável |
| D05 | Diagramas de comportamento | D04 | Casos de uso (atores × casos); atividades do registro e da conclusão; estados da demanda | Cada caso de uso aponta para suas US e RF |
| D06 | Diagramas de estrutura e interação | D04, D07 | Contexto e contêineres (navegador, frontend, backend, PostgreSQL, pgAdmin); sequência de "registrar demanda" e "concluir demanda" | A sequência usa as rotas reais do contrato D07 |
| D07 | ADRs e contrato da API | D04 | `docs/adr/` (stack do back, stack do front, estilo da API, formato de erro, estratégia de migração, armazenamento de anexos); `docs/api/` com entradas, saídas e códigos de erro | Frontend e backend conseguem trabalhar só com o contrato |
| D08 | Backlog | D03 a D07 | `docs/backlog.md`: tarefas B/F/I com dependências, estimativa e responsável | Toda história selecionada tem tarefas nas três trilhas, quando aplicável |

**Diagramas da fase** (em Mermaid, em `docs/diagramas/`, para versionar junto do código):

| Diagrama | Responde | Feito em |
| --- | --- | --- |
| Casos de uso | Quem faz o quê no sistema (depende de DEC-01) | D05 |
| Atividades | Passo a passo do registro e da conclusão, com caminhos de erro | D05 |
| Estados da demanda | Aberta → concluída, e o que DEC-02/DEC-03 acrescentarem | D05 |
| Contexto e contêineres | Que peças existem e como se falam | D06 |
| Sequência | Ordem das chamadas tela → API → banco nos casos principais | D06 |
| Classes | Entidades, valores e responsabilidades do domínio | B02 |
| Entidade-relacionamento | Tabelas, chaves e restrições | B03 |
| Navegação | Telas e rotas do frontend | F02 |

**M1:** escopo da v1.0.0 registrado, requisitos das histórias selecionadas completos, diagramas D05–D06, contrato da API e backlog revisados por uma pessoa.

## 4. Fase 02 · Fluxo agêntico

Objetivo: o agente recebe contexto suficiente para executar uma tarefa sem adivinhar, e uma pessoa revisa tudo antes de integrar.

| ID | Tarefa | Saída | Pronto quando |
| --- | --- | --- | --- |
| A01 | `AGENTS.md` raiz | Objetivo do produto; mapa do repositório; fontes de verdade (`docs/`); comandos para subir e testar; regras fixas: dados fictícios, sem segredos, decisões pendentes não são preenchidas, nada é commitado sem revisão | Um agente novo responde "onde está o requisito X" e "como rodo os testes" só lendo o arquivo |
| A02 | `AGENTS.md` por diretório | `backend/`: camadas, convenções, como criar migração, como testar com banco real. `frontend/`: tokens de design, componentes, padrão de chamadas à API, mensagens. `infra/`: serviços, portas, variáveis, como recriar o ambiente | Cada arquivo tem só o que vale para o seu diretório, sem repetir a raiz |
| A03 | Modelo de tarefa | `docs/agentes/tarefa.md`: história/RF/RNF de origem; arquivos envolvidos; saída esperada; critério de pronto; o que está fora | Toda tarefa do backlog cabe no modelo |
| A04 | Skills e comandos repetíveis | Skills para ações que se repetem: criar migração, criar endpoint a partir do contrato, criar tela a partir do wireframe, revisar diff | Cada skill tem entrada, passos e verificação |
| A05 | Ciclo de revisão e integração | Uma branch por tarefa; o agente testa → uma pessoa revisa → corrige → integra na `main`. Checkouts separados (worktrees) quando houver trabalho em paralelo | O ciclo foi feito de ponta a ponta em uma tarefa pequena (ex.: I01) |

**M2:** `AGENTS.md` raiz e por diretório versionados, modelo de tarefa e skills prontos, e o ciclo de revisão testado numa tarefa real.

## 5. Fase 03 · Codificação

Três trilhas em paralelo, sincronizadas pelo contrato D07. A ordem dentro de cada trilha é a da tabela. Entre as trilhas, a regra é: **integrar o primeiro caso (C01) antes de implementar os demais**.

### 5.1 Backend

| ID | Tarefa | Saída | Pronto quando |
| --- | --- | --- | --- |
| B01 | Descobrir o domínio | Glossário do domínio; candidatas a entidades (ex.: Demanda, Pessoa envolvida, Relator, Tipo, Destino, Documento de apoio) e valores; regras e invariantes justificadas pelas histórias selecionadas | Toda entidade aponta para uma US/RF; nada existe "por precaução" |
| B02 | Modelar classes | Diagrama de classes com responsabilidades, relações e invariantes | Revisado junto com D05; regras pendentes aparecem como pendentes |
| B03 | Modelar persistência | Diagrama ER; migrações versionadas; restrições (chaves, `NOT NULL`, únicos) e limites das transações (RNF-04) | Migração sobe do zero e o ER bate com o banco |
| B04 | Preparar o projeto | Estrutura em camadas (domínio, aplicação, API, persistência); configuração por variáveis de ambiente (RNF-06); rota de saúde; formato de erro do contrato (RNF-03) | Projeto compila, testa e responde à rota de saúde dentro do Docker |
| B05 | Implementar o registro | RF-01 a RF-09 selecionados: validação no backend (RNF-05), persistência transacional, anexos conforme a ADR | Unitários das regras e integração com PostgreSQL real passando |
| B06 | Implementar o atendimento | RF-10 e o que DEC-01/02/03 definirem (permissões, histórico, destino) | Idem B05, incluindo os casos de acesso negado decididos |
| B07 | Implementar as análises | RF-11 e RF-12, se selecionados | Testes com dados de distribuição conhecida |
| B08 | Revisar e corrigir | Código, contrato, migrações e diagramas coerentes com o que foi entregue | Nenhuma divergência entre `docs/api/` e as respostas reais |

### 5.2 Frontend

| ID | Tarefa | Saída | Pronto quando |
| --- | --- | --- | --- |
| F01 | Definir padrões de design | Tokens (cores, tipografia, espaçamento); componentes base (campo, botão, mensagem, tabela, situação); estados de foco e erro (RNF-08); textos em português (RNF-03) | Situação de uma demanda continua clara sem as cores |
| F02 | Mapear telas e rotas | Diagrama de navegação. Candidatas, conforme o escopo: `/demandas/nova`, `/demandas`, `/demandas/:id`, `/indicadores`; rotas por perfil só depois de DEC-01 | Toda rota atende a uma história selecionada |
| F03 | Prototipar e revisar | Wireframes dos fluxos selecionados, com os estados carregando, vazio, sucesso e erro | Uma pessoa percorreu o protótipo do cenário de aceite |
| F04 | Preparar o projeto | Estrutura, roteamento, cliente da API gerado ou escrito a partir de D07, configuração por ambiente | Projeto sobe no Docker e mostra a rota inicial |
| F05 | Implementar o registro | Formulário de registro com pessoa envolvida, relator e ocorrência separados (RNF-02), anexos e resultado do envio (RF-02) | Funciona primeiro com dados fictícios e depois com a API real |
| F06 | Implementar o atendimento | Lista, detalhe e conclusão; o que DEC-01/02/03 definirem | Mensagens de erro da API viram textos compreensíveis |
| F07 | Implementar as análises | Indicadores por tipo e situação; recorrências, se selecionadas | Valores conferem com os dados de teste |
| F08 | Revisar e corrigir | Coerência visual, navegação por teclado, mensagens, uso no computador (RNF-01) | Revisão com teclado feita nos fluxos selecionados |

### 5.3 Infra / Docker

| ID | Tarefa | Saída | Pronto quando |
| --- | --- | --- | --- |
| I01 | Preparar a estrutura | `frontend/`, `backend/`, `infra/`; `.env.example` com valores fictícios; `.gitignore` para `.env` | Nenhum segredo versionado |
| I02 | PostgreSQL + pgAdmin | Serviços `db` e `pgadmin`, volume `db-data`, healthcheck, seed fictício | pgAdmin conecta ao banco com a configuração documentada |
| I03 | `backend/Dockerfile` | Build multi-stage; serviço `backend` construído pelo Compose; conexão com `db` | Backend aplica as migrações e responde à rota de saúde |
| I04 | `frontend/Dockerfile` | Build multi-stage; serviço `frontend` construído pelo Compose | Navegador → frontend → API → banco funcionando |
| I05 | Verificar a reprodução | `up`, `down`, `down -v` e recriação documentados; diagnóstico de problemas comuns | Dados sobrevivem a `down`/`up` e somem só com `down -v` (RT-05) |

### 5.4 Integração

| ID | Tarefa | Pronto quando |
| --- | --- | --- |
| C01 | Integrar o primeiro caso: registrar uma demanda, da tela ao banco | Cenário roda inteiro no Compose; isso libera B06/B07 e F06/F07 |
| C02 | Integrar os demais casos, um por vez | Cada caso integrado tem seus testes passando na `main` |
| C03 | Preparar a versão candidata `v1.0.0-rc.1` | Frontend + backend + PostgreSQL sobem a partir de um checkout limpo |

**M3:** cenário completo do escopo rodando em Docker, com dados de demonstração fictícios.

## 6. Fase 04 · Testes

| ID | Tarefa | Saída | Pronto quando |
| --- | --- | --- | --- |
| T01 | Matriz de rastreabilidade | `docs/testes/matriz.md`: US → RF/RNF → teste unitário, de integração ou E2E | Toda história selecionada tem ao menos um teste em cada nível aplicável |
| T02 | Testes unitários | Regras do domínio no backend; lógica relevante do frontend (validação, formatação, estados). Escritos durante B05–B07 e F05–F07 e consolidados aqui | Casos válidos, inválidos e de borda das regras selecionadas (CQ-01) |
| T03 | Testes de integração | Backend + PostgreSQL real (sem simulador, CQ-02): persistência, validação, transação com falha e reversão (RNF-04), respostas conforme o contrato (RNF-09) | Rodam por um comando documentado, dentro ou fora do Compose |
| T04 | E2E executado por uma pessoa | Roteiro em `docs/testes/e2e.md` com pré-condições, dados fictícios, passos, resultado esperado e resultado obtido; executado na interface rodando no Docker (CQ-03) | Uma pessoa executou o roteiro e registrou o resultado e as evidências |
| T05 | Corrigir | Defeito volta para a trilha responsável (B, F ou I) e repete os testes afetados. Regra não decidida volta para a especificação (D04). O escopo não é reduzido sem registro | Teste que falhou passa e não há regressão |
| T06 | Conferir aceite | Critérios do cenário de aceite (D03) e evidências conferidos | Nenhum defeito impede o cenário escolhido |

**M4:** aceite humano registrado.

## 7. Fase 05 · Entrega da v1.0.0

| ID | Tarefa | Pronto quando |
| --- | --- | --- |
| E01 | Revisar a documentação | README explica pré-requisitos, `.env`, subir, testar, acessar o pgAdmin e dados de demonstração |
| E02 | Reproduzir do zero | Outra pessoa, a partir de um checkout limpo, sobe o ambiente seguindo só o README |
| E03 | Notas de versão | `CHANGELOG.md`: o que foi entregue, limites conhecidos e o que ficou para depois |
| E04 | Marcar a versão | Código revisado na `main`, tag `v1.0.0`. Se o código mudar depois do aceite, os testes afetados e o E2E rodam de novo |
| E05 | Demonstrar | Cenário de aceite apresentado com código, documentação e execução |

**M5:** v1.0.0 entregue e reproduzível. Deploy, domínio, hospedagem e operação em produção ficam fora (CQ-05).

## 8. Dependências e caminho crítico

```text
D01 → D02 → D03 → D04 → D05/D06/D07 → D08 ─┬─ A01 → A02 → A03 → A04 → A05
                                           │
                     M1 + M2 ──────────────┼─ B01 → B02 → B03 → B04 → B05 ─┐
                                           ├─ F01 → F02 → F03 → F04 → F05 ─┼─ C01 → (B06, B07 ∥ F06, F07) → C02 → C03
                                           └─ I01 → I02 → I03 → I04 ───────┘
C03 → T01 → T02/T03 → T04 → T05? → T06 → E01 → E02 → E03 → E04 → E05
```

- **Caminho crítico:** D02 → D03 → D07 → B05 + F05 → C01 → T04 → E04. Atrasar a decisão da plateia atrasa tudo.
- **Pode começar antes de M1:** I01 e I02 (não dependem do escopo) e F01 (padrões visuais).
- **DEC-01** bloqueia casos de uso, B06, F02 (rotas por perfil) e F06. **DEC-02** bloqueia histórico e B06. **DEC-03** bloqueia o fluxo de destino. **DEC-04** bloqueia D03 e, com ele, o backlog.

## 9. Versionamento e fluxo de trabalho

- `main` sempre roda. Uma branch por tarefa (`b05-registro`, `f02-rotas`…); integração depois de revisão humana (A05).
- Commits pequenos, ligados ao ID da tarefa.
- Versões: `v0.x` durante a construção; `v1.0.0-rc.N` em C03; `v1.0.0` em E04.

## 10. Riscos

| Risco | Efeito | Resposta |
| --- | --- | --- |
| Decisões da plateia ficarem vagas | Agente inventa regra | Decisão vaga fica pendente em `decisoes.md`; a tarefa afetada espera |
| Escopo grande demais para a oficina | Nada fica pronto | D03 escolhe um cenário de aceite pequeno; o resto vai para "adiado" |
| Contrato muda durante a codificação | Front e back divergem | Mudança de contrato é tarefa própria e atualiza `docs/api/` e os consumidores |
| Ambiente não sobe em outra máquina | Entrega não reproduzível | I05 e E02 testam a partir de um checkout limpo |
| Dado real aparecer em teste ou slide | Exposição de estudantes | Seeds e roteiros só com dados fictícios; revisão antes de apresentar (RNF-07) |

## 11. Fora deste plano

Deploy real, domínio e hospedagem; integração com sistemas institucionais; importação do Forms atual; notificações e consulta da portaria enquanto não forem selecionadas em DEC-04.
