import { useState } from "react";
import type { FileNode } from "../types";

const FILE_ICON: Record<string, string> = {
  notebook: "📓",
  pdf: "📄",
  ".py": "🐍",
  ".sql": "🗄️",
  ".md": "📝",
  ".txt": "📃",
  ".csv": "📊",
};

function fileIcon(node: FileNode): string {
  if (node.type === "notebook") return "📓";
  if (node.type === "pdf") return "📄";
  return FILE_ICON[node.ext ?? ""] ?? "📃";
}

interface NodeProps {
  node: FileNode;
  selectedPath: string | null;
  onSelect: (node: FileNode) => void;
  depth: number;
}

function TreeNode({ node, selectedPath, onSelect, depth }: NodeProps) {
  const [open, setOpen] = useState(depth < 2);

  if (node.type === "folder") {
    return (
      <div>
        <button
          className="tree-folder"
          style={{ paddingLeft: `${8 + depth * 14}px` }}
          onClick={() => setOpen((o) => !o)}
        >
          <span className="folder-arrow">{open ? "▾" : "▸"}</span>
          <span className="folder-icon">{open ? "📂" : "📁"}</span>
          <span className="node-name">{node.name}</span>
        </button>
        {open && (
          <div>
            {(node.children ?? []).map((child) => (
              <TreeNode
                key={child.path}
                node={child}
                selectedPath={selectedPath}
                onSelect={onSelect}
                depth={depth + 1}
              />
            ))}
          </div>
        )}
      </div>
    );
  }

  const isSelected = node.path === selectedPath;
  return (
    <button
      className={`tree-file ${isSelected ? "selected" : ""}`}
      style={{ paddingLeft: `${8 + depth * 14}px` }}
      onClick={() => onSelect(node)}
    >
      <span className="file-icon">{fileIcon(node)}</span>
      <span className="node-name">{node.name}</span>
      <span className="tag-list">
        {(node.tags ?? []).map((tag) => (
          <span key={tag} className={`tag tag-${tag}`}>{tag}</span>
        ))}
      </span>
    </button>
  );
}

interface Props {
  nodes: FileNode[];
  selectedPath: string | null;
  onSelect: (node: FileNode) => void;
}

export function FileTree({ nodes, selectedPath, onSelect }: Props) {
  if (nodes.length === 0) {
    return <p className="tree-empty">검색 결과 없음</p>;
  }
  return (
    <div className="file-tree">
      {nodes.map((node) => (
        <TreeNode
          key={node.path || node.name}
          node={node}
          selectedPath={selectedPath}
          onSelect={onSelect}
          depth={0}
        />
      ))}
      <style>{`
        .file-tree { padding: 6px 0; }
        .tree-empty {
          color: var(--text-muted);
          font-size: 0.85rem;
          padding: 20px 16px;
        }
        .tree-folder, .tree-file {
          display: flex;
          align-items: center;
          gap: 5px;
          width: 100%;
          text-align: left;
          background: none;
          border: none;
          color: var(--text);
          font-size: 0.83rem;
          padding-top: 4px;
          padding-bottom: 4px;
          padding-right: 8px;
          cursor: pointer;
          border-radius: 4px;
          line-height: 1.4;
        }
        .tree-folder:hover { background: var(--bg3); }
        .tree-file:hover { background: var(--bg3); }
        .tree-file.selected { background: color-mix(in srgb, var(--accent) 18%, transparent); color: var(--accent-hover); }
        .folder-arrow { width: 10px; color: var(--text-muted); font-size: 0.7rem; }
        .folder-icon, .file-icon { flex-shrink: 0; }
        .node-name { flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .tag-list { display: flex; gap: 2px; flex-shrink: 0; }
      `}</style>
    </div>
  );
}
