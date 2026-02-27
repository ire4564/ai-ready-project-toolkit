# 40 — Examples

> Before/After로 보는 좋은 코드 예시.

---

## 1. 타입 안전한 API 호출

### Before ✗

```typescript
const fetchUser = async (id: string) => {
  const res = await fetch(`/api/users/${id}`);
  const data = await res.json();
  return data; // any 타입, 런타임 검증 없음
};
```

### After ✓

```typescript
interface User {
  id: string;
  name: string;
  email: string;
  role: "admin" | "user";
}

interface ApiResponse<T> {
  data: T;
  meta: { timestamp: string };
}

const fetchUser = async (id: string): Promise<User> => {
  const res = await fetch(`/api/users/${id}`);

  if (!res.ok) {
    throw new ApiError(`Failed to fetch user: ${res.status}`, res.status);
  }

  const json: ApiResponse<User> = await res.json();
  return json.data;
};
```

**왜?** — 응답 타입을 명시적으로 정의하면 자동완성과 타입 체크가 가능해지고, 제네릭 `ApiResponse<T>`로 응답 구조를 통일할 수 있다.

---

## 2. 컴포넌트 Props 설계

### Before ✗

```tsx
const Button = (props: any) => {
  return (
    <button
      style={{ color: props.primary ? "blue" : "gray" }}
      onClick={props.onClick}
    >
      {props.children}
    </button>
  );
};
```

### After ✓

```tsx
interface ButtonProps {
  variant?: "primary" | "secondary" | "ghost";
  size?: "sm" | "md" | "lg";
  isLoading?: boolean;
  children: React.ReactNode;
  onClick?: () => void;
}

const Button = ({
  variant = "primary",
  size = "md",
  isLoading = false,
  children,
  onClick,
}: ButtonProps) => {
  return (
    <button
      className={cn(buttonVariants({ variant, size }))}
      disabled={isLoading}
      onClick={onClick}
    >
      {isLoading ? <Spinner size={size} /> : children}
    </button>
  );
};
```

**왜?** — 명확한 Props 인터페이스는 자동완성과 타입 체크를 가능하게 하고, 기본값은 구조 분해 할당에서 설정한다.

---

## 3. 상태 관리 — 서버 상태 분리

### Before ✗

```tsx
const UserList = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    setLoading(true);
    fetch("/api/users")
      .then((res) => res.json())
      .then((data) => setUsers(data))
      .catch((err) => setError(err))
      .finally(() => setLoading(false));
  }, []);

  // ...
};
```

### After ✓

```tsx
const useUsers = () => {
  return useQuery({
    queryKey: ["users"],
    queryFn: () => fetchUsers(),
    staleTime: 5 * 60 * 1000,
  });
};

const UserList = () => {
  const { data: users, isLoading, error } = useUsers();

  if (isLoading) {
    return <UserListSkeleton />;
  }
  if (error) {
    return <ErrorFallback error={error} />;
  }

  return (
    <ul>
      {users.map((user) => (
        <UserCard key={user.id} user={user} />
      ))}
    </ul>
  );
};
```

**왜?** — 서버 상태는 TanStack Query에 위임한다. 캐싱, 재시도, 백그라운드 리페치를 직접 구현할 필요가 없다.

---

## 4. 에러 처리 패턴

### Before ✗

```typescript
try {
  const result = await riskyOperation();
  return result;
} catch (e) {
  // 에러를 삼킴
  return null;
}
```

### After ✓

```typescript
type AppError = Error & { code: string; statusCode: number };

const createAppError = (message: string, code: string, statusCode = 500): AppError =>
  Object.assign(new Error(message), { code, statusCode });

const isAppError = (error: unknown): error is AppError =>
  error instanceof Error && "code" in error;

const safeOperation = async <T>(
  operation: () => Promise<T>,
  context: string,
): Promise<T> => {
  try {
    return await operation();
  } catch (error) {
    if (isAppError(error)) {
      logger.warn(`[${context}] ${error.code}: ${error.message}`);
      throw error;
    }

    logger.error(`[${context}] Unexpected error`, { error });
    throw createAppError("예기치 않은 오류가 발생했습니다.", "UNEXPECTED_ERROR");
  }
};
```

**왜?** — 에러를 삼키면 디버깅이 불가능하다. 커스텀 에러 클래스로 종류를 구분하고, 사용자 메시지와 개발자 로그를 분리한다.

---

## 5. 조건부 렌더링

### Before ✗

```tsx
// 0이면 "0"이 렌더링됨
{count && <Badge count={count} />}

// 중첩된 삼항 — 읽기 어려움
{isAdmin ? <AdminPanel /> : isUser ? <UserPanel /> : <GuestPanel />}
```

### After ✓

```tsx
// 명시적 비교
{count > 0 ? <Badge count={count} /> : null}

// early return으로 분리
const RolePanel = ({ role }: { role: Role }) => {
  if (role === "admin") {
    return <AdminPanel />;
  }
  if (role === "user") {
    return <UserPanel />;
  }
  return <GuestPanel />;
};
```

**왜?** — `&&` 연산자는 falsy 값(0, "")을 렌더링할 수 있다. 중첩 삼항보다 early return이 읽기 쉽다.
