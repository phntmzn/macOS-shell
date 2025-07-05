#!/bin/bash

APP_NAME="${1:-MidiApp}"
DEST="$HOME/Desktop/$APP_NAME"
mkdir -p "$DEST"

cd "$DEST" || exit 1

# Create directory structure
mkdir -p src build

# CMakeLists.txt
cat > CMakeLists.txt <<EOF
cmake_minimum_required(VERSION 3.16)
project($APP_NAME)

set(CMAKE_CXX_STANDARD 17)

add_executable($APP_NAME
    src/main.cpp
)

# Link to CoreMIDI and CoreAudio
target_link_libraries($APP_NAME
    "-framework CoreMIDI"
    "-framework CoreAudio"
    "-framework CoreFoundation"
)
EOF

# main.cpp
cat > src/main.cpp <<EOF
#include <CoreMIDI/CoreMIDI.h>
#include <iostream>

int main() {
    std::cout << "🎹 Hello from $APP_NAME! MIDI initialized (dummy example)." << std::endl;

    MIDIClientRef client;
    OSStatus status = MIDIClientCreate(CFSTR("My MIDI Client"), nullptr, nullptr, &client);

    if (status != noErr) {
        std::cerr << "❌ Failed to create MIDI client." << std::endl;
        return 1;
    } else {
        std::cout << "✅ MIDI client created successfully." << std::endl;
    }

    MIDIClientDispose(client);
    return 0;
}
EOF

echo "✅ Project created at: $DEST"
echo "💡 To build:"
echo "   cd $DEST/build"
echo "   cmake .. && make"
