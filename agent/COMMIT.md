# COMMIT

커밋 메시지는 한글로 작성한다.
변경사항을 논리적인 단위로 분류하여 각각 별도 커밋한다.
모든 커밋은 작업 내용을 구체적으로 서술한다.

## 형식

```
<type>(<scope>): <한글 설명>

- 구체적인 변경 내용 1
- 구체적인 변경 내용 2

[optional footer]
```

### type

feat — 새 기능 추가
fix — 버그 수정
ui — 컴포넌트 생성
refactor — 기능 변경 없이 코드 구조 개선
style — 포맷팅, CSS 변경 (동작 변경 없음)
chore — 의존성, 설정, 빌드
docs — 문서 변경
test — 테스트 추가/수정
perf — 성능 개선
revert — 이전 커밋 되돌리기

### scope

변경 대상 모듈, 도메인, 또는 기능 영역을 명시한다.
프로젝트 구조에 따라 자유롭게 정한다.
예: auth, user, article, api, ui, config 등

### 설명 규칙

- MUST: 무엇을 왜 변경했는지 구체적으로 작성
- MUST NOT: "수정", "업데이트", "변경" 같은 모호한 단어만 사용
- body에 변경 내용을 항목별로 기술

### footer (선택)

- BREAKING CHANGE: 단절적 변경 시 필수 (type 뒤에 ! 추가)
- Closes #이슈번호: 관련 이슈 연결
- Refs: 참조 커밋 SHA

## 예시

```
feat(api)!: API 응답 포맷 통일

- 모든 엔드포인트 응답을 { data, meta, error } 구조로 변경

BREAKING CHANGE: API 응답 구조가 변경되어 클라이언트 파싱 로직 수정 필요
```

## 분류 순서

변경 파일을 아래 순서로 그룹핑 → 그룹별 별도 커밋.
해당 파일 없으면 건너뛴다.

1. `chore` — package.json, *-lock.*, pnpm-lock.yaml
2. `chore` — *.config.*, tsconfig.*, .prettierrc*
3. `style` — *.css, *.scss, *.less, *.module.css
4. `refactor` — *.types.ts, *.d.ts, types/
5. `feat` — 상수, 설정 파일
6. `feat` — 유틸리티, 헬퍼, API 클라이언트
7. `feat|refactor` — UI 컴포넌트
8. `feat|refactor` — 도메인 모델, 비즈니스 로직
9. `feat|refactor` — 페이지, 라우트
10. `test` — *.test.*, *.spec.*, *.unit.spec.*
11. `docs` — *.md, docs/
12. `chore` — 나머지

새 파일 → feat, 기존 수정 → refactor, 버그 수정 → fix

## 규칙

- 여러 분류에 걸치면 가장 구체적인 분류에 포함
- lock 파일은 package.json과 같은 커밋
- .env 커밋 금지 (.env.example만 허용)
- console.log 포함 파일은 커밋 전 제거
- staging 파일 없으면 커밋 생성하지 않음
- BREAKING CHANGE가 있으면 type 뒤에 ! 추가하고 footer에 상세 기술
