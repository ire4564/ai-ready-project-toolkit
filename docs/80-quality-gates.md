# 80 — Quality Gates

> PR을 머지하기 전에 반드시 통과해야 하는 기준.

---

## CI Pipeline 필수 체크

| Gate | 명령어 | 통과 기준 |
|------|--------|-----------|
| **Type Check** | `tsc --noEmit` | 에러 0개 |
| **Lint** | `eslint .` | 에러 0개 |
| **Format** | `prettier --check .` | 포맷 불일치 0개 |
| **Unit Test** | `jest --ci` | 전체 통과 |
| **Build** | `next build` | 빌드 성공 |

---

## 테스트 기준

- **SHOULD** — 새 기능에는 테스트를 작성한다.
  - 유틸리티 함수: 단위 테스트
  - 커스텀 훅: `renderHook` 테스트
  - 컴포넌트: 사용자 인터랙션 기반 테스트 (Testing Library)

- **MAY** — 구현 시간이 오래 걸린다면 테스트는 생략할 수 있다.
  - 단, 핵심 비즈니스 로직(결제, 인증 등)과 공유 유틸리티는 테스트를 유지한다.

- **SHOULD** — 커버리지 목표: 유틸 90%+, 훅 80%+, 컴포넌트 70%+, 전체 75%+

- **MUST NOT** — 스냅샷 테스트에 의존하지 않는다.

---

## 번들 사이즈 기준

- **SHOULD** — 랜딩/정적 < 50KB, 대시보드/동적 < 150KB, 전체 초기 로드 < 200KB (gzipped)
- **MUST** — 번들 분석 정기 수행: `ANALYZE=true next build`

---

## 접근성 기준

- **SHOULD** — WCAG 2.1 AA 수준: 키보드 네비게이션, 스크린 리더 호환, 색상 대비 4.5:1, 포커스 인디케이터

---

## PR 제출 전 체크리스트

작업 유형별 상세 체크리스트 → [agent/CHECKLISTS.md](../agent/CHECKLISTS.md)
