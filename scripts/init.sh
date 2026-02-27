#!/usr/bin/env bash
set -euo pipefail

TOOLKIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$TOOLKIT_DIR/template"
AGENT_DIR="$TOOLKIT_DIR/agent"

usage() {
  echo "Usage: $0 <project-name>"
  echo ""
  echo "Arguments:"
  echo "  project-name   대상 프로젝트 디렉토리 (없으면 생성)"
  echo ""
  echo "이 스크립트는 다음을 수행합니다:"
  echo "  1. template/ 설정 파일 복사 (package.json, ESLint, Prettier)"
  echo "  2. agent/ 컨텍스트 문서 복사"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

PROJECT_NAME="$1"
PROJECT_DIR="$(pwd)/$PROJECT_NAME"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "==> Creating directory '$PROJECT_NAME'..."
  mkdir -p "$PROJECT_DIR"
fi

echo "==> Copying template files..."
cp "$TEMPLATE_DIR/package.json" "$PROJECT_DIR/"
cp "$TEMPLATE_DIR/eslint.config.mjs" "$PROJECT_DIR/"
cp "$TEMPLATE_DIR/.prettierrc" "$PROJECT_DIR/"
cp "$TEMPLATE_DIR/.prettierignore" "$PROJECT_DIR/"

echo "==> Copying agent context files..."
cp "$AGENT_DIR/PROJECT_CONTEXT.md" "$PROJECT_DIR/PROJECT_CONTEXT.md"
mkdir -p "$PROJECT_DIR/agent"
cp "$AGENT_DIR/DECISIONS.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/GLOSSARY.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/TASK_TEMPLATE.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/CHECKLISTS.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/COMMIT.md" "$PROJECT_DIR/agent/"

echo ""
echo "Done! Files copied to '$PROJECT_NAME':"
echo ""
echo "  Template:"
echo "    - package.json"
echo "    - eslint.config.mjs"
echo "    - .prettierrc"
echo "    - .prettierignore"
echo ""
echo "  Agent context:"
echo "    - PROJECT_CONTEXT.md (루트)"
echo "    - agent/DECISIONS.md"
echo "    - agent/GLOSSARY.md"
echo "    - agent/TASK_TEMPLATE.md"
echo "    - agent/CHECKLISTS.md"
echo "    - agent/COMMIT.md"
echo ""
echo "Next steps:"
echo ""
echo "  cd $PROJECT_NAME && pnpm install"
