#!/bin/bash

BIN="$1"

if [ ! -f "$BIN" ]; then
  echo "❌ File not found: $BIN"
  exit 1
fi

echo "🔍 Inspecting: $BIN"

# Read first 4 bytes: magic number
MAGIC=$(xxd -p -l 4 "$BIN")

case "$MAGIC" in
  cafebabe)
    echo "📦 Universal Binary (FAT)"
    echo "Reading fat_header..."
    
    # Read fat_header (8 bytes): magic + nfat_arch
    dd if="$BIN" bs=1 count=8 2>/dev/null | od -t x4 | head -n1 | awk '{
      magic=$2;
      nfat_arch=strtonum("0x"$3);
      printf "🔢 Number of architectures: %d\n", nfat_arch;
    }'

    # Read each fat_arch (20 bytes per arch)
    OFFSET=8
    for i in $(seq 1 "$nfat_arch"); do
      dd if="$BIN" bs=1 skip="$OFFSET" count=20 2>/dev/null | od -t x4 | head -n1 | awk -v i="$i" '{
        cputype=strtonum("0x"$2);
        archname=(cputype == 0x1000007 ? "x86_64" : (cputype == 0x100000C ? "arm64" : "unknown"));
        printf "  🔹 Arch %d: %s (cputype=0x%x)\n", i, archname, cputype;
      }'
      OFFSET=$((OFFSET + 20))
    done
    ;;

  feedfacf)
    echo "📄 Mach-O 64-bit Binary"
    echo "Parsing mach_header_64..."

    # Read first 32 bytes (mach_header_64)
    dd if="$BIN" bs=1 count=32 2>/dev/null | od -t x4 | head -n1 | awk '{
      cputype=strtonum("0x"$3);
      filetype=strtonum("0x"$5);
      archname=(cputype == 0x1000007 ? "x86_64" : (cputype == 0x100000C ? "arm64" : "unknown"));
      typestr=(filetype == 0x2 ? "Executable" : (filetype == 0x6 ? "Dylib" : "Other"));
      printf "🔹 CPU: %s  | Filetype: %s\n", archname, typestr;
    }'
    ;;

  *)
    echo "❓ Unknown magic: 0x$MAGIC"
    ;;
esac
