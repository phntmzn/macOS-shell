#!/bin/bash

# === Configurable Parameters ===
TARGET_IP="172.16.10.10"
PORT="8081"
EXTENSIONS="php,html,txt"
THREADS=50
WORDLIST="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
EXCLUDED_CODES="403,404"
OUTPUT_FILE="dirsearch_output_${TARGET_IP//./_}_$PORT.txt"

# === Derived Variables ===
URL="http://$TARGET_IP:$PORT"

# === Check Dependencies ===
if ! command -v dirsearch &> /dev/null; then
    echo "[-] Error: dirsearch not found. Install it first."
    exit 1
fi

if [ ! -f "$WORDLIST" ]; then
    echo "[-] Error: Wordlist not found at $WORDLIST"
    exit 1
fi

# === Run dirsearch ===
echo "[*] Starting directory brute-force scan on $URL..."
dirsearch -u "$URL" \
    -e "$EXTENSIONS" \
    -w "$WORDLIST" \
    --exclude-status "$EXCLUDED_CODES" \
    --random-agents \
    -t "$THREADS" \
    --output "$OUTPUT_FILE"

# === Completion Message ===
echo "[+] Scan complete. Results saved to: $OUTPUT_FILE"
