#!/usr/bin/env bash
# Sincroniza as labels dos repositórios com labels.txt.
#
# Uso:
#   scripts/sync-labels.sh                 # simulação em todos os repositórios (não altera nada)
#   scripts/sync-labels.sh --apply         # aplica em todos os repositórios
#   scripts/sync-labels.sh --apply backend_fatecProjeto
#
# O que faz, em cada repositório:
#   1. Migra labels antigas para o padrão (tabela MIGRACOES). Se a label nova ainda
#      não existe, a antiga é renomeada; se já existe, as issues/PRs são movidas
#      para a nova e a antiga é apagada. Nenhuma issue perde a classificação.
#   2. Cria ou atualiza (cor e descrição) as labels de labels.txt.
#   3. Lista as labels fora do padrão, sem alterá-las.
#
# Requer: gh autenticado com permissão de escrita nos repositórios, jq.
set -euo pipefail

ORG="4dsm2026"
DIR="$(cd "$(dirname "$0")/.." && pwd)"
LABELS_FILE="$DIR/labels.txt"

# antiga|nova
MIGRACOES='bug|[Bug]
security|[Security]
a11y|[A11y]
accessibility|[A11y]
test|[Test]
testing|[Test]
docs|[Docs]
documentation|[Docs]
refactoring / source code|[Refactor]
functionality / feature|[Feature]
enhancement / feature|[Feature]
enhancement|[Feature]
priority:médium|priority:medium
team:docs/devops|team:docs-devops
QA|team:qa
Novas Funcionalidades 1|team:novas-funcs-1'

APPLY=false
if [[ "${1:-}" == "--apply" ]]; then APPLY=true; shift; fi
REPOS=("$@")
if [[ ${#REPOS[@]} -eq 0 ]]; then
  REPOS=(backend_fatecProjeto frontend_fatecProjeto docs_fatecProjeto test_fatecProjeto)
fi

run() {
  if $APPLY; then "$@"; else echo "    (simulação) $*"; fi
}

has_label() { # nome, lista — GitHub trata nomes de label sem diferenciar maiúsculas
  grep -Fxqi -- "$1" <<<"$2"
}

uri() { jq -rn --arg s "$1" '$s|@uri'; }

canonical_names="$(grep -v '^#' "$LABELS_FILE" | grep -v '^$' | cut -d'|' -f1)"

for repo in "${REPOS[@]}"; do
  R="$ORG/$repo"
  echo "== $R"
  existing="$(gh label list -R "$R" --limit 300 --json name -q '.[].name')"

  # 1. Migrações
  while IFS='|' read -r old new; do
    has_label "$old" "$existing" || continue
    if ! has_label "$new" "$existing"; then
      echo "  renomeia '$old' -> '$new'"
      run gh label edit "$old" -R "$R" --name "$new"
      existing="$(printf '%s\n%s' "$existing" "$new")"
    else
      numeros="$( { gh issue list -R "$R" --label "$old" --state all --limit 1000 --json number -q '.[].number'
                    gh pr list    -R "$R" --label "$old" --state all --limit 1000 --json number -q '.[].number'; } | sort -un)"
      qtd=$(grep -c . <<<"$numeros" || true)
      echo "  move $qtd issue(s)/PR(s) de '$old' para '$new' e apaga '$old'"
      for n in $numeros; do
        run gh api -X POST "repos/$R/issues/$n/labels" -f "labels[]=$new" --silent
        run gh api -X DELETE "repos/$R/issues/$n/labels/$(uri "$old")" --silent
      done
      run gh label delete "$old" -R "$R" --yes
    fi
    existing="$(grep -Fxvi -- "$old" <<<"$existing" || true)"
  done <<<"$MIGRACOES"

  # 2. Labels padrão
  while IFS='|' read -r name color desc; do
    [[ -z "$name" || "$name" == \#* ]] && continue
    if has_label "$name" "$existing"; then
      # só atualiza cor/descrição; não polui a simulação
      if $APPLY; then gh label edit "$name" -R "$R" --color "$color" --description "$desc"; fi
    else
      echo "  cria '$name'"
      run gh label create "$name" -R "$R" --color "$color" --description "$desc"
    fi
  done <"$LABELS_FILE"

  # 3. Fora do padrão
  extras="$(grep -Fxvi -f <(printf '%s\n' "$canonical_names") <<<"$existing" || true)"
  if [[ -n "$extras" ]]; then
    echo "  fora do padrão (não alteradas):"
    sed 's/^/    - /' <<<"$extras"
  fi
done

$APPLY || echo $'\nNada foi alterado. Rode com --apply para aplicar.'
