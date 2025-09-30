#!/bin/bash
# ===============================
# Pobieranie danych GPW ze stooq.pl + BTCUSDT z Binance
# Zapis do katalogu ./data/ i spakowanie do jednego ZIP
# ===============================

# Zakres dat dla GPW
FROM="20150101"
TO=$(date +"%Y%m%d")  # dzisiaj

# Lista tickerów GPW (kody stooq.pl)
TICKERS=("kgh" "ale" "pkn" "pxm")

# Katalog roboczy
OUTDIR="./data"
mkdir -p $OUTDIR

# -------------------------------
# Pobieranie akcji z stooq.pl (D1)
# -------------------------------
for T in "${TICKERS[@]}"; do
    URL="https://stooq.pl/q/d/l/?s=${T}&f=${FROM}&t=${TO}&i=d"
    OUTFILE="${OUTDIR}/${T}.csv"
    echo "Pobieram GPW: $T -> $OUTFILE"
    curl -s "$URL" -o "$OUTFILE"
done

# -------------------------------
# Pobieranie BTCUSDT z Binance (1h)
# -------------------------------
BINANCE_URL="https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1h&limit=1000"
BTC_OUTFILE="${OUTDIR}/btcusdt_1h.csv"

echo "Pobieram BTCUSDT (1h) z Binance -> $BTC_OUTFILE"

curl -s "$BINANCE_URL" | jq -r '.[] | [
    (.[0]/1000 | strftime("%Y-%m-%d %H:%M:%S")), # czas UTC
    .[1],  # open
    .[2],  # high
    .[3],  # low
    .[4],  # close
    .[5]   # volume
] | @csv' > "$BTC_OUTFILE"

# -------------------------------
# Tworzenie pliku ZIP w ./data/
# -------------------------------
ZIPFILE="${OUTDIR}/market_data.zip"
echo "Pakuję wszystkie CSV do $ZIPFILE"
zip -j "$ZIPFILE" $OUTDIR/*.csv > /dev/null

echo "✅ Gotowe! Wszystkie pliki są w katalogu $OUTDIR"
echo "📦 ZIP: $ZIPFILE"

# -------------------------------
# Commit i push do repo
# -------------------------------
cd "$OUTDIR" || exit 1
DATE=$(date +"%Y-%m-%d")

git add .
git commit -m "dane za ${DATE}"
git push origin main
