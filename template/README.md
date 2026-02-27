# Template

> Next.js 프로젝트 템플릿. 프로젝트 루트에 복사하여 사용합니다.

## 파일 목록

| 파일 | 역할 |
|------|------|
| `package.json` | 의존성, 스크립트, lint-staged, commitlint 설정 |
| `eslint.config.mjs` | ESLint flat config (ESLint 9+) |
| `.prettierrc` | Prettier 포맷팅 규칙 |
| `.prettierignore` | Prettier 제외 대상 |

## 사용법

```bash
# 1. 이 폴더의 파일을 프로젝트 루트에 복사
cp template/package.json        your-project/
cp template/eslint.config.mjs   your-project/
cp template/.prettierrc         your-project/
cp template/.prettierignore     your-project/

# 2. 의존성 설치 (postinstall로 Cursor 설정 자동 생성)
cd your-project
pnpm install

# 3. 실행
pnpm dev              # 개발 서버 (Turbopack)
pnpm lint             # ESLint 검사
pnpm format:check     # Prettier 검사
pnpm test             # Jest 테스트
```

### Cursor 자동 설정

`pnpm install` 시 `postinstall` 스크립트가 `agent/` 파일을 Cursor 설정으로 변환합니다:

| 소스 | 대상 |
|------|------|
| `agent/COMMIT.md` | `.cursor/commands/commit.md` |
| `agent/DECISIONS.md` | `.cursor/rules/002-decisions.mdc` |
| `agent/PROJECT_CONTEXT.md` | `.cursor/rules/003-project-context.mdc` |
| `agent/GLOSSARY.md` | `.cursor/rules/004-glossary.mdc` |
| `agent/TASK_TEMPLATE.md` | `.cursor/rules/005-task-template.mdc` |
| `agent/CHECKLISTS.md` | `.cursor/rules/006-checklists.mdc` |

`001` 번호는 프로젝트별 최우선 규칙을 위해 예약되어 있습니다.

## package.json 스크립트

| 스크립트 | 명령어 | 용도 |
|----------|--------|------|
| `dev` | `next dev --turbopack` | 개발 서버 |
| `build` | `next build` | 프로덕션 빌드 |
| `start` | `next start` | 프로덕션 서버 |
| `typecheck` | `tsc --noEmit` | 타입 체크 |
| `lint` | `eslint .` | 린트 검사 |
| `lint:fix` | `eslint . --fix` | 린트 자동 수정 |
| `format` | `prettier --write .` | 포맷 적용 |
| `format:check` | `prettier --check .` | 포맷 검사 |
| `test` | `jest` | 단위 테스트 |
| `test:ci` | `jest --ci` | CI용 테스트 |
| `test:e2e` | `playwright test` | E2E 테스트 |
| `prepare` | `husky` | Git hooks 설정 |
| `postinstall` | `bash scripts/setup-cursor.sh` | Cursor rules/commands 자동 생성 |

## 포함된 의존성

### Runtime

| 패키지 | 용도 |
|--------|------|
| `next` + `react` + `react-dom` | 프레임워크 |
| `tailwindcss` + `@tailwindcss/postcss` | 스타일링 |
| `@tanstack/react-query` | 서버 상태 관리 |
| `zustand` | 클라이언트 상태 관리 |
| `react-hook-form` + `@hookform/resolvers` | 폼 관리 |
| `zod` | 런타임 검증 |
| `next-auth` | 인증 |
| `firebase` | 데이터베이스 |

### Dev

| 패키지 | 용도 |
|--------|------|
| `typescript` + `@types/*` | 타입 시스템 |
| `eslint` + 플러그인들 | 린팅 |
| `prettier` + `prettier-plugin-tailwindcss` | 포맷팅 |
| `husky` + `lint-staged` + `@commitlint/*` | Git hooks |
| `jest` + `@testing-library/*` | 단위/통합 테스트 |
| `playwright` | E2E 테스트 |

## ESLint 규칙 요약

### Import 정렬

`import-x/order` 규칙으로 import 순서를 강제합니다:

1. **builtin / external** — `react`, `next`, 서드파티 라이브러리
2. **internal** — `@` 별칭 경로
3. **parent** — 상위 디렉토리
4. **sibling** — 같은 디렉토리
5. **index** — index 파일
6. **type** — 타입 import

그룹 간에는 빈 줄이 들어가고, 각 그룹 내에서는 알파벳 순으로 정렬됩니다.

### Unused Imports

`eslint-plugin-unused-imports`로 사용하지 않는 import를 자동 감지합니다.
`_` 접두사가 붙은 변수/파라미터는 무시됩니다.

### 상대 경로 제한

`../*` 형태의 상대 경로 import는 경고를 표시합니다.
`@` 별칭을 사용하도록 권장합니다.

### TypeScript Strict

- `@typescript-eslint/no-explicit-any: "error"` — `any` 타입 사용 시 에러
- `@typescript-eslint/array-type: "array-simple"` — 단순 배열은 `T[]`, 복합 배열은 `Array<T>`

### Parameter Reassign 방지

`no-param-reassign`으로 함수 파라미터 재할당을 금지합니다.
Zustand immer 패턴의 `draft`는 예외로 허용됩니다.

### React

- `react/jsx-no-useless-fragment` — 불필요한 `<></>` 경고
- `react/jsx-sort-props` — JSX props를 알파벳 순으로 정렬 (callback은 마지막, shorthand는 앞)

### TanStack Query

`@tanstack/eslint-plugin-query`의 recommended 규칙을 적용합니다.
잘못된 Query Key 사용, exhaustive deps 누락 등을 감지합니다.

### console.log 금지

`console.log`는 에러로 처리됩니다. 커밋 전에 반드시 제거하세요.
디버깅에는 `console.warn`, `console.error`, 또는 전용 logger를 사용하세요.

## Prettier 규칙 요약

| 옵션 | 값 | 설명 |
|------|-----|------|
| `printWidth` | 100 | 한 줄 최대 길이 |
| `semi` | true | 세미콜론 사용 |
| `singleQuote` | true | 작은따옴표 사용 |
| `trailingComma` | all | 후행 쉼표 항상 사용 |
| `bracketSpacing` | true | 객체 리터럴 중괄호 내 공백 |
| `bracketSameLine` | false | JSX 닫는 괄호 별도 줄 |
| `arrowParens` | always | 화살표 함수 파라미터 괄호 항상 사용 |
| `tabWidth` | 2 | 들여쓰기 2칸 |
| `endOfLine` | auto | OS에 맞는 줄바꿈 |

## 마이그레이션 노트

기존 `.eslintrc.*` (legacy config) 에서 이 flat config로 전환할 때:

- `eslint-plugin-import` → `eslint-plugin-import-x` (규칙 접두사: `import/` → `import-x/`)
- `eslint-config-next`는 `@eslint/eslintrc`의 `FlatCompat`으로 래핑
- Prettier의 `jsxBracketSameLine` → `bracketSameLine` (deprecated 반영)
