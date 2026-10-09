# Baraka POS — mobil web versiya

`baraka-pos-frontend` (Windows) loyihasining telefon brauzeri uchun moslangan nusxasi.

## Ishga tushirish

```bash
flutter pub get
flutter run -d chrome                # ishlab chiqish
flutter build web --release --pwa-strategy=none   # natija: build/web
# --pwa-strategy=none: keshlovchi service worker o'chiq, aks holda telefonlar eski versiyani ko'rsatadi
```

`build/web` papkasini istalgan statik hostingga (nginx, Firebase Hosting, Netlify) qo'ying.
Kamera va "Ulashish" (PDF yuborish) faqat **HTTPS** orqali ishlaydi.

API manzili: `--dart-define=API_BASE_URL=https://...` (standart: `https://api.barakaposystem.uz/api`).

## Desktop versiyadan farqlari

| Desktop (Windows) | Mobil web |
|---|---|
| Termal printerga chek (ESC/POS, win32) | Chek **PDF** (80 mm) — telefonning "Ulashish" oynasi orqali Telegram/WhatsApp ga yuboriladi |
| Shtrix-kod printeri (TSPL) | Etiketkalar PDF (58×40 mm) |
| USB skaner | **Telefon kamerasi** (`mobile_scanner`); Bluetooth skaner ham ishlaydi |
| SQLite fayl (`path_provider`) | Brauzer ichidagi SQLite (`web/sqlite3.wasm`, `web/drift_worker.js`) |
| Ochiq savatlar JSON faylda | `shared_preferences` (localStorage) |
| Printer sozlamalari, installer orqali yangilash, to'liq ekran | Olib tashlangan (web sahifa yangilanganda avtomatik yangilanadi) |
| Excel saqlash oynasi | Fayl ulashiladi yoki yuklab olinadi |

## Telefon dizayni

- Eni 700px dan kichik ekranda: yuqori yashil panel + pastki navigatsiya + yon menyu (rolga qarab).
- Jadvallar avtomatik kartochkalarga aylanadi (`AppDataTable`), statistika kartalari 2 ustunli to'r (`AppAdaptiveRow`).
- Yon panellar (formalar) telefonda to'liq ekran bo'lib ochiladi.
- Kassa: "Mahsulotlar / Savat" tablari, kamera tugmasi, pastda savat summasi.
- Kompyuter brauzerida eski desktop ko'rinishi saqlanadi.

## Backend

Brauzerdan so'rov yuborish uchun CORS kerak. `baraka-pos-backend/core/settings/prod.py` da
`CORS_ALLOW_ALL_ORIGINS` sozlamasi tuzatildi (eski `CORS_ORIGIN_ALLOW_ALL` nomi
django-cors-headers 4.x da ishlamaydi). Domenni cheklash uchun `.env` ga
`CORS_ALLOWED_ORIGINS=https://pos.sizning-domen.uz` qo'shing.

## sqlite3.wasm / drift_worker.js

`drift` (2.29.0) va `sqlite3` (2.9.4) versiyalariga mos. Paketlar yangilansa, shu fayllarni ham
mos relizdan qayta yuklab oling.

## Serverga joylash (mobile.barakaposystem.uz)

```bash
flutter build web --release --pwa-strategy=none --dart-define=API_BASE_URL=https://mobile.barakaposystem.uz/api
tar -czf baraka-pos-web.tar.gz -C build/web .
scp baraka-pos-web.tar.gz deploy/* root@SERVER:/tmp/
ssh root@SERVER 'bash /tmp/deploy.sh /tmp/baraka-pos-web.tar.gz'
```

Ilova `/var/www/baraka-pos-web` ga, nginx sayti `mobile.barakaposystem.uz` ga alohida o'rnatiladi.
`/api/` so'rovlari nginx orqali `api.barakaposystem.uz` ga uzatiladi — backend va boshqa saytlar o'zgarmaydi.
