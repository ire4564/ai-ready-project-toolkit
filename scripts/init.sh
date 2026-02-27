#!/usr/bin/env bash
set -euo pipefail

TOOLKIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$TOOLKIT_DIR/template"
AGENT_DIR="$TOOLKIT_DIR/agent"
SCRIPTS_DIR="$TOOLKIT_DIR/scripts"

usage() {
  echo "Usage: $0 <project-name>"
  echo ""
  echo "Arguments:"
  echo "  project-name   생성할 프로젝트 이름"
  echo ""
  echo "이 스크립트는 다음을 수행합니다:"
  echo "  1. create-next-app으로 Next.js 프로젝트 생성"
  echo "  2. template/ 설정 파일 덮어쓰기 (package.json, ESLint, Prettier)"
  echo "  3. agent/ 컨텍스트 문서 복사"
  echo "  4. scripts/setup-cursor.sh 복사"
  echo "  5. Feature-based 폴더 구조 생성"
  echo "  6. tsconfig.json path alias 설정 (@features/*, @shared/*)"
  echo "  7. pnpm install (Cursor 설정 자동 생성 포함)"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

PROJECT_NAME="$1"
PROJECT_DIR="$(pwd)/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
  echo "Error: '$PROJECT_NAME' 디렉토리가 이미 존재합니다."
  exit 1
fi

echo "==> [1/6] create-next-app으로 프로젝트 생성..."
pnpm create next-app "$PROJECT_NAME" \
  --typescript \
  --tailwind \
  --eslint \
  --app \
  --src-dir \
  --use-pnpm \
  --turbopack \
  --import-alias "@/*"

echo ""
echo "==> [2/6] template 설정 파일 덮어쓰기..."
cp "$TEMPLATE_DIR/package.json" "$PROJECT_DIR/"
cp "$TEMPLATE_DIR/eslint.config.mjs" "$PROJECT_DIR/"
cp "$TEMPLATE_DIR/.prettierrc" "$PROJECT_DIR/"
cp "$TEMPLATE_DIR/.prettierignore" "$PROJECT_DIR/"

echo "==> [3/6] agent 컨텍스트 문서 복사..."
mkdir -p "$PROJECT_DIR/agent"
cp "$AGENT_DIR/PROJECT_CONTEXT.md" "$PROJECT_DIR/PROJECT_CONTEXT.md"
cp "$AGENT_DIR/PROJECT_CONTEXT.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/DECISIONS.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/GLOSSARY.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/TASK_TEMPLATE.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/CHECKLISTS.md" "$PROJECT_DIR/agent/"
cp "$AGENT_DIR/COMMIT.md" "$PROJECT_DIR/agent/"

echo "==> [4/6] setup-cursor 스크립트 복사..."
mkdir -p "$PROJECT_DIR/scripts"
cp "$SCRIPTS_DIR/setup-cursor.sh" "$PROJECT_DIR/scripts/"
chmod +x "$PROJECT_DIR/scripts/setup-cursor.sh"

echo "==> [5/7] Feature-based 폴더 구조 생성..."
mkdir -p "$PROJECT_DIR/src/features"
mkdir -p "$PROJECT_DIR/src/shared/components"
mkdir -p "$PROJECT_DIR/src/shared/hooks"
mkdir -p "$PROJECT_DIR/src/shared/lib"
mkdir -p "$PROJECT_DIR/src/shared/types"
mkdir -p "$PROJECT_DIR/src/shared/config"

echo "==> [6/7] tsconfig.json path alias 설정..."
node -e "
const fs = require('fs');
const path = '$PROJECT_DIR/tsconfig.json';
const tsconfig = JSON.parse(fs.readFileSync(path, 'utf8'));
tsconfig.compilerOptions.paths = {
  '@features/*': ['./src/features/*'],
  '@shared/*': ['./src/shared/*'],
  '@/*': ['./src/*']
};
fs.writeFileSync(path, JSON.stringify(tsconfig, null, 2) + '\n');
"

echo "==> [7/7] 의존성 재설치 (template 반영)..."
cd "$PROJECT_DIR" && pnpm install

echo ""
echo "=========================================="
echo " Done! '$PROJECT_NAME' 프로젝트가 생성되었습니다."
echo "=========================================="
echo ""
echo "  cd $PROJECT_NAME && pnpm dev"
echo ""
echo "  생성된 구조:"
echo "    src/app/          — Next.js 라우팅 (create-next-app)"
echo "    src/features/     — 기능 단위 모듈"
echo "    src/shared/       — 공유 컴포넌트, 훅, 유틸"
echo "    agent/            — AI 에이전트 컨텍스트"
echo "    .cursor/rules/    — Cursor 규칙 (자동 생성)"
echo "    .cursor/commands/ — Cursor 커맨드 (자동 생성)"
