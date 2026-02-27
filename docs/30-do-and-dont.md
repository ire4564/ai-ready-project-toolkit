# 30 — Do & Don't

> 구체적으로 뭘 하고, 뭘 하지 말아야 하는가.

---

## TypeScript

| | Do ✓ | Don't ✗ |
|---|------|---------|
| 타입 | `unknown` + 타입 가드 | `any` |
| 타입 정의 (Props) | `interface` | `type` (Props에 한해) |
| 타입 정의 (그 외) | `type` | 불필요한 `interface` 남발 |
| 타입 단언 | `as const` 적극 활용 | `as Type` 남발 |
| null 처리 | optional chaining `?.` | `!` non-null assertion |
| enum | `as const` 객체 | `enum` (트리쉐이킹 불가) |

---

## React

| | Do ✓ | Don't ✗ |
|---|------|---------|
| 컴포넌트 선언 | `export default function` | 화살표 함수 (default 불가 시만 허용) |
| 컴포넌트 | 함수 컴포넌트 + hooks | 클래스 컴포넌트 |
| 스타일 | 컴포넌트 파일에 통합 | 별도 스타일 파일 분리 |
| 상태 | 최소한의 상태만 관리 | 파생 가능한 값을 state로 |
| Props | 구조 분해 할당으로 받기 | `props.xxx` 직접 접근 |
| Key | 안정적인 고유 ID | 배열 index |
| 이벤트 핸들러 (정의) | `handleXxx` | 익명 함수 inline 남발 |
| 이벤트 핸들러 (Props) | `onXxx` | `handleXxx`를 Props로 전달 |
| 조건문 | early return | 중첩 if/else |
| 조건부 렌더링 | 삼항 또는 early return | `&&` (falsy 값 렌더링 위험) |
| 스타일 (CSS) | Tailwind utility class | inline style 객체 |

---

## 상태 관리

| | Do ✓ | Don't ✗ |
|---|------|---------|
| 서버 상태 | TanStack Query | 직접 fetch + useState |
| 클라이언트 상태 | Zustand (필요할 때만) | 전역 상태에 모든 것 넣기 |
| 폼 상태 | React Hook Form + Zod | 직접 onChange 핸들링 |
| URL 상태 | searchParams 활용 | state로 URL 동기화 시도 |

---

## 파일 & 폴더 (Feature-based)

| | Do ✓ | Don't ✗ |
|---|------|---------|
| 디렉토리 | `kebab-case` | `camelCase` or `PascalCase` |
| 컴포넌트 파일 | `PascalCase.tsx` | `kebab-case.tsx` |
| hooks 파일 | `use~.ts` (camelCase) | `kebab-case.ts` |
| utils, store 등 | `camelCase.ts` | `kebab-case.ts` |
| 한 파일 역할 | 1 파일 = 1 책임 | 여러 컴포넌트를 한 파일에 |
| feature 접근 | `index.ts` Public API로만 | feature 내부 파일 직접 import |
| 의존 방향 | `app → features → shared` 단방향 | 역방향 또는 feature 간 직접 import |
| feature 간 조합 | `app/` 페이지에서 조합 | feature끼리 직접 참조 |
| 테스트 파일 | `xxx.test.ts` (같은 폴더) | `__tests__/` 별도 폴더 |

---

## Git & Commit

| | Do ✓ | Don't ✗ |
|---|------|---------|
| 커밋 메시지 | `type(scope): 설명` | 의미 없는 메시지 ("fix", "update") |
| 커밋 단위 | 하나의 논리적 변경 | 여러 기능을 한 커밋에 |
| 브랜치 | `feat/xxx`, `fix/xxx` | `main`에 직접 커밋 |
| PR | 작게, 자주 | 1000줄짜리 mega PR |

---

## 일반

| | Do ✓ | Don't ✗ |
|---|------|---------|
| 주석 | "왜"를 설명 | "무엇"을 설명 (코드가 할 일) |
| 매직 넘버 | 상수로 추출 | 숫자 리터럴 직접 사용 |
| 콘솔 로그 | 개발 중에만, PR 전 제거 | `console.log` 커밋 |
| 환경 변수 | `.env.example` 유지 | `.env`를 커밋 |
| 에러 바운더리 | 페이지/섹션 단위 배치 | 앱 전체를 하나로 감싸기 |
