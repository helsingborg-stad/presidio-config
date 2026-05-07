#!/usr/bin/env bash
set -euo pipefail

TEXT="${1:-Hej, jag heter Anna Andersson (personnummer 19850313-4567) och bor på Storgatan 5, 211 22 Malmö. Ring mig på 070-123 45 67 eller kontakta företaget (orgnr 556677-8899). IBAN: SE45 5000 0000 0583 9825 7466.}"

echo "== Analyze =="
ANALYZE=$(curl -s localhost:5002/analyze \
  -H 'Content-Type: application/json' \
  -d "{\"text\":\"${TEXT}\",\"language\":\"sv\"}")
echo "$ANALYZE" | python3 -m json.tool

echo
echo "== Anonymize =="
curl -s localhost:5001/anonymize \
  -H 'Content-Type: application/json' \
  -d "{\"text\":\"${TEXT}\",\"analyzer_results\":${ANALYZE}}" \
  | python3 -m json.tool
