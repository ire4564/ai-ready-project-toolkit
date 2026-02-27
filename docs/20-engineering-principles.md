# 20 — Engineering Principles

> 코드를 작성할 때 따르는 원칙들. 네이밍/선언 규칙 상세는 [GLOSSARY](../agent/GLOSSARY.md) 참조.

---

## 타입 & 안전성

- **MUST** — `strict: true`로 TypeScript를 사용한다.
  - 이유: 런타임 에러를 컴파일 타임에 잡는다.

- **MUST NOT** — `any` 타입을 사용하지 않는다.
  - 이유: 타입 시스템의 이점을 무력화한다.
  - 예외: 서드파티 타입이 부정확할 때만 `as unknown as T`로 우회.

- **SHOULD** — `unknown`을 `any` 대신 사용한다.
  - 이유: 타입 좁히기를 강제하여 안전한 코드를 유도한다.

- **MUST** — API 응답, 외부 데이터는 반드시 런타임 검증(Zod)을 거친다.
  - 이유: 타입은 컴파일 타임에만 존재한다.

---

## 네이밍

- **MUST** — 변수/함수 이름은 역할을 설명해야 한다.
  - 예: `data` ✗ → `userProfile` ✓

- **MUST** — boolean은 `is/has/should/can` 접두사.
  - 예: `loading` ✗ → `isLoading` ✓

- **MUST** — `handleXxx`(함수 정의/호출), `onXxx`(Props 전달 시에만).
  - 예:
    ```tsx
    const Foo = ({ onClick }) => {
      const handleClick = (event) => {
        doSomething();
        onClick(event);
      }
      return <button onClick={handleClick}>Bar</button>
    }
    ```

> 케이스 규칙, 파일/디렉토리 네이밍, 상수 관리 → [GLOSSARY](../agent/GLOSSARY.md)

---

## 함수 설계

- **MUST** — 조건문은 early return으로 작성한다. 중첩 if/else 금지.
  - 이유: 들여쓰기가 줄어들고 흐름이 명확해진다.
- **SHOULD** — 한 함수 = 한 가지 일, 30줄 이내.
- **MUST NOT** — 파라미터 3개 초과 시 객체로 묶는다.
- **SHOULD** — 순수 함수 선호, 부수 효과는 명시적으로 분리.

---

## 컴포넌트 설계

- **MUST** — 직관적인 인터페이스. Props만 보고 사용법을 알 수 있어야 한다.
  - 예: `<Modal isOpen onClose title>` ✓ / `<Modal flag1 cb data>` ✗

- **MUST** — 낮은 결합도. 데이터 페칭은 훅에 위임, 컴포넌트는 렌더링만.

- **SHOULD** — Compound Pattern 등 유연한 설계로 재사용성 확보.
  - 예:
    ```tsx
    <Select>
      <Select.Trigger />
      <Select.Content>
        <Select.Item value="a">A</Select.Item>
      </Select.Content>
    </Select>
    ```

- **SHOULD** — 내부 확장 시 인터페이스(Props) 변경 최소화.
- **SHOULD** — 가독성 우선, 과도한 추상화 금지.

> 선언 방식, 타입 선언(interface/type), 스타일 통합 → [GLOSSARY](../agent/GLOSSARY.md)

---

## 에러 처리

- **MUST** — 에러는 삼키지 않는다. catch에서 반드시 로깅 또는 상위 전파.
- **MUST** — 사용자 메시지 ≠ 개발자 메시지.
- **SHOULD** — 커스텀 에러 클래스로 종류 구분.

---

## 의존성

- **MUST** — 버전 exact 고정 (`^` 금지).
- **SHOULD** — 추가 전 "직접 구현하면 몇 줄?" 먼저 판단.
- **SHOULD** — 번들 사이즈는 `bundlephobia`로 확인 후 추가.

---

## 성능

- **MUST NOT** — 조기 최적화 금지. 측정 없는 최적화는 복잡성만 추가.
- **SHOULD** — 프로파일링 결과 기반으로 해결.
- **SHOULD** — 메모이제이션(`memo`, `useMemo`, `useCallback`)은 측정 후 적용.
