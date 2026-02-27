# 70 — Stack

> 기본 기술 스택과 선택 이유.

---

## DEFAULT Stack 

| 카테고리 | 선택 | 이유 |
|----------|------|------|
| **Language** | TypeScript (strict) | 타입 안전성 + 생산성 |
| **Framework** | Next.js (App Router) | SSR/SSG + 파일 기반 라우팅 + API Routes |
| **Styling** | Tailwind CSS | 유틸리티 기반, 빠른 프로토타이핑 |
| **UI Components** | shadcn/ui | 복사해서 쓰는 방식, 커스터마이징 자유도 |
| **State (Server)** | TanStack Query | 캐싱, 재시도, 백그라운드 리페치 |
| **State (Client)** | Zustand | 가볍고 보일러플레이트 최소 |
| **Form** | React Hook Form + Zod | 성능 + 타입 안전한 검증 |
| **Validation** | Zod | 런타임 검증 + 타입 추론 |
| **Auth** | NextAuth.js (Auth.js) | OAuth 통합, 세션 관리 |
| **Database** | Firebase | 빠른 프로토타이핑, 실시간 DB + 인증 통합 |
| **Hosting** | Vercel | Next.js 최적화, 무료 티어 |
| **Package Manager** | pnpm | 빠르고 디스크 효율적 |

---

## 도구 & 설정

| 카테고리 | 선택 | 설정 |
|----------|------|------|
| **Bundler** | Turbopack (Next.js 기본) | `next dev --turbopack` |
| **Linter** | ESLint (Flat Config) | `eslint.config.mjs` |
| **Formatter** | Prettier | `.prettierrc` |
| **Editor** | EditorConfig | `.editorconfig` |
| **Git Hooks** | Husky + lint-staged | pre-commit: lint + format |
| **Commit Lint** | commitlint | Conventional Commits 강제 |
| **Test** | Jest + Testing Library | React 테스트 표준 |
| **E2E Test** | Playwright | 크로스 브라우저 E2E |

### Turbopack vs Vite

| | Turbopack | Vite |
|---|-----------|------|
| **통합** | Next.js 내장 (설정 불필요) | 별도 프로젝트 또는 플러그인 필요 |
| **HMR** | Rust 기반, 대규모 프로젝트에서 빠름 | ESM 기반, 소규모~중규모에서 빠름 |
| **적합한 경우** | Next.js 프로젝트 (기본 선택) | React SPA, Svelte, Vue 등 Next.js 외 프로젝트 |
| **성숙도** | Next.js 15+ 안정화 | 생태계 성숙, 플러그인 풍부 |

- Next.js를 사용하므로 **Turbopack이 기본 선택**. 별도 번들러 설정이 필요 없다.
- Next.js 외 프로젝트(React SPA, 라이브러리 등)에서는 **Vite**를 사용한다.

---

## 스택 선택 원칙

### MUST — 선택에는 이유가 있어야 한다

새 도구를 추가할 때는 이유를 문서화한다.

### MUST NOT — 유행만으로 스택을 바꾸지 않는다

현재 도구가 문제를 해결하지 못할 때만 교체를 고려한다.

### SHOULD — 생태계가 활발한 도구를 선택한다

- GitHub Stars보다 **최근 커밋 빈도**와 **이슈 응답 속도**를 본다.
- npm 주간 다운로드 수가 꾸준히 유지/증가하는지 확인한다.

### MAY — 프로젝트 특성에 따라 스택을 변형한다

| 프로젝트 유형 | 변형 포인트 |
|--------------|------------|
| 정적 사이트 / 블로그 | Astro 또는 Next.js Static Export |
| React SPA (SSR 불필요) | Vite + React |
| 모바일 앱 | React Native + Expo |
| CLI 도구 | Node.js + Commander |
| API 서버 전용 | Hono 또는 Fastify |
| 실시간 기능 필요 | Supabase Realtime 또는 Socket.io |
| 라이브러리 / 패키지 | Vite (Library Mode) 또는 tsup |
