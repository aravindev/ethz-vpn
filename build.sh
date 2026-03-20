#!/bin/bash
# Usage: ./build.sh 1.0.1

VERSION=$1
if [ -z "$VERSION" ]; then
    VERSION=$(git describe --tags --abbrev=0 2>/dev/null | sed 's/v//')
    if [ -z "$VERSION" ]; then
        VERSION="1.0.0"
    fi
fi

echo "🏗️ Building ethz-vpn version: $VERSION"

# 1. Create a temporary build directory structure
STAGING="build_staging"
mkdir -p "$STAGING/DEBIAN"
mkdir -p "$STAGING/usr/bin"
mkdir -p "$STAGING/etc/xdg/autostart"

# 2. Copy files into the staging area
cp DEBIAN/control "$STAGING/DEBIAN/"
cp DEBIAN/postinst "$STAGING/DEBIAN/"
cp DEBIAN/postrm "$STAGING/DEBIAN/"
cp usr/bin/ethz-vpn "$STAGING/usr/bin/"
mkdir -p "$STAGING/usr/share/applications"
cp etc/xdg/autostart/ethz-vpn.desktop "$STAGING/usr/share/applications/ethz-vpn.desktop"
mkdir -p "$STAGING/etc/xdg/autostart"
ln -s /usr/share/applications/ethz-vpn.desktop "$STAGING/etc/xdg/autostart/ethz-vpn.desktop"

# 3. Inject the version into the control file
sed -i "s/@VERSION@/$VERSION/g" "$STAGING/DEBIAN/control"

# 4. Set final permissions for the package builder
chmod 755 "$STAGING/usr/bin/ethz-vpn"
chmod 755 "$STAGING/DEBIAN/postinst"
chmod 755 "$STAGING/DEBIAN/postrm"

# 5. Build the .deb
dpkg-deb --build "$STAGING" "ethz-vpn_${VERSION}_all.deb"

# 6. Cleanup
rm -rf "$STAGING"
echo "✅ Successfully created ethz-vpn_${VERSION}_all.deb"
