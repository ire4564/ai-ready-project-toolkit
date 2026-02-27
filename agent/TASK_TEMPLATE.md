# TASK_TEMPLATE

작업 요청 시 아래 구조를 따른다.

```
Task: [제목]
Background: [1~3문장]
Goal: [완료 상태 정의]

Requirements:
  Must: ...
  Should: ...
  Could: ...

Constraints: ...

Approach:
  1. ...
  2. ...

Files:
  - path — 변경 이유

Risks:
  - [위험] → [대응]

DoD:
  - [ ] typecheck + lint 통과
  - [ ] 테스트 작성 및 통과
  - [ ] PR 생성
```

## 필드 설명

- Task: 작업 한 줄 요약
- Background: 왜 필요한지 맥락
- Goal: 이 작업이 끝나면 어떤 상태인지
- Requirements: Must(필수) / Should(권장) / Could(선택)
- Constraints: 변경 금지 사항, 기술적 제약
- Approach: 구현 순서 (번호 매기기)
- Files: 변경 대상 파일과 이유
- Risks: 예상 위험 → 대응 방안
- DoD: 완료 조건 체크리스트 (Quality Gates 기준)
