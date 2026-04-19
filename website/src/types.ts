export type FileTag =
  | "강의코드"
  | "강의자료"
  | "실습"
  | "답안"
  | "코딩테스트"
  | "프로젝트"
  | "참고자료";

export type FileType = "folder" | "notebook" | "pdf" | "file";

export interface FileNode {
  name: string;
  type: FileType;
  path: string;
  ext?: string;
  tags?: FileTag[];
  // notebook
  convertedPath?: string | null;
  // pdf
  pdfPath?: string;
  // code/text
  content?: string;
  // pair 비교
  pair?: string;
  answer?: string;
  // folder
  children?: FileNode[];
}

export interface Manifest {
  tree: FileNode[];
}

export type CategoryFilter = "전체" | FileTag;
