#!/usr/bin/env bash
# aimlquant/study 에 "커밋된" html/ 을 미리보기 저장소로 동기화한다.
#
# 워킹트리를 복사하지 않고 git archive 로 커밋된 트리만 뽑는다. 워킹트리에는
# 사용자의 백업 폴더(`- 복사본`)와 스크래치 HTML 이 섞여 있어 그대로 복사하면
# 공개 사이트에 함께 올라간다. study 쪽에서 먼저 커밋해 두는 것이 사실상의
# 큐레이션 단계이므로, 커밋된 상태가 정확한 기준이기도 하다.
#
# 미리보기 저장소는 빌드도 검증도 하지 않는다. 그 책임은 원본 저장소에 있다.
set -euo pipefail

SRC="${SRC:-d:/01_study/07_AI_Quant/aimlquant/study}"
DST="${DST:-d:/01_study/07_AI_Quant/aimlquant/study-preview}"
REF="${REF:-HEAD}"   # 기본은 study 의 현재 체크아웃. REF=<브랜치> 로 바꿀 수 있다.

git -C "$SRC" rev-parse --verify --quiet "$REF" >/dev/null || {
  echo "원본 저장소에 '$REF' 브랜치가 없다: $SRC" >&2
  exit 1
}
echo "원본: $SRC ($REF $(git -C "$SRC" rev-parse --short "$REF"))"

mkdir -p "$DST"

# 저장소 관리 파일만 남기고 이전 사본을 지운다.
find "$DST" -mindepth 1 -maxdepth 1 \
  ! -name '.git' ! -name 'README.md' ! -name 'robots.txt' \
  ! -name '.nojekyll' ! -name 'sync-preview.sh' \
  -exec rm -rf {} +

# 커밋된 html/ 의 내용물을 저장소 루트로 푼다 (html/ 폴더 자체가 아니라 내용물).
git -C "$SRC" archive "$REF" html | tar -x -C "$DST" --strip-components=1

echo "동기화 완료: $(find "$DST" -type f -not -path '*/.git/*' | wc -l) 파일"
