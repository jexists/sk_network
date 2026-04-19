interface Props {
  convertedPath: string;
  basePath: string;
}

export function NotebookView({ convertedPath, basePath }: Props) {
  const src = `${basePath}${convertedPath}`;
  return (
    <div className="notebook-view">
      <iframe
        src={src}
        title="notebook"
        className="notebook-frame"
        sandbox="allow-scripts allow-same-origin"
      />
      <style>{`
        .notebook-view { flex: 1; display: flex; flex-direction: column; height: 100%; }
        .notebook-frame { flex: 1; width: 100%; border: none; background: #fff; }
      `}</style>
    </div>
  );
}
