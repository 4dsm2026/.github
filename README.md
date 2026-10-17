# .github — padrões da organização 4dsm2026

Este repositório guarda os arquivos que o GitHub aplica **automaticamente a todos os repositórios** da organização:

| Arquivo | Efeito |
|---|---|
| `CONTRIBUTING.md` | Guia de contribuição exibido em todos os repositórios |
| `.github/pull_request_template.md` | Modelo preenchido ao abrir um Pull Request |
| `.github/ISSUE_TEMPLATE/` | Modelos de issue (Bug, Nova funcionalidade, Tarefa técnica) |
| `profile/README.md` | Página inicial da organização (github.com/4dsm2026) |
| `labels.txt` + `scripts/sync-labels.sh` | Labels padrão e script para aplicá-las em todos os repositórios |

> Um repositório que tenha o **próprio** arquivo (por exemplo, `CONTRIBUTING.md` na raiz ou uma pasta `.github/ISSUE_TEMPLATE/`) ignora o padrão daqui. Para manter um único guia, esses arquivos não devem existir nos outros repositórios.

## Alterar um padrão

Abra um Pull Request neste repositório. A mudança vale para todos os repositórios assim que for mesclada.

## Sincronizar labels

```bash
scripts/sync-labels.sh            # simulação: mostra o que mudaria
scripts/sync-labels.sh --apply    # aplica nos quatro repositórios
```

Labels antigas equivalentes são renomeadas ou migradas sem que as issues percam a classificação. Labels fora do padrão são apenas listadas.
