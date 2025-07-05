#!/bin/bash

PACKAGE_NAME=${1:-mypackage}
AUTHOR="Your Name"
EMAIL="your@email.com"
VERSION="0.1.0"
DESCRIPTION="A short description of the package."

# Create package directory
mkdir -p $PACKAGE_NAME/$PACKAGE_NAME
mkdir -p $PACKAGE_NAME/tests

# Create __init__.py
touch $PACKAGE_NAME/$PACKAGE_NAME/__init__.py

# Create pyproject.toml
cat > $PACKAGE_NAME/pyproject.toml <<EOF
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"
EOF

# Create setup.cfg
cat > $PACKAGE_NAME/setup.cfg <<EOF
[metadata]
name = $PACKAGE_NAME
version = $VERSION
author = $AUTHOR
author_email = $EMAIL
description = $DESCRIPTION
long_description = file: README.md
long_description_content_type = text/markdown
url = https://github.com/yourusername/$PACKAGE_NAME
classifiers =
    Programming Language :: Python :: 3
    License :: OSI Approved :: MIT License
    Operating System :: OS Independent

[options]
packages = find:
python_requires = >=3.7
include_package_data = true

[options.package_data]
* = *.txt, *.md
EOF

# Create README
cat > $PACKAGE_NAME/README.md <<EOF
# $PACKAGE_NAME

$DESCRIPTION
EOF

# Create test stub
cat > $PACKAGE_NAME/tests/test_basic.py <<EOF
def test_import():
    import $PACKAGE_NAME
EOF

# Create LICENSE (MIT by default)
cat > $PACKAGE_NAME/LICENSE <<EOF
MIT License

Copyright (c) $(date +%Y) $AUTHOR

Permission is hereby granted, free of charge, to any person obtaining a copy...
EOF

# Done
echo "✅ Python package '$PACKAGE_NAME' scaffolded in: $PACKAGE_NAME/"
