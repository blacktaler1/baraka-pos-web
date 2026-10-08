#!/usr/bin/env bash
# Serverda ishga tushiriladi: bash deploy.sh /tmp/baraka-pos-web.tar.gz
# Faqat /var/www/baraka-pos-web va mobile.barakaposystem.uz nginx saytiga tegadi.
set -euo pipefail

ARCHIVE="${1:?build arxiv yo'li kerak}"
APP_DIR=/var/www/baraka-pos-web
RELEASE="$APP_DIR/releases/$(date +%Y%m%d%H%M%S)"
SITE=/etc/nginx/sites-available/mobile.barakaposystem.uz.conf
HERE="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$RELEASE"
tar -xzf "$ARCHIVE" -C "$RELEASE"
ln -sfn "$RELEASE" "$APP_DIR/current"

# Oxirgi 3 ta relizni qoldiramiz
ls -1dt "$APP_DIR"/releases/* | tail -n +4 | xargs -r rm -rf

if [ ! -f "$SITE" ]; then
  cp "$HERE/nginx-mobile.barakaposystem.uz.conf" "$SITE"
  ln -sfn "$SITE" /etc/nginx/sites-enabled/mobile.barakaposystem.uz.conf
fi

nginx -t
systemctl reload nginx

# HTTPS (kamera va ulashish uchun shart) — faqat shu domen uchun
if ! grep -q "ssl_certificate" "$SITE"; then
  certbot --nginx -d mobile.barakaposystem.uz --non-interactive --agree-tos \
    --register-unsafely-without-email --redirect
fi

echo "Tayyor: https://mobile.barakaposystem.uz"
