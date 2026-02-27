# PROJECT_CONTEXT

## Stack

- Lang: TypeScript (strict)
- Framework: Next.js (App Router)
- Style: Tailwind CSS + shadcn/ui
- Server State: TanStack Query
- Client State: Zustand
- Form: React Hook Form + Zod
- Validation: Zod
- Auth: Auth.js
- DB: Firebase
- Test: Jest + Testing Library + Playwright
- Hosting: Vercel
- PM: pnpm

## Workflow

AI와 협업하되 설계 주도권은 개발자가 유지.
AI가 반복 동작, 요청하지 않은 기능 구현, 테스트 삭제 시 즉시 개입.

TDD (Red → Green → Refactor):
1. 테스트 작성 → 실패 확인
2. 최소 코드로 테스트 통과 → 오버엔지니어링 금지
3. 중복 제거, 가독성 개선, 성능 최적화

개발 순서: 테스트 → 타입 정의 → 최소 구현 → 리팩토링
MAY: 사이드 프로젝트에서 구현 시간이 오래 걸리면 테스트 생략 가능 (핵심 로직·공유 유틸 제외)

## MUST NOT

- any 사용
- Mock 데이터 / 가짜 구현
- 직접 DOM 조작
- console.log 프로덕션 코드에 남기기

## Architecture (Feature-based)

레이어 (위→아래 단방향만):
app → features → shared

- app: Next.js 라우팅, 레이아웃, 프로바이더 (얇게 유지, 비즈니스 로직 금지)
- features: 기능 단위 모듈 (components/, hooks/, api.ts, *.types.ts, index.ts)
- shared: 범용 UI, 공용 훅, 유틸, 타입, 상수

규칙:
- MUST: 각 feature는 index.ts로 Public API만 노출, 내부 직접 import 금지
- MUST NOT: feature 간 직접 import (app에서 조합)
- MUST NOT: shared → features 역방향 의존

## Rules

### Types
- MUST: strict: true, any 금지
- MUST: 외부 데이터 Zod 런타임 검증
- SHOULD: unknown > any, 타입 가드로 좁히기

### Naming → GLOSSARY.md

### Functions
- MUST: 조건문은 early return, 중첩 if/else 금지
- SHOULD: 단일 책임, 30줄 이내
- MUST NOT: 파라미터 3개 초과 → 객체로
- SHOULD: 순수 함수 선호, 부수 효과 분리

### Components
- MUST: Props만 보고 사용법 파악 가능한 인터페이스
- MUST: 낮은 결합도, API 호출은 훅에 위임
- SHOULD: Compound Pattern, 재사용성 확보
- SHOULD: 가독성 우선, 과도한 추상화 금지
- SHOULD: shared(범용 UI) / features(기능 전용) / app(페이지 조합) 분리
- 선언/타입/스타일 규칙 → GLOSSARY.md

### Error Handling
- MUST: catch → 로깅 또는 상위 전파
- MUST: 사용자 메시지 ≠ 개발자 메시지
- SHOULD: 커스텀 에러 클래스

### Dependencies
- MUST: exact 버전 (^ 금지)
- SHOULD: 추가 전 "직접 구현하면 몇 줄?" 판단

## Quality Gates

- typecheck: tsc --noEmit → 0 errors
- lint: eslint . → 0 errors
- format: prettier --check . → 0 mismatches
- test: jest --ci → all pass
- build: next build → success

## Commit/PR → COMMIT.md

- type: feat, fix, ui, docs, style, refactor, test, chore, perf, revert
- branch: type/kebab-case
- PR < 400줄, 1 PR = 1 관심사

## 문제 해결 우선순위

1. 실제 동작하는 해결책
2. 기존 코드 패턴 일관성
3. 타입 안전성
4. 테스트 가능한 구조
