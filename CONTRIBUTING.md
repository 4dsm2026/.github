# Como contribuir — WorkFlow FATEC

Este guia vale para **todos os repositórios** da organização [4dsm2026](https://github.com/4dsm2026). Ele substitui os guias que estavam copiados em cada repositório (`CONTRIBUTING.md` do backend e do frontend e `good_practices/Criar_issues.md` da documentação).

O objetivo é que qualquer pessoa — do time ou o professor — consiga responder, olhando só o GitHub:

- **o que** está sendo feito e **por quê** (issue);
- **quem** está fazendo (responsável da issue / autor do PR);
- **qual código** resolveu cada issue (PR vinculado);
- **o que foi entregue em cada sprint** (milestone + tag/release).

---

## 1. Repositórios

| Repositório | Conteúdo |
|---|---|
| [`backend_fatecProjeto`](https://github.com/4dsm2026/backend_fatecProjeto) | API — Fastify, Prisma, MySQL |
| [`frontend_fatecProjeto`](https://github.com/4dsm2026/frontend_fatecProjeto) | Interface web — Next.js |
| [`docs_fatecProjeto`](https://github.com/4dsm2026/docs_fatecProjeto) | Documentação (Docusaurus), publicada em <https://4dsm2026.github.io/docs_fatecProjeto/> |
| [`test_fatecProjeto`](https://github.com/4dsm2026/test_fatecProjeto) | Testes de ponta a ponta (Selenium + pytest) |
| [`.github`](https://github.com/4dsm2026/.github) | Este guia, modelos de issue/PR e a página da organização |

> ⚠️ Use sempre `pnpm` no backend e no frontend, nunca `npm`.

---

## 2. Fluxo de trabalho

```text
Issue  →  Branch  →  Pull Request  →  Revisão  →  develop  →  (fim da sprint)  →  main + tag
```

1. **Toda mudança começa com uma issue.** Se não existe, crie uma usando os modelos (seção 4).
2. Atribua-se como **responsável** (*Assignees*) antes de começar. No [quadro do projeto](https://github.com/orgs/4dsm2026/projects), coloque a issue na **Sprint** atual e mova o **Status** conforme avança.
3. Crie a branch a partir de `develop` (seção 3).
4. Abra o Pull Request para `develop` preenchendo o modelo — principalmente o campo **Issue** (seção 5).
5. Após a aprovação e o merge, a issue é fechada pelo PR (não feche manualmente).
6. No fim da sprint, `develop` é integrada em `main` e recebe uma tag de versão (seção 6).

---

## 3. Branches

| Branch | Uso |
|---|---|
| `main` | O que foi entregue. Só recebe PR vindo de `develop`. Protegida. |
| `develop` | Integração da sprint. Recebe os PRs do dia a dia. Protegida. |
| `<tipo>/issue-<número>-<descrição>` | Trabalho de uma issue. Ex.: `fix/issue-47-auth-imports`, `feat/issue-79-caixa-sugestoes` |

No backend e no frontend, `develop` é a branch padrão: ao clonar ou abrir um PR, o GitHub já usa `develop`. Os repositórios `docs_fatecProjeto` e `test_fatecProjeto` não têm `develop` — neles os PRs vão direto para `main`.

Tipos de branch: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `security`.

Branches de equipe (ex.: `Novas-Funcionalidades_2`) podem ser usadas para integrar o trabalho de um time, mas o PR que leva essa branch para `develop` deve listar **todas** as issues que ela resolve.

Apague a branch depois do merge.

---

## 4. Issues

### Título

```text
[Tipo] Descrição curta e objetiva
```

Exemplo: `[Security] Corrigir senha hardcoded em crypto.ts`

### Modelos

Ao clicar em **New issue**, escolha um dos modelos:

- **Bug** — comportamento incorreto.
- **Nova funcionalidade** — história de usuário com critérios de aceite.
- **Tarefa técnica** — Fix, Refactor, Test, Style, Cleanup, Docs, A11y ou Security.

### As 4 labels (nesta ordem)

Toda issue precisa de **4 labels**. Nenhuma pode ser pulada — se ainda não souber, use `team:undefined`.

**1ª — Prioridade**

| Label | Quando usar |
|---|---|
| `priority:critical` | Sistema quebrado, dado exposto, vulnerabilidade ativa — tratar **agora** |
| `priority:high` | Impacta funcionalidade importante ou segurança, mas não é incêndio |
| `priority:medium` | Deve ser corrigido no próximo ciclo, mas não bloqueia ninguém |
| `priority:low` | Cosmético, débito técnico, "seria bom ter" |

**2ª — Tipo** (igual à tag do título)

| Label | Significado |
|---|---|
| `[Security]` | Vulnerabilidade, segredo exposto, falha de autenticação/autorização |
| `[Bug]` | Comportamento incorreto no sistema |
| `[Fix]` | Correção pontual (import quebrado, config errada) que não é bug de comportamento |
| `[Refactor]` | Melhoria interna de código, sem mudar comportamento externo |
| `[A11y]` | Acessibilidade |
| `[Test]` | Cobertura, correção ou configuração de testes automatizados |
| `[Style]` | CSS, espaçamento, visual — sem impacto funcional |
| `[Cleanup]` | Código morto, variável não usada, código obsoleto |
| `[Feature]` | Nova funcionalidade |
| `[Docs]` | Documentação |

**3ª e 4ª — Equipe criadora → equipe responsável**

| Label | Equipe |
|---|---|
| `team:qa` | Qualidade / Revisão |
| `team:novas-funcs-1` | Novas Funcionalidades I |
| `team:novas-funcs-2` | Novas Funcionalidades II |
| `team:refatoracao` | Refatoração |
| `team:ux-ui` | UX / UI |
| `team:docs-devops` | Documentação / DevOps |
| `team:undefined` | Ainda não triado — usar só temporariamente |

Quando a equipe responsável mudar, **troque a label**.

### Regras de ouro

1. **Uma issue, um problema.** Se o título tem "e" ligando dois problemas, são duas issues (ou uma issue principal com sub-issues).
2. **Título curto, corpo detalhado.** Contexto, critérios de aceite e arquivos afetados vão no corpo.
3. **Duplicada ou inválida:** mantenha o título e adicione `duplicate` ou `invalid`.
4. **Problemas em lote** (ex.: 73 botões sem `type`): crie uma **issue principal** com as seções `## Contexto`, `## Arquivos afetados` e `## Critério de aceite`, e use *Sub-issues* do GitHub para cada ocorrência. Cada sub-issue tem suas próprias 4 labels.
5. **Funcionalidade que envolve backend e frontend:** uma issue em cada repositório, uma citando a outra (`4dsm2026/backend_fatecProjeto#79`).

---

## 5. Pull Requests

- **Título** no padrão de commit (seção 7). Ex.: `feat(sugestoes): adiciona editor com texto formatado`. O check **PR / Título e label do PR** confere o título e aplica sozinho a label de tipo (`feat` → `[Feature]`, `fix` → `[Fix]`, …). Essas labels organizam as notas da release.
- **Vincule a issue** no corpo do PR com uma palavra-chave:

  ```text
  Closes #79
  Closes 4dsm2026/frontend_fatecProjeto#199
  ```

  Isso liga o PR à issue (aparece em *Development*, na lateral da issue). O fechamento automático acontece quando o PR é mesclado na **branch padrão** do repositório.
- Se o PR depende de outro repositório, informe em **Depende de** (ex.: `4dsm2026/backend_fatecProjeto#105`).
- No backend e no frontend, os revisores são solicitados automaticamente (líderes da equipe do autor) e é preciso **1 aprovação**. Na documentação e nos testes, o PR é obrigatório, mas pode ser mesclado sem aprovação.
- O **CI** (lint, testes e build) roda em todo PR para `develop` e `main`. Nos PRs para `main` ele é **obrigatório**: o GitHub bloqueia o merge se falhar. Nos PRs para `develop` ele avisa, e PR com CI vermelho não deve ser mesclado.
- Prints e vídeos de evidência: **anexe no PR** (arraste para a caixa de texto). Não faça commit de vídeos, `.zip` ou `.pdf` grandes.

---

## 6. Sprints e versões

- As sprints ficam no campo **Sprint** do [quadro do projeto](https://github.com/orgs/4dsm2026/projects), que reúne as issues e PRs dos quatro repositórios. Toda issue trabalhada na sprint deve estar nela.
- No fim da sprint, um PR `develop → main` é aberto. Quando ele é mesclado, o workflow **Release** cria sozinho a **tag** e a **release** com a próxima versão:

  | Commits desde a última versão | Nova versão |
  |---|---|
  | algum `feat` | sobe o minor: `v0.4.2` → `v0.5.0` |
  | só `fix`, `docs`, `chore`… | sobe o patch: `v0.4.2` → `v0.4.3` |
  | `!` no tipo ou `BREAKING CHANGE` | sobe o major (enquanto `0.x`, sobe o minor) |

  As notas da release listam os PRs agrupados pela label de tipo — por isso o título do PR importa.
- Em `docs_fatecProjeto` e `test_fatecProjeto`, a release é manual: **Actions → Release → Run workflow**.
- O histórico de versões fica em **Releases** de cada repositório.

---

## 7. Commits

Seguimos [Conventional Commits](https://www.conventionalcommits.org/pt-br/):

```text
<tipo>(escopo opcional): <descrição>

[corpo opcional]

[rodapé opcional, ex.: Refs #79]
```

Tipos: `feat`, `fix`, `refactor`, `test`, `docs`, `style`, `chore`, `perf`, `ci`, `build`.

- Presente do indicativo ("adiciona", não "adicionado").
- Primeira letra minúscula, sem ponto final.
- Título com no máximo **50 caracteres**; linha em branco antes do corpo; corpo com até **72 caracteres** por linha.

### Hooks do git

Cada repositório tem a pasta `.githooks/`, com dois hooks:

| Hook | O que faz |
|---|---|
| `commit-msg` | Recusa o commit se a mensagem não seguir o padrão acima (avisa se o título passar de 50 caracteres) |
| `pre-commit` | Recusa arquivos acima de 5 MB e arquivos `.env` |

No backend, no frontend e na documentação, os hooks são ativados sozinhos no `pnpm install` / `npm install`. No repositório de testes (Python), rode uma vez:

```bash
git config core.hooksPath .githooks
```

Não use `git commit --no-verify` para contornar os hooks. Se o hook bloquear algo que deveria passar, abra uma issue.

---

## 8. Documentação e testes

- **Documentação** fica somente em [`docs_fatecProjeto`](https://github.com/4dsm2026/docs_fatecProjeto). Se o seu PR muda um fluxo, uma regra de negócio ou uma tela, abra também um PR lá (ou uma issue `[Docs]`).
- **Vulnerabilidades e segredos expostos** nunca vão em issue pública: veja a [política de segurança](SECURITY.md).
- **Testes unitários** ficam em cada repositório (`pnpm test`).
- **Testes de ponta a ponta** ficam em [`test_fatecProjeto`](https://github.com/4dsm2026/test_fatecProjeto). Cada teste deve indicar a issue ou história de usuário que verifica. Se o seu PR muda o comportamento de uma tela, verifique se algum teste precisa ser atualizado.
