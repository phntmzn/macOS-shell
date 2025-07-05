#!/bin/bash

APP_NAME="MyShellApp"
APP_DIR="$HOME/Desktop/$APP_NAME.app"
CONTENTS_DIR="$APP_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"

# Create bundle folders
mkdir -p "$MACOS_DIR"

# Create Info.plist
cat > "$CONTENTS_DIR/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundleDisplayName</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.example.$APP_NAME</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleExecutable</key>
    <string>run</string>
  </dict>
</plist>
EOF

# Create the executable
cat > "$MACOS_DIR/run" <<'EOF'
#!/bin/bash
# Launch Terminal and run your shell command
osascript -e 'tell application "Terminal" to do script "echo Hello from MyShellApp!; bash"'
EOF

# Make the script executable
chmod +x "$MACOS_DIR/run"

echo "✅ $APP_NAME created at: $APP_DIR"
