interface Props {
  pdfPath: string;
  basePath: string;
  fileName: string;
}

export function PdfView({ pdfPath, basePath, fileName }: Props) {
  const src = `${basePath}${pdfPath}`;
  return (
    <div className="pdf-view">
      <div className="pdf-toolbar">
        <a href={src} download={fileName} className="download-btn">⬇ 다운로드</a>
      </div>
      <iframe src={src} title={fileName} className="pdf-frame" />
      <style>{`
        .pdf-view { flex: 1; display: flex; flex-direction: column; height: 100%; }
        .pdf-toolbar {
          padding: 6px 12px;
          border-bottom: 1px solid var(--border);
          background: var(--bg2);
        }
        .download-btn {
          font-size: 0.82rem;
          color: var(--accent);
          text-decoration: none;
        }
        .download-btn:hover { text-decoration: underline; }
        .pdf-frame { flex: 1; width: 100%; border: none; }
      `}</style>
    </div>
  );
}
