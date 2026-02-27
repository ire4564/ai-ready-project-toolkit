#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(pwd)"
AGENT_DIR="$PROJECT_DIR/agent"

if [ ! -d "$AGENT_DIR" ]; then
  echo "[setup-cursor] agent/ 폴더가 없습니다. 건너뜁니다."
  exit 0
fi

RULES_DIR="$PROJECT_DIR/.cursor/rules"
COMMANDS_DIR="$PROJECT_DIR/.cursor/commands"

mkdir -p "$RULES_DIR"
mkdir -p "$COMMANDS_DIR"

write_mdc() {
  local src="$1"
  local dest="$2"
  local description="$3"

  {
    echo "---"
    echo "description: $description"
    echo "alwaysApply: true"
    echo "---"
    echo ""
    cat "$src"
  } > "$dest"
}

echo "[setup-cursor] .cursor/commands/commit.md 생성..."
cp "$AGENT_DIR/COMMIT.md" "$COMMANDS_DIR/commit.md"

echo "[setup-cursor] .cursor/rules/ 생성..."
write_mdc "$AGENT_DIR/DECISIONS.md" "$RULES_DIR/002-decisions.mdc" \
  "에이전트 문서 허브 — 읽기 순서, 문서 간 관계, 원칙"

write_mdc "$AGENT_DIR/PROJECT_CONTEXT.md" "$RULES_DIR/003-project-context.mdc" \
  "스택, 아키텍처, 규칙, 품질 기준 — 모든 작업의 기반"

write_mdc "$AGENT_DIR/GLOSSARY.md" "$RULES_DIR/004-glossary.mdc" \
  "네이밍, 케이스, 선언 방식 — 이름을 지을 때 참조"

write_mdc "$AGENT_DIR/TASK_TEMPLATE.md" "$RULES_DIR/005-task-template.mdc" \
  "작업 요청/정의 포맷 — 새 작업 정의 시"

write_mdc "$AGENT_DIR/CHECKLISTS.md" "$RULES_DIR/006-checklists.mdc" \
  "작업 유형별 체크리스트 — 작업 중/후 검증"

echo "[setup-cursor] 완료!"
echo "  - .cursor/commands/commit.md"
echo "  - .cursor/rules/002-decisions.mdc"
echo "  - .cursor/rules/003-project-context.mdc"
echo "  - .cursor/rules/004-glossary.mdc"
echo "  - .cursor/rules/005-task-template.mdc"
echo "  - .cursor/rules/006-checklists.mdc"
