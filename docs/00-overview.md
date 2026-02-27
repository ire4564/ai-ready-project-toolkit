# 00 — Overview

> 전체 규칙 요약 + 문서 허브.

---

## 핵심 철학 (5원칙)

1. **읽기 쉬운 코드** — "나중에 내가 봐도 바로 이해되는가?"가 최우선 기준
2. **작게, 자주** — 1 PR = 1 관심사, 400줄 이내
3. **타입이 곧 문서** — `strict: true`, `any` 금지
4. **자동화** — lint, format, test, deploy는 사람이 아닌 도구가 강제
5. **완벽보다 완성** — 80% 완성도로 배포, 피드백으로 개선

---

## 문서 맵

### docs/ — 사람이 읽는 상세 규칙

| 문서 | 내용 | 언제 참조하나 |
|------|------|--------------|
| [10-philosophy](./10-philosophy.md) | 개발 철학 + 경계하는 것 | 프로젝트 방향성 판단 시 |
| [20-engineering-principles](./20-engineering-principles.md) | 타입, 함수, 컴포넌트, 에러, 의존성, 성능 규칙 | 코드 작성/리뷰 시 |
| [30-do-and-dont](./30-do-and-dont.md) | 영역별 Do/Don't 표 | 빠른 규칙 확인 시 |
| [40-examples](./40-examples.md) | Before/After 코드 예시 | 패턴 적용 방법이 궁금할 때 |
| [50-architecture-guidelines](./50-architecture-guidelines.md) | Feature-based 구조, 레이어, 의존 규칙 | 구조 설계 시 |
| [60-workflow](./60-workflow.md) | Git, PR, 개발 사이클 | 작업 프로세스 확인 시 |
| [70-stack](./70-stack.md) | 기술 스택 + 선택 이유 | 기술 선택/변경 시 |
| [80-quality-gates](./80-quality-gates.md) | CI, 테스트, 번들, 접근성 기준 | PR 제출 전 |

### agent/ — 에이전트용 구조화 문서

| 문서 | 내용 | 언제 참조하나 |
|------|------|--------------|
| [DECISIONS](../agent/DECISIONS.md) | 에이전트 문서 허브 | **가장 먼저 읽기** |
| [PROJECT_CONTEXT](../agent/PROJECT_CONTEXT.md) | 스택 + 규칙 + 품질 기준 | **모든 작업 시작 전** |
| [GLOSSARY](../agent/GLOSSARY.md) | 네이밍, 선언 방식, 용어 | 이름을 지을 때 |
| [TASK_TEMPLATE](../agent/TASK_TEMPLATE.md) | 작업 요청 포맷 | 새 작업 정의 시 |
| [CHECKLISTS](../agent/CHECKLISTS.md) | 작업 유형별 체크리스트 | 작업 중/후 검증 시 |
| [COMMIT](../agent/COMMIT.md) | 커밋 형식, 분류, 그룹핑 | 커밋할 때 |

### template/ — 프로젝트 템플릿

| 파일 | 내용 |
|------|------|
| [package.json](../template/package.json) | 의존성 + 스크립트 + lint-staged |
| [eslint.config.mjs](../template/eslint.config.mjs) | ESLint flat config |
| [.prettierrc](../template/.prettierrc) | Prettier 규칙 |
| [.prettierignore](../template/.prettierignore) | Prettier 제외 대상 |

---

## 태그 규칙

| Tag | 의미 |
|-----|------|
| `MUST` | 반드시 지킬 것 |
| `MUST NOT` | 절대 하면 안 됨 |
| `SHOULD` | 권장 (합리적 이유가 있으면 예외) |
| `MAY` | 선택 |

각 규칙은 **규칙 1줄 → 이유 1줄 → 예시(선택)** 구조를 따릅니다.
