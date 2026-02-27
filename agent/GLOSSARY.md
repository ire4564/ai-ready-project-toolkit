# GLOSSARY

여기에 없는 패턴을 임의로 만들지 않는다.

## 케이스

- 변수/함수: camelCase
- 상수: UPPER_SNAKE_CASE
- 컴포넌트/클래스: PascalCase
- 타입 (props): interface
- 타입 (그 외): type
- 디렉토리: kebab-case
- 파일 (컴포넌트): PascalCase.tsx
- 파일 (hooks): use~.ts (camelCase)
- 파일 (utils, store 등): camelCase.ts
- 환경 변수: UPPER_SNAKE_CASE
- 브랜치: type/kebab-case
- Enum 대체: { KEY: "value" } as const

## 상수 관리

- 상수가 사용되는 디렉토리 내에 const 파일을 선언하여 export

## 컴포넌트 선언

- 기본: export default function ComponentName
- default export 불가 시: 화살표 함수
- 스타일 파일 분리하지 않고 컴포넌트 파일에 통합

## Boolean 접두사

- is(상태), has(소유), should(조건), can(능력)

## 이벤트 핸들러

- handleXxx: 함수 정의/선언/호출 시
- onXxx: Props 전달 시에만


## HTTP 상태 코드

- 2xx: 200(성공) 201(생성) 204(본문없음)
- 4xx: 400(검증실패) 401(인증) 403(권한) 404(없음) 409(충돌) 422(비즈니스실패)
- 5xx: 500(서버오류)
