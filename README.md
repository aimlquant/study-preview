# study-preview

`aimlquant/study`의 **`sub` 브랜치 내용을 미리 보기 위한 정적 사이트**다. 공식 사이트가 아니다.

| | |
|---|---|
| 공식 사이트 | https://aimlquant.github.io/study/ — `aimlquant/study`의 `main` 브랜치에서 배포 |
| 이 미리보기 | https://aimlquant.github.io/study-preview/ — `aimlquant/study`의 `sub` 브랜치 스냅샷 |

## 무엇이 들어 있나

`aimlquant/study`에서 `build_site.py`로 생성한 `html/`의 내용물을 저장소 루트에 그대로 둔 것이다.
여기서는 빌드도 검증도 하지 않는다 — 그 책임은 원본 저장소에 있다.

- `.nojekyll` — Jekyll 처리를 끄고 파일을 있는 그대로 서빙한다.
- `robots.txt` — 검색엔진 색인을 막는다. 같은 내용이 공식 사이트와 중복 노출되지 않게 하기 위해서다.
- 페이지의 `<link rel="canonical">`은 공식 사이트를 가리킨다. 미리보기가 정본으로 취급되지 않도록 그대로 둔다.

## 갱신하는 법

`aimlquant/study`를 `sub` 브랜치로 체크아웃한 상태에서:

```bash
bash sync-preview.sh
git add -A
git commit -m "sync: <무엇을 올렸는지>"
git push
```

`sync-preview.sh`는 `study/html/`의 내용물을 이 저장소 루트로 복사한다. `.git`, `README.md`,
`robots.txt`, `.nojekyll`, `sync-preview.sh`는 보존한다.

## Pages 설정

Settings → Pages → Source: **Deploy from a branch**, Branch: **`sub` / `(root)`**.
Actions 워크플로는 두지 않는다.
