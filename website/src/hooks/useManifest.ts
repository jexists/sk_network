import { useEffect, useMemo, useState } from "react";
import type { CategoryFilter, FileNode, Manifest } from "../types";

export function useManifest(basePath: string) {
  const [manifest, setManifest] = useState<Manifest | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(`${basePath}content/manifest.json`)
      .then((r) => {
        if (!r.ok) throw new Error(`manifest.json 로드 실패 (${r.status})`);
        return r.json();
      })
      .then((data: Manifest) => setManifest(data))
      .catch((e) => setError(String(e)))
      .finally(() => setLoading(false));
  }, [basePath]);

  return { manifest, loading, error };
}

function matchesSearch(node: FileNode, query: string): boolean {
  return node.name.toLowerCase().includes(query.toLowerCase());
}

function filterTree(
  nodes: FileNode[],
  query: string,
  category: CategoryFilter
): FileNode[] {
  const result: FileNode[] = [];

  for (const node of nodes) {
    if (node.type === "folder") {
      const filteredChildren = filterTree(node.children ?? [], query, category);
      if (filteredChildren.length > 0) {
        result.push({ ...node, children: filteredChildren });
      }
    } else {
      const passesSearch = !query || matchesSearch(node, query);
      const passesCategory =
        category === "전체" ||
        (node.tags ?? [] as string[]).includes(category as string);
      if (passesSearch && passesCategory) {
        result.push(node);
      }
    }
  }

  return result;
}

export function useFilteredTree(
  manifest: Manifest | null,
  query: string,
  category: CategoryFilter
): FileNode[] {
  return useMemo(() => {
    if (!manifest) return [];
    if (!query && category === "전체") return manifest.tree;
    return filterTree(manifest.tree, query, category);
  }, [manifest, query, category]);
}

/** 전체 파일 플랫 리스트 (pair 조회용) */
export function buildFileIndex(nodes: FileNode[]): Map<string, FileNode> {
  const map = new Map<string, FileNode>();
  function walk(ns: FileNode[]) {
    for (const n of ns) {
      if (n.type !== "folder") map.set(n.path, n);
      if (n.children) walk(n.children);
    }
  }
  walk(nodes);
  return map;
}
