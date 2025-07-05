#!/bin/bash

# Framework name (default: MyFramework)
FRAMEWORK_NAME="${1:-MyFramework}"
PROJECT_DIR="$HOME/Desktop/$FRAMEWORK_NAME"
SRC_DIR="$PROJECT_DIR/Sources/$FRAMEWORK_NAME"

# Create directories
mkdir -p "$SRC_DIR"

# Initialize Swift package (makes xcodeproj)
cd "$PROJECT_DIR/.." || exit
swift package init --type=library --name "$FRAMEWORK_NAME"
cd "$PROJECT_DIR" || exit

# Write basic Swift source
cat > "$SRC_DIR/$FRAMEWORK_NAME.swift" <<EOF
public struct $FRAMEWORK_NAME {
    public init() {}
    public func hello() -> String {
        return "Hello from $FRAMEWORK_NAME!"
    }
}
EOF

# Create Info.plist
cat > "$PROJECT_DIR/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>com.example.$FRAMEWORK_NAME</string>
    <key>CFBundleName</key>
    <string>$FRAMEWORK_NAME</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
</dict>
</plist>
EOF

# Build the framework
swift build

# Generate .xcodeproj
swift package generate-xcodeproj

echo "✅ Framework '$FRAMEWORK_NAME' created at: $PROJECT_DIR"
echo "📁 Open with: open '$PROJECT_DIR/$FRAMEWORK_NAME.xcodeproj'"
