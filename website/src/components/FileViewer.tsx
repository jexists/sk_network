import { useState } from "react";
import type { FileNode } from "../types";
import { NotebookView } from "./NotebookView";
import { PdfView } from "./PdfView";
import { CodeView } from "./CodeView";
import { CompareView } from "./CompareView";

interface Props {
  file: FileNode;
  fileIndex: Map<string, FileNode>;
  basePath: string;
}

function getPairNode(file: FileNode, fileIndex: Map<string, FileNode>): FileNode | null {
  if (!file.pair) return null;
  // pair는 파일명이므로 같은 폴더 경로에서 찾기
  const dir = file.path.includes("/")
    ? file.path.substring(0, file.path.lastIndexOf("/"))
    : "";
  const pairPath = dir ? `${dir}/${file.pair}` : file.pair;
  return fileIndex.get(pairPath) ?? null;
}

function renderContent(file: FileNode, basePath: string) {
  if (file.type === "notebook") {
    if (file.convertedPath) {
      return <NotebookView convertedPath={file.convertedPath} basePath={basePath} />;
    }
    return <p className="viewer-msg">⚠️ 변환된 파일이 없습니다. build_content.py를 실행하세요.</p>;
  }
  if (file.type === "pdf" && file.pdfPath) {
    return <PdfView pdfPath={file.pdfPath} basePath={basePath} fileName={file.name} />;
  }
  if (file.content !== undefined) {
    return <CodeView content={file.content} ext={file.ext ?? ""} fileName={file.name} />;
  }
  return <p className="viewer-msg">이 파일 유형은 미리보기를 지원하지 않습니다.</p>;
}

export function FileViewer({ file, fileIndex, basePath }: Props) {
  const [tab, setTab] = useState<"content" | "compare">("content");
  const pairNode = getPairNode(file, fileIndex);
  const canCompare = !!pairNode;

  // 파일 바뀌면 탭 리셋
  const tabKey = file.path;

  return (
    <div className="file-viewer" key={tabKey}>
      <div className="viewer-tabs">
        <div className="viewer-tabs-left">
          <button
            className={`vtab ${tab === "content" ? "active" : ""}`}
            onClick={() => setTab("content")}
          >
            내용
          </button>
          {canCompare && (
            <button
              className={`vtab ${tab === "compare" ? "active" : ""}`}
              onClick={() => setTab("compare")}
            >
              ⇄ 강의코드 비교
            </button>
          )}
        </div>
        <div className="viewer-meta">
          <span className="viewer-filename">{file.name}</span>
          {(file.tags ?? []).map((tag) => (
            <span key={tag} className={`tag tag-${tag}`}>{tag}</span>
          ))}
        </div>
      </div>

      <div className="viewer-content">
        {tab === "content"
          ? renderContent(file, basePath)
          : pairNode && (
              <CompareView left={file} right={pairNode} basePath={basePath} />
            )}
      </div>

      <style>{`
        .file-viewer {
          display: flex;
          flex-direction: column;
          height: 100%;
          overflow: hidden;
        }
        .viewer-tabs {
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 0 12px;
          background: var(--bg2);
          border-bottom: 1px solid var(--border);
          gap: 8px;
          flex-shrink: 0;
        }
        .viewer-tabs-left { display: flex; }
        .vtab {
          padding: 8px 14px;
          background: none;
          border: none;
          border-bottom: 2px solid transparent;
          color: var(--text-muted);
          font-size: 0.85rem;
          cursor: pointer;
          transition: all 0.15s;
          white-space: nowrap;
        }
        .vtab:hover { color: var(--text); }
        .vtab.active { color: var(--accent); border-bottom-color: var(--accent); }
        .viewer-meta {
          display: flex;
          align-items: center;
          gap: 6px;
          overflow: hidden;
          padding: 4px 0;
        }
        .viewer-filename {
          font-size: 0.82rem;
          color: var(--text-muted);
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
          max-width: 300px;
        }
        .viewer-content {
          flex: 1;
          overflow: hidden;
          display: flex;
          flex-direction: column;
        }
        .viewer-msg {
          padding: 24px;
          color: var(--text-muted);
          font-size: 0.875rem;
        }
      `}</style>
    </div>
  );
}
