# 50 — Architecture Guidelines

> Feature-based 구조. Next.js App Router에 최적화.

---

## 폴더 구조

```
src/
├── app/                        # Next.js 라우팅 (얇게 유지)
│   ├── layout.tsx
│   ├── page.tsx
│   ├── providers.tsx
│   ├── global.css
│   ├── (routes)/               # 라우트 그룹
│   │   ├── (auth)/
│   │   │   └── login/page.tsx
│   │   └── (main)/
│   │       ├── dashboard/page.tsx
│   │       └── profile/page.tsx
│   └── api/                    # API Route Handlers
├── features/                   # 기능 단위 모듈
│   ├── auth/
│   │   ├── components/         # 기능 전용 컴포넌트
│   │   │   └── LoginForm.tsx
│   │   ├── hooks/              # 기능 전용 훅
│   │   │   └── useAuth.ts
│   │   ├── api.ts              # API 통신
│   │   ├── auth.types.ts       # 타입 정의
│   │   └── index.ts            # Public API
│   └── profile/
│       ├── components/
│       ├── hooks/
│       ├── api.ts
│       ├── profile.types.ts
│       └── index.ts
├── shared/                     # 공유 코드
│   ├── components/             # 범용 UI (Button, Modal, Input)
│   ├── hooks/                  # 공용 훅 (useDebounce, useMediaQuery)
│   ├── lib/                    # 유틸리티, 헬퍼
│   ├── types/                  # 공유 타입
│   └── config/                 # 환경 변수, 상수
└── styles/                     # 글로벌 스타일
```

---

## 핵심 규칙

### MUST — 의존성 방향은 단방향

```
app → features → shared
```

```typescript
// ✓ app → features
import { LoginForm } from "@features/auth";

// ✓ features → shared
import { Button } from "@shared/components";

// ✗ shared → features (역방향)
import { useAuth } from "@features/auth";

// ✗ features/auth → features/profile (feature 간 직접 참조)
import { useProfile } from "@features/profile";
```

### MUST — 각 feature는 Public API(`index.ts`)로만 접근

```typescript
// ✗ 내부 파일 직접 import
import { LoginForm } from "@features/auth/components/LoginForm";

// ✓ Public API
import { LoginForm } from "@features/auth";
```

```typescript
// features/auth/index.ts
export { LoginForm } from "./components/LoginForm";
export { useAuth } from "./hooks/useAuth";
export type { User, AuthState } from "./auth.types";
```

### MUST NOT — feature 간 직접 import 금지

feature 간 데이터가 필요하면 `app/` 레이어에서 조합한다.

```typescript
// ✗ features/profile에서 features/auth 직접 참조
import { useAuth } from "@features/auth";

// ✓ app 레이어(page)에서 조합
import { useAuth } from "@features/auth";
import { ProfileCard } from "@features/profile";

export default function ProfilePage() {
  const { user } = useAuth();
  return <ProfileCard user={user} />;
}
```

---

## 레이어별 상세

### app/ — Next.js 라우팅

- 라우팅, 레이아웃, 프로바이더만 담당
- 비즈니스 로직을 넣지 않는다 — features를 조합만
- `page.tsx`는 얇게 유지: features에서 import하여 렌더링

### features/ — 기능 단위 모듈

- 하나의 비즈니스 기능을 캡슐화
- 예: `auth/`, `profile/`, `dashboard/`, `notification/`
- 내부 구조:

| 폴더/파일 | 역할 |
|-----------|------|
| `components/` | 기능 전용 컴포넌트 |
| `hooks/` | 기능 전용 훅 (API 호출, 상태 관리) |
| `api.ts` | API 통신 함수 |
| `*.types.ts` | 도메인 타입 + API 응답 타입 |
| `index.ts` | Public API export |

### shared/ — 공유 코드

- 특정 기능에 종속되지 않는 범용 코드
- 예: `Button`, `Modal`, `useDebounce`, `formatDate`
- 모든 레이어에서 참조 가능

| 폴더 | 역할 |
|------|------|
| `components/` | 범용 UI 컴포넌트 |
| `hooks/` | 공용 커스텀 훅 |
| `lib/` | 유틸리티, 헬퍼 함수 |
| `types/` | 공유 타입 정의 |
| `config/` | 환경 변수, 상수 |

---

## feature가 커질 때

feature 내부가 복잡해지면 하위 모듈로 분리한다.

```
features/
└── auth/
    ├── components/
    │   ├── LoginForm.tsx
    │   ├── SignupForm.tsx
    │   └── SocialLoginButton.tsx
    ├── hooks/
    │   ├── useAuth.ts
    │   └── useOAuth.ts
    ├── api.ts
    ├── auth.types.ts
    ├── auth.constants.ts
    └── index.ts
```

feature가 너무 커지면 분리를 고려한다: `auth/` → `login/` + `signup/` + `oauth/`

---

## Next.js App Router 매핑

```
Next.js App Router              역할
─────────────────               ─────────
app/layout.tsx              →   프로바이더, 글로벌 레이아웃
app/(routes)/xxx/page.tsx   →   features 조합 (얇게 유지)
app/api/                    →   서버 API Route Handler
features/                   →   비즈니스 로직 캡슐화
shared/                     →   범용 코드
```

- 서버/클라이언트 컴포넌트 경계는 필요한 곳에서 `"use client"` 선언.
- `page.tsx`는 가능하면 서버 컴포넌트로 유지, 클라이언트 로직은 features 컴포넌트에 위임.
