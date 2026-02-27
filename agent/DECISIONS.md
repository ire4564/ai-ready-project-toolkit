# Agent Docs — Entry Point

이 폴더의 문서를 아래 순서로 참조한다.

## 1. 항상 먼저 읽기

- **PROJECT_CONTEXT.md** — 스택, 아키텍처, 규칙, 품질 기준. 모든 작업의 기반.
- **GLOSSARY.md** — 네이밍, 케이스, 선언 방식. 이름을 지을 때 반드시 참조.

## 2. 작업 시작 시

- **TASK_TEMPLATE.md** — 작업 요청/정의 포맷. 새 작업을 정의할 때 이 형식을 따른다.

## 3. 작업 중

- **CHECKLISTS.md** — 작업 유형별 체크리스트 (API, 컴포넌트, 상태, 성능, 접근성, 보안, PR).
- **COMMIT.md** — 커밋 메시지 형식, type 분류, 파일 그룹핑 순서.

## 문서 간 관계

```
PROJECT_CONTEXT (규칙 요약)
├── Naming → GLOSSARY (상세)
├── Components → GLOSSARY (선언/타입/스타일)
├── Commit/PR → COMMIT (상세)
└── Quality Gates → CHECKLISTS (PR 제출 전)
```

## 원칙

- PROJECT_CONTEXT에 없는 규칙은 적용하지 않는다
- GLOSSARY에 없는 네이밍 패턴을 임의로 만들지 않는다
- 기술 결정이 필요하면 개발자에게 먼저 확인한다
