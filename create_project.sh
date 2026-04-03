#!/bin/bash

set -e

# Ask for project name
read -p "Enter project name :" project_name
read -p "Enter package name :" package_name
echo "The project is called $project_name and the package $package_name" 

# Directories 
mkdir -p "$project_name"/{data,scripts,tests}
mkdir -p "$project_name/src/$package_name"

echo "Directories created..."

# Files
> "$project_name/pyproject.toml"
> "$project_name/README.md"
> "$project_name/.gitignore"
> "$project_name/src/$package_name/__init__.py"
find "$project_name" -maxdepth 5 -not -path "*/.venv/*" > "$project_name/project_structure.txt"

echo "Files created..."

cat > "$project_name/pyproject.toml" <<EOF 
[project]
name = "$project_name"
version = "1.0.0"
EOF

echo "pyproject.toml updated !"

cat > "$project_name/README.md" <<EOF

Main infos about the project  : 
The current working directory is: $PWD
The project name is: "$project_name"
The package name is: "$package_name"
You are logged in as: $(whoami)

The structure of the current directory is : 
$(cat "$project_name/project_structure.txt")
EOF

echo "README.md updated !"

echo "Creating virtual environment..."

uv venv "$project_name/.venv"

echo "Project setup complete. You can work now :D"
