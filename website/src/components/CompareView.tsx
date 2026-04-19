import type { FileNode } from "../types";
import { NotebookView } from "./NotebookView";
import { CodeView } from "./CodeView";

interface Props {
  left: FileNode;
  right: FileNode;
  basePath: string;
}

function renderPanel(node: FileNode, basePath: string) {
  if (node.type === "notebook" && node.convertedPath) {
    return <NotebookView convertedPath={node.convertedPath} basePath={basePath} />;
  }
  if (node.content !== undefined) {
    return <CodeView content={node.content} ext={node.ext ?? ""} />;
  }
  return <p className="no-preview">미리보기 없음</p>;
}

export function CompareView({ left, right, basePath }: Props) {
  const leftLabel = (left.tags ?? []).includes("실습") ? "✏️ 내 실습" : "📝 내 코드";
  const rightLabel = (right.tags ?? []).includes("강의코드") ? "📖 강의코드" : "📄 비교 파일";

  return (
    <div className="compare-view">
      <div className="compare-panel">
        <div className="compare-header">
          <span>{leftLabel}</span>
          <span className="compare-filename">{left.name}</span>
        </div>
        <div className="compare-body">{renderPanel(left, basePath)}</div>
      </div>
      <div className="compare-divider" />
      <div className="compare-panel">
        <div className="compare-header right">
          <span>{rightLabel}</span>
          <span className="compare-filename">{right.name}</span>
        </div>
        <div className="compare-body">{renderPanel(right, basePath)}</div>
      </div>
      <style>{`
        .compare-view {
          display: flex;
          flex: 1;
          overflow: hidden;
          height: 100%;
        }
        .compare-panel {
          flex: 1;
          display: flex;
          flex-direction: column;
          overflow: hidden;
          min-width: 0;
        }
        .compare-divider {
          width: 3px;
          background: var(--border);
          flex-shrink: 0;
        }
        .compare-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 6px 12px;
          background: var(--bg2);
          border-bottom: 1px solid var(--border);
          font-size: 0.82rem;
          font-weight: 600;
          color: var(--text);
          gap: 8px;
        }
        .compare-header.right { flex-direction: row-reverse; }
        .compare-filename {
          color: var(--text-muted);
          font-weight: 400;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
          max-width: 60%;
        }
        .compare-body { flex: 1; overflow: hidden; display: flex; flex-direction: column; }
        .no-preview { padding: 20px; color: var(--text-muted); font-size: 0.85rem; }
      `}</style>
    </div>
  );
}
