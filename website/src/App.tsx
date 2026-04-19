import { useState } from "react";
import { buildFileIndex, useFilteredTree, useManifest } from "./hooks/useManifest";
import { CategoryFilterBar } from "./components/CategoryFilter";
import { FileTree } from "./components/FileTree";
import { SearchBar } from "./components/SearchBar";
import { FileViewer } from "./components/FileViewer";
import type { CategoryFilter, FileNode } from "./types";
import "./App.css";

const BASE_PATH = import.meta.env.BASE_URL;

export default function App() {
  const { manifest, loading, error } = useManifest(BASE_PATH);
  const [query, setQuery] = useState("");
  const [category, setCategory] = useState<CategoryFilter>("전체");
  const [selectedFile, setSelectedFile] = useState<FileNode | null>(null);

  const filteredTree = useFilteredTree(manifest, query, category);
  const fileIndex = manifest ? buildFileIndex(manifest.tree) : new Map();

  if (loading) {
    return (
      <div className="loading-screen">
        <div className="spinner" />
        <p>파일 목록 불러오는 중...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="error-screen">
        <p>오류: {error}</p>
        <p className="error-hint">build_content.py를 먼저 실행하세요.</p>
      </div>
    );
  }

  return (
    <div className="app">
      <header className="app-header">
        <span className="logo">📂 sk_network</span>
        <SearchBar value={query} onChange={setQuery} />
      </header>

      <div className="category-bar">
        <CategoryFilterBar value={category} onChange={setCategory} />
      </div>

      <div className="app-body">
        <aside className="sidebar">
          <FileTree
            nodes={filteredTree}
            selectedPath={selectedFile?.path ?? null}
            onSelect={setSelectedFile}
          />
        </aside>

        <main className="viewer-area">
          {selectedFile ? (
            <FileViewer
              file={selectedFile}
              fileIndex={fileIndex}
              basePath={BASE_PATH}
            />
          ) : (
            <div className="empty-state">
              <span>👈 왼쪽에서 파일을 선택하세요</span>
            </div>
          )}
        </main>
      </div>
    </div>
  );
}
