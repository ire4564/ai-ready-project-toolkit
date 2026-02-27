import path from "node:path";
import { fileURLToPath } from "node:url";
import js from "@eslint/js";
import { FlatCompat } from "@eslint/eslintrc";
import tseslint from "typescript-eslint";
import tanstackQuery from "@tanstack/eslint-plugin-query";
import importX from "eslint-plugin-import-x";
import unusedImports from "eslint-plugin-unused-imports";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
});

export default tseslint.config(
  // ── Next.js core-web-vitals (FlatCompat 래핑) ──
  ...compat.extends("next/core-web-vitals"),

  // ── TypeScript recommended ──
  ...tseslint.configs.recommended,

  // ── TanStack Query ──
  ...tanstackQuery.configs["flat/recommended"],

  // ── Global ignores ──
  {
    ignores: ["scripts/**/*", ".next/**", "node_modules/**", "coverage/**"],
  },

  // ── Main rules ──
  {
    plugins: {
      "import-x": importX,
      "unused-imports": unusedImports,
    },

    settings: {
      "import-x/resolver": {
        typescript: {
          project: "./tsconfig.json",
        },
      },
    },

    rules: {
      // ── TypeScript strict ──
      "@typescript-eslint/no-explicit-any": "error",
      "@typescript-eslint/array-type": ["error", { default: "array-simple" }],

      // ── Unused imports ──
      "@typescript-eslint/no-unused-vars": "off",
      "unused-imports/no-unused-imports": "warn",
      "unused-imports/no-unused-vars": [
        "warn",
        {
          vars: "all",
          varsIgnorePattern: "^_",
          args: "after-used",
          argsIgnorePattern: "^_",
        },
      ],

      // ── Parameter reassign 방지 (Zustand immer draft 예외) ──
      "no-param-reassign": [
        "error",
        {
          props: true,
          ignorePropertyModificationsFor: ["draft"],
        },
      ],

      // ── Sort imports (멤버 정렬만 담당, 선언 정렬은 import-x/order에 위임) ──
      "sort-imports": [
        "error",
        {
          ignoreCase: true,
          ignoreDeclarationSort: true,
          ignoreMemberSort: false,
          allowSeparatedGroups: true,
        },
      ],

      // ── Import order ──
      "import-x/order": [
        "error",
        {
          "newlines-between": "always",
          groups: [
            ["builtin", "external"],
            "internal",
            "parent",
            "sibling",
            "index",
            "type",
          ],
          pathGroups: [
            {
              pattern: "{react*,react*/**,next*,next*/**}",
              group: "external",
              position: "before",
            },
            {
              pattern: "@**",
              group: "internal",
              position: "after",
            },
          ],
          pathGroupsExcludedImportTypes: ["react", "next"],
          warnOnUnassignedImports: true,
          alphabetize: {
            order: "asc",
            caseInsensitive: true,
          },
        },
      ],
      "import-x/no-duplicates": "error",

      // ── React ──
      "react/jsx-no-useless-fragment": "warn",
      "react/jsx-sort-props": [
        "error",
        {
          callbacksLast: true,
          shorthandFirst: true,
          reservedFirst: true,
        },
      ],

      // ── Restrict relative parent imports (@ alias 사용 권장) ──
      "no-restricted-imports": [
        "warn",
        {
          patterns: [
            {
              group: ["../*", "../*/**"],
              message: "상대 경로 대신 @ 별칭을 사용해주세요.",
            },
          ],
        },
      ],

      // ── console.log 금지 ──
      "no-restricted-syntax": [
        "error",
        {
          selector:
            "CallExpression[callee.object.name='console'][callee.property.name='log']",
          message: "console.log는 삭제하고 커밋해주세요.",
        },
      ],
    },
  },
);
