#!/usr/bin/env python3

import os
import sys
import subprocess


def get_shared_objects(file_path):
    try:
        result = subprocess.run(['readelf', '-d', file_path], capture_output=True, text=True)
        lines = result.stdout.splitlines()
        dependencies = {line.split('[')[1].split(']')[0] for line in lines if 'Shared library' in line}
        return dependencies
    except Exception as e:
        # print(f"Error processing {file_path}: {e}")
        return set()


def collect_dependencies(path):
    all_dependencies = set()
    if os.path.isfile(path):
        all_dependencies.update(get_shared_objects(path))
    elif os.path.isdir(path):
        for root, _, files in os.walk(path):
            for file in files:
                file_path = os.path.join(root, file)
                if os.path.isfile(file_path):
                    file_dependencies = get_shared_objects(file_path)
                    all_dependencies.update(file_dependencies)
    else:
        print(f"Invalid path: {path}")
    return all_dependencies


def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory_path>")
        sys.exit(1)

    directory = sys.argv[1]
    dependencies = collect_dependencies(directory)
    for dep in sorted(dependencies):
        print(dep)


if __name__ == "__main__":
    main()
