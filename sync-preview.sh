#!/usr/bin/env bash
# aimlquant/study 의 현재 체크아웃(html/)을 미리보기 저장소로 동기화한다.
#
# 미리보기 저장소는 빌드하지 않는다. study 저장소에서 build_site.py 로 생성한
# html/ 을 그대로 루트에 놓고 Pages 가 정적으로 서빙한다. 그래서 Actions 도,
# 검증도 여기서 다시 돌리지 않는다 — 검증은 study 저장소 쪽 책임이다.
set -euo pipefail

SRC="d:/01_study/07_AI_Quant/aimlquant/study"
DST="d:/01_study/07_AI_Quant/aimlquant/study-preview"

branch="$(git -C "$SRC" branch --show-current)"
echo "원본 브랜치: $branch"

mkdir -p "$DST"

# 저장소 관리 파일만 남기고 이전 사본을 지운다.
find "$DST" -mindepth 1 -maxdepth 1 \
  ! -name '.git' ! -name 'README.md' ! -name 'robots.txt' ! -name '.nojekyll' \
  -exec rm -rf {} +

# html/ 의 내용물을 저장소 루트로 옮긴다 (html/ 폴더 자체가 아니라 내용물).
cp -r "$SRC/html/." "$DST/"

echo "동기화 완료: $(find "$DST" -type f -not -path '*/.git/*' | wc -l) 파일"
