# 60 — Workflow

> 개발 프로세스와 작업 흐름.

---

## Git Workflow

### 브랜치 전략

- **MUST** — `main` 브랜치는 항상 배포 가능한 상태를 유지한다.
- **MUST** — feature 브랜치에서 작업하고, PR로 병합한다.
- **MUST NOT** — `main`에 직접 push하지 않는다.

### 브랜치 네이밍

```
feat/간단한-설명      # 새 기능
fix/간단한-설명       # 버그 수정
chore/간단한-설명     # 설정, 의존성 등
refactor/간단한-설명  # 리팩토링
docs/간단한-설명      # 문서
```

---

## Commit Convention

커밋 메시지 형식, type 목록, 분류 순서, 상세 규칙 → [agent/COMMIT.md](../agent/COMMIT.md)

### 요약

```
<type>(<scope>): <한글 설명>
```

- type: feat, fix, ui, docs, style, refactor, test, chore, perf, revert
- 커밋 메시지는 한글, 구체적으로 작성. "수정", "업데이트" 같은 모호한 단어 금지.

---

## PR 규칙

- **MUST** — PR 제목은 Conventional Commits 형식.
- **MUST** — CI 통과해야 머지.
- **SHOULD** — PR 본문에 "왜 이 변경이 필요한가" 설명.
- **SHOULD** — PR 크기 400줄 이내.
- **SHOULD** — UI 변경 시 스크린샷 첨부.

### PR 템플릿

```markdown
## What
<!-- 무엇을 변경했는가 -->

## Why
<!-- 왜 이 변경이 필요한가 -->

## How
<!-- 어떻게 구현했는가 -->

## Checklist
- [ ] 타입 체크 통과
- [ ] 린트 통과
- [ ] 테스트 추가/수정
- [ ] 스크린샷 (UI 변경 시)
```

---

## 개발 사이클

```
1. 이슈 확인 / 작업 정의
   ↓
2. 브랜치 생성 (type/xxx)
   ↓
3. TDD: 테스트 → 타입 → 최소 구현 → 리팩토링
   ↓
4. 로컬에서 typecheck + lint + test 통과 확인
   ↓
5. PR 생성 + 리뷰 요청
   ↓
6. CI 통과 + 리뷰 승인
   ↓
7. Squash & Merge → main
   ↓
8. 자동 배포
```

첫 작업 이후, 작업 중에는 별도의 브랜치 전환 요청이 없으면 해당 브랜치에서 계속해서 작업을 진행함.