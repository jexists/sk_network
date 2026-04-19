import type { CategoryFilter } from "../types";

const CATEGORIES: CategoryFilter[] = [
  "전체", "강의코드", "실습", "답안", "강의자료",
  "코딩테스트", "프로젝트", "참고자료",
];

interface Props {
  value: CategoryFilter;
  onChange: (v: CategoryFilter) => void;
}

export function CategoryFilterBar({ value, onChange }: Props) {
  return (
    <div className="cat-bar">
      {CATEGORIES.map((cat) => (
        <button
          key={cat}
          className={`cat-btn ${value === cat ? "active" : ""} ${cat !== "전체" ? `tag-${cat}` : ""}`}
          onClick={() => onChange(cat)}
        >
          {cat}
        </button>
      ))}
      <style>{`
        .cat-bar {
          display: flex;
          gap: 4px;
          padding: 6px 0;
          overflow-x: auto;
          scrollbar-width: none;
        }
        .cat-bar::-webkit-scrollbar { display: none; }
        .cat-btn {
          padding: 3px 10px;
          border-radius: 20px;
          border: 1px solid var(--border);
          background: var(--bg3);
          color: var(--text-muted);
          font-size: 0.8rem;
          cursor: pointer;
          white-space: nowrap;
          transition: all 0.15s;
        }
        .cat-btn:hover { color: var(--text); border-color: var(--text-muted); }
        .cat-btn.active {
          color: var(--text);
          border-color: var(--accent);
          background: color-mix(in srgb, var(--accent) 15%, transparent);
        }
      `}</style>
    </div>
  );
}
