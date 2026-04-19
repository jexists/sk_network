import { useEffect, useRef } from "react";
import hljs from "highlight.js";
import "highlight.js/styles/github-dark.css";

interface Props {
  content: string;
  ext: string;
  fileName?: string;
}

const EXT_LANG: Record<string, string> = {
  ".py": "python",
  ".sql": "sql",
  ".md": "markdown",
  ".txt": "plaintext",
  ".csv": "plaintext",
};

export function CodeView({ content, ext, fileName }: Props) {
  const codeRef = useRef<HTMLElement>(null);

  useEffect(() => {
    if (codeRef.current) {
      codeRef.current.removeAttribute("data-highlighted");
      hljs.highlightElement(codeRef.current);
    }
  }, [content]);

  const lang = EXT_LANG[ext] ?? "plaintext";

  return (
    <div className="code-view">
      {fileName && (
        <div className="code-toolbar">
          <span className="code-filename">{fileName}</span>
          <span className="code-lang">{lang}</span>
        </div>
      )}
      <div className="code-scroll">
        <pre className="code-pre">
          <code ref={codeRef} className={`language-${lang}`}>{content}</code>
        </pre>
      </div>
      <style>{`
        .code-view { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
        .code-toolbar {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 6px 14px;
          background: var(--bg2);
          border-bottom: 1px solid var(--border);
          font-size: 0.82rem;
        }
        .code-filename { color: var(--text); }
        .code-lang { color: var(--text-muted); }
        .code-scroll { flex: 1; overflow: auto; }
        .code-pre { margin: 0; font-size: 0.875rem; line-height: 1.6; padding: 16px; }
      `}</style>
    </div>
  );
}
