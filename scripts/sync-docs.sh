#!/usr/bin/env bash
# Copie les documents de travail personnels depuis le dépôt d'organisation
# (EpitechPGE45-2026/G-ING-900-PAR-9-1-legacy-3, où ils sont gitignorés — non
# partagés avec l'équipe) vers ce dépôt perso, où ils sont versionnés pour de
# vrai. Committe et pousse automatiquement s'il y a des changements.
#
# Usage : ./scripts/sync-docs.sh [--no-push]
set -euo pipefail

ORG_DOCS="/Users/techeretienne/Documents/claude_workspace/Legacy/G-ING-900-PAR-9-1-legacy-3/docs"
PERSO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PERSO_DOCS="$PERSO_ROOT/docs"

# Liste blanche volontaire : uniquement les documents personnels, non trackés
# côté dépôt d'organisation (vérifié via `git status --porcelain -- docs/`).
# Ne touche à rien d'autre dans docs/ (AGILE_GOVERNANCE.md, DockerUserGuide.md,
# etc. restent gérés à la main ici, pas synchronisés depuis l'org).
FILES=(
  "AUDIT_REPORT.md"
  "GITHUB_ISSUES_SPRINT1.md"
  "GITHUB_ISSUES_SPRINT2.md"
  "GITHUB_ISSUES_SPRINT3.md"
  "PLAN_ACTION_SPRINT1.md"
  "PLAN_ACTION_SPRINT2.md"
  "PLAN_ACTION_SPRINT3.md"
  "SPRINT1_CHANGELOG.md"
  "SPRINT2_CHANGELOG.md"
  "SPRINT2_PLAN.md"
)
DIRS=(
  "adr"
  "oral"
)

if [[ ! -d "$ORG_DOCS" ]]; then
  echo "Dépôt d'organisation introuvable : $ORG_DOCS" >&2
  exit 1
fi

echo "==> Copie des fichiers personnels..."
for f in "${FILES[@]}"; do
  if [[ -f "$ORG_DOCS/$f" ]]; then
    cp "$ORG_DOCS/$f" "$PERSO_DOCS/$f"
    echo "    $f"
  fi
done

echo "==> Copie des dossiers personnels..."
for d in "${DIRS[@]}"; do
  if [[ -d "$ORG_DOCS/$d" ]]; then
    mkdir -p "$PERSO_DOCS/$d"
    rsync -a --delete "$ORG_DOCS/$d/" "$PERSO_DOCS/$d/"
    echo "    $d/"
  fi
done

# Nettoyage de l'ancienne structure imbriquée (docs/SPRINT2/, docs/SPRINT3/),
# remplacée par les fichiers plats ci-dessus depuis la correction de
# l'anomalie de nommage du Sprint 2.
for stale in SPRINT2 SPRINT3; do
  if [[ -d "$PERSO_DOCS/$stale" ]]; then
    echo "==> Suppression de l'ancienne structure imbriquée docs/$stale/"
    rm -rf "${PERSO_DOCS:?}/$stale"
  fi
done

cd "$PERSO_ROOT"

if [[ -z "$(git status --porcelain -- docs/)" ]]; then
  echo "Rien de nouveau à synchroniser."
  exit 0
fi

git add docs/
git commit -m "chore(docs): synchronise les documents personnels ($(date '+%Y-%m-%d %H:%M'))"

if [[ "${1:-}" == "--no-push" ]]; then
  echo "Synchronisé, commité localement (--no-push)."
else
  git push
  echo "Synchronisé et poussé."
fi
