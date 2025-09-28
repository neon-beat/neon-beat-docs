# Neon Beat documentation

## Brief 

This repository contains basic documentation about the Neon Beat blindtest.
This repository has been created during the early steps of Neon Beat
development, so it contains documentation about both the early desired
features and the resulting architecture decisions.

## Generating and using the docs

The repository contains both textual documentation and graphs
- the textual documentation can be reviewed directly in any text viewer, or
  better, markdown viewer
- the graphs can be generated from their textual descriptions thanks to the
  root Makefile, just type `make` and it will generate .png files

## Requirements

The Makefile uses PlantUML (a Java JAR) which in turn needs Graphviz's
`dot` executable to render some diagrams. Before running `make` ensure you
have the following installed on your system:

- Java (JRE) - to run `plantuml.jar`
- Graphviz (`dot`) - required by PlantUML to generate certain graph types

Example install commands:

On Debian/Ubuntu:

```bash
sudo apt update
sudo apt install -y default-jre graphviz
```

On Fedora/CentOS/RHEL:

```bash
sudo dnf install -y java-17-openjdk graphviz
```

On macOS with Homebrew:

```bash
brew install openjdk graphviz
```

On Windows with winget (Windows 10/11):

```powershell
winget install --id OpenJDK.OpenJDK.17
winget install --id Graphviz.Graphviz
```

On Windows with Chocolatey (https://chocolatey.org/):

```powershell
choco install -y openjdk graphviz
```

After installing these, run `make` again in the repository root to generate
the diagrams.
