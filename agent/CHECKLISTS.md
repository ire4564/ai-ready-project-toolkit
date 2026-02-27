# CHECKLISTS

작업 유형별 체크리스트. 해당 작업 시 적용한다.

## API 엔드포인트

- 경로/메서드 확정
- Request/Response 스키마 정의
- 인증/인가 요구사항 확인
- 에러 케이스 목록 작성
- request body 검증
- 적절한 HTTP 상태 코드 반환
- 에러 포맷 통일
- 민감 데이터 필터링 (비밀번호, 토큰 응답 금지)
- typecheck 통과
- 정상/에러 케이스 테스트

## 컴포넌트

- Props interface 설계
- 기존 컴포넌트 재사용 가능 여부 확인
- Props 타입 명시, 기본값은 구조 분해에서 설정
- 이벤트 핸들러: handleXxx
- 조건부 렌더링: 삼항 또는 early return (&& 금지)
- key에 고유 ID (index 금지)
- 시맨틱 HTML + ARIA
- typecheck 통과
- 인터랙션 테스트
- 반응형 확인 (모바일/데스크톱)
- 키보드 네비게이션 확인

## 상태 관리

[TanStack Query]
- queryKey 네이밍 일관성
- staleTime / gcTime 설정
- 에러/로딩 상태 UI 처리
- 낙관적 업데이트 필요 여부 검토
- invalidateQueries 캐시 무효화 전략

[Zustand]
- 전역 상태 필요성 재확인 (props/context 우선)
- 스토어 슬라이스 분리
- selector로 필요한 상태만 구독

## 성능

- 불필요한 리렌더링 확인
- 이미지 최적화 + lazy loading
- 코드 스플리팅
- 번들 사이즈 확인
- 메모이제이션은 측정 후 적용

## 접근성

- 시맨틱 HTML
- 이미지에 alt 텍스트
- 폼 요소에 label 연결
- 키보드로 모든 인터랙션 가능
- 색상 대비 4.5:1 이상
- 모달: 포커스 트랩 + ESC 닫기

## 보안

- dangerouslySetInnerHTML 금지
- CSRF 토큰 확인
- 시크릿은 환경 변수 (코드 하드코딩 금지)
- .env는 .gitignore 포함
- API 응답에 민감 정보 미포함

## PR 제출 전

- [ ] typecheck 통과
- [ ] 테스트 전체 통과
- [ ] 빌드 성공
- [ ] console.log 제거
- [ ] 불필요한 주석 제거
- [ ] Conventional Commits 준수
- [ ] PR 설명 작성 (What / Why / How)
