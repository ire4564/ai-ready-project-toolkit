# AI-Ready Project Toolkit

> 클론하면 바로 시작 가능한 프로젝트 스타터 + AI 에이전트용 작업 규칙/컨텍스트

## What is this?

이 레포는 세 가지 목적을 동시에 해결합니다:

1. **사람을 위한 개발 규칙/철학 문서** — `docs/`
2. **AI 에이전트가 파싱하기 쉬운 구조화된 컨텍스트** — `agent/`
3. **프로젝트 템플릿 (package.json + ESLint + Prettier)** — `template/`

## Repo Structure

```
ai-readme-toolkit/
├── README.md                  ← 지금 보고 있는 파일
├── docs/                      ← 사람이 읽는 개발 규칙/철학/예시
│   ├── 00-overview.md         ← 전체 요약 + 문서 허브
│   ├── 10-philosophy.md
│   ├── 20-engineering-principles.md
│   ├── 30-do-and-dont.md
│   ├── 40-examples.md
│   ├── 50-architecture-guidelines.md
│   ├── 60-workflow.md
│   ├── 70-stack.md
│   └── 80-quality-gates.md
├── agent/                     ← AI 에이전트용 구조화된 문서
│   ├── DECISIONS.md           ← 에이전트 문서 허브 (읽기 순서)
│   ├── PROJECT_CONTEXT.md     ← 스택, 아키텍처, 규칙, 품질 기준
│   ├── GLOSSARY.md            ← 네이밍, 케이스, 선언 방식
│   ├── TASK_TEMPLATE.md       ← 작업 요청 포맷
│   ├── CHECKLISTS.md          ← 작업 유형별 체크리스트
│   └── COMMIT.md              ← 커밋 메시지 형식, 분류, 그룹핑
├── template/                  ← 프로젝트 템플릿
│   ├── package.json           ← 의존성 + 스크립트 + lint-staged
│   ├── eslint.config.mjs      ← ESLint flat config (ESLint 9+)
│   ├── .prettierrc            ← Prettier 규칙
│   ├── .prettierignore        ← Prettier 제외 대상
│   └── README.md              ← 템플릿 사용법 상세
└── scripts/
    ├── init.sh                ← create-next-app + 템플릿 + 에이전트 문서 자동화
    └── setup-cursor.sh        ← Cursor rules/commands 자동 생성 (postinstall)
```

## Tech Stack

| 카테고리 | 선택 |
|----------|------|
| Framework | Next.js (App Router) + Turbopack |
| Language | TypeScript (strict) |
| Styling | Tailwind CSS + shadcn/ui |
| State | TanStack Query (서버) + Zustand (클라이언트) |
| Form | React Hook Form + Zod |
| Auth | Auth.js |
| DB | Firebase |
| Test | Jest + Testing Library + Playwright |
| Hosting | Vercel |
| PM | pnpm |

> 상세 스택 및 선택 이유 → `docs/70-stack.md`

## Architecture

Feature-based 구조. `app/ → features/ → shared/` 단방향 의존.

```
src/
├── app/           # Next.js 라우팅 (얇게 유지)
├── features/      # 기능 단위 모듈 (auth/, profile/ ...)
└── shared/        # 범용 UI, 훅, 유틸, 타입
```

> 상세 구조 및 규칙 → `docs/50-architecture-guidelines.md`

## Quick Start

### 자동 세팅 (권장)

```bash
# 1. 이 레포를 클론
git clone https://github.com/ire4564/ai-ready-project-toolkit.git

# 2. 프로젝트 생성 (toolkit과 같은 레벨에 생성됨)
cd ai-ready-project-toolkit
bash scripts/init.sh my-new-project

# 3. 개발 시작
cd ../my-new-project && pnpm dev
```

`init.sh`는 **toolkit 폴더와 같은 레벨(부모 디렉토리)**에 새 프로젝트를 생성합니다:

```
parent/
├── ai-ready-project-toolkit/   ← 이 레포
└── my-new-project/             ← 여기에 생성됨
```

자동으로 수행하는 작업:
1. `create-next-app`으로 Next.js 프로젝트 생성 (TypeScript, Tailwind, App Router, src/)
2. `template/` 설정 파일 덮어쓰기 (package.json, ESLint, Prettier)
3. `agent/` 컨텍스트 문서 복사
4. Feature-based 폴더 구조 생성 (`src/features/`, `src/shared/`)
5. `tsconfig.json` path alias 설정 (`@features/*`, `@shared/*`)
6. `pnpm install` — Cursor 설정 자동 생성 포함

### 수동 복사

```bash
# 템플릿 파일 복사
cp template/package.json        your-project/
cp template/eslint.config.mjs   your-project/
cp template/.prettierrc         your-project/
cp template/.prettierignore     your-project/

# 에이전트 문서 복사 (Cursor 자동 설정에 필요)
cp agent/PROJECT_CONTEXT.md     your-project/
cp -r agent/                    your-project/agent/

# setup-cursor 스크립트 복사
mkdir -p your-project/scripts
cp scripts/setup-cursor.sh      your-project/scripts/

cd your-project && pnpm install
```

> `agent/` 폴더가 있어야 `postinstall`에서 Cursor 설정(`.cursor/rules/`, `.cursor/commands/`)이 자동 생성됩니다.

## How to Use

### 사람이 읽을 때

`docs/00-overview.md`부터 시작하면 개발 철학 → 원칙 → 규칙 → 예시 → 아키텍처 → 워크플로우 순으로 이해할 수 있습니다.

### AI 에이전트에게 줄 때

`agent/DECISIONS.md`가 에이전트의 진입점입니다. 읽기 순서:

1. `PROJECT_CONTEXT.md` — 스택, 아키텍처, 규칙 (모든 작업의 기반)
2. `GLOSSARY.md` — 네이밍, 케이스, 선언 방식
3. `TASK_TEMPLATE.md` — 작업 요청 포맷
4. `CHECKLISTS.md` — 작업 유형별 체크리스트
5. `COMMIT.md` — 커밋 메시지 형식

프로젝트 루트에 복사하면 대부분의 AI 코딩 에이전트가 자동으로 인식합니다:

```bash
cp agent/PROJECT_CONTEXT.md ./your-project/
```

### 템플릿을 가져올 때

`template/` 폴더의 파일을 프로젝트 루트에 복사하고 `pnpm install`로 의존성을 설치합니다.
자세한 내용은 `template/README.md`를 참고하세요.

## Document Conventions

이 레포의 모든 규칙 문서는 아래 태그를 사용합니다:

| Tag | 의미 |
|-----|------|
| `MUST` | 반드시 지킬 것 |
| `MUST NOT` | 절대 하면 안 됨 |
| `SHOULD` | 권장 (합리적 이유가 있으면 예외) |
| `MAY` | 선택 |
