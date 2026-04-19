interface Props {
  value: string;
  onChange: (v: string) => void;
}

export function SearchBar({ value, onChange }: Props) {
  return (
    <div className="search-bar">
      <span className="search-icon">🔍</span>
      <input
        type="text"
        placeholder="파일명 검색..."
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="search-input"
      />
      {value && (
        <button className="search-clear" onClick={() => onChange("")}>✕</button>
      )}
      <style>{`
        .search-bar {
          display: flex;
          align-items: center;
          flex: 1;
          max-width: 400px;
          background: var(--bg3);
          border: 1px solid var(--border);
          border-radius: 6px;
          padding: 0 10px;
          gap: 6px;
        }
        .search-icon { font-size: 0.85rem; }
        .search-input {
          flex: 1;
          background: transparent;
          border: none;
          outline: none;
          color: var(--text);
          font-size: 0.875rem;
          padding: 6px 0;
        }
        .search-input::placeholder { color: var(--text-muted); }
        .search-clear {
          background: none;
          border: none;
          color: var(--text-muted);
          cursor: pointer;
          font-size: 0.75rem;
          padding: 2px 4px;
        }
        .search-clear:hover { color: var(--text); }
      `}</style>
    </div>
  );
}
