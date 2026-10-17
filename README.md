# .github — padrões da organização 4dsm2026

Este repositório guarda o que é comum a **todos os repositórios** da organização.

## Aplicado automaticamente pelo GitHub

| Arquivo | Efeito |
|---|---|
| `CONTRIBUTING.md` | Guia de contribuição |
| `CODE_OF_CONDUCT.md` | Código de conduta |
| `SECURITY.md` | Como relatar vulnerabilidades |
| `SUPPORT.md` | Onde pedir ajuda |
| `.github/pull_request_template.md` | Modelo preenchido ao abrir um Pull Request |
| `.github/ISSUE_TEMPLATE/` | Modelos de issue (Bug, Nova funcionalidade, Tarefa técnica) |
| `profile/README.md` | Página inicial da organização (github.com/4dsm2026) |

> Um repositório que tenha o **próprio** arquivo (por exemplo, `CONTRIBUTING.md` na raiz) ignora o padrão daqui. Para manter um único guia, esses arquivos não devem existir nos outros repositórios.

## Usado pelos repositórios

| Arquivo | Uso |
|---|---|
| `.github/workflows/release.yml` | Workflow reutilizável: cria a tag e a release com a próxima versão |
| `.github/workflows/pr-check.yml` | Workflow reutilizável: confere o título do PR e aplica a label de tipo |
| `githooks/` | Fonte dos hooks `commit-msg` e `pre-commit`, copiados para a pasta `.githooks/` de cada repositório |
| `templates/release.yml` | Categorias das notas de release, copiado para `.github/release.yml` de cada repositório |
| `labels.txt` + `scripts/sync-labels.sh` | Labels padrão e script para aplicá-las em todos os repositórios |

## Alterar um padrão

Abra um Pull Request neste repositório. Mudanças nos workflows reutilizáveis valem para todos os repositórios assim que mescladas. Mudanças em `githooks/` ou `templates/` precisam ser copiadas para cada repositório.

## Sincronizar labels

```bash
scripts/sync-labels.sh            # simulação: mostra o que mudaria
scripts/sync-labels.sh --apply    # aplica nos quatro repositórios
```
