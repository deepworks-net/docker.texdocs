# LaTeX Build System

This directory contains a Docker-based LaTeX build system for compiling LaTex documentation.

## Features

- Containerized build environment with all required LaTeX packages
- Python-based build script with sensible defaults
- Support for configuration via YAML
- Watch mode for automatic recompilation on file changes
- Colored output with detailed logging
- Built-in support for BibTeX/BibLaTeX and makeindex
- Follows LaTeX/BibTeX best practices for academic documents

## Prerequisites

- Docker installed and running
- Basic knowledge of Docker commands

## Quick Start

### Using Docker Compose

The easiest way to use this build system is with Docker Compose. Add the following to your `docker-compose.yml` file:

```yaml
services:
  latex-builder:
    build:
      context: ./build-system
    volumes:
      - .:/workspace
    command: --watch  # Optional: enables watch mode
```

Then run:

```bash
docker-compose run latex-builder
```

### Using Docker Directly

1. Build the Docker image:

```bash
cd build-system
docker build -t cqr-latex-builder .
```

2. Run the container to compile your LaTeX document:

```bash
docker run --rm -v $(pwd):/workspace cqr-latex-builder
```

## Configuration

The build system supports configuration through a `config.yaml` file in the root directory. Here's an example:

```yaml
main_file: model.tex
output_dir: output
clean_auxiliary: true
bibtex_run: true
makeindex_run: false
latex_engine: pdflatex
latex_args:
  - -interaction=nonstopmode
  - -halt-on-error
  - -file-line-error
```

### Command Line Options

You can also configure the build process through command line options:

```
usage: build.py [-h] [--file FILE] [--output-dir OUTPUT_DIR] [--watch] [--clean] [--config CONFIG]

Build LaTeX documents for Conceptual Quantum Relativity

options:
  -h, --help            show this help message and exit
  --file FILE, -f FILE  Main LaTeX file to compile (overrides config)
  --output-dir OUTPUT_DIR, -o OUTPUT_DIR
                        Output directory (overrides config)
  --watch, -w           Watch for changes and recompile automatically
  --clean, -c           Clean auxiliary files
  --config CONFIG       Path to custom config file
```

## Watch Mode

Watch mode automatically recompiles your document when changes are detected:

```bash
docker run --rm -v $(pwd):/workspace cqr-latex-builder --watch
```

Press Ctrl+C to exit watch mode.

## LaTeX/BibTeX Best Practices

This build system implements LaTeX/BibTeX best practices for academic documents:

1. **Compilation Sequence**: The build system follows the recommended compilation sequence of pdflatex → bibtex → pdflatex → pdflatex (or equivalent with other LaTeX engines).

2. **Centralized Bibliography**: We recommend using a centralized `references.bib` file in the repository root or in a dedicated `references` directory to maintain consistency across documents.

3. **Bibliography Management**: The system supports both traditional BibTeX and the more modern BibLaTeX/Biber approach to bibliography management.

4. **Consistent Formatting**: Default settings ensure consistent document formatting across builds.

5. **Error Handling**: Clear error reporting helps identify and fix LaTeX syntax or reference issues.

## Advanced Usage

### Custom LaTeX Engines

You can use different LaTeX engines by specifying them in the configuration:

```yaml
latex_engine: xelatex  # Or lualatex, etc.
```

### BibLaTeX with Biber (Modern Alternative)

To use the more modern BibLaTeX with Biber instead of traditional BibTeX:

```yaml
bibliography:
  bibtex_run: false
  biblatex_run: true
  biber_minimal: true  # For faster processing
```

### Custom Build Pipeline

The build script handles a standard LaTeX build workflow. For more complex builds, consider extending the Python script or creating a custom build script that calls into this one.