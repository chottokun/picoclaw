# PicoClaw 独自カスタマイズ構成

このリポジトリは [Sipeed/picoclaw](https://github.com/sipeed/picoclaw) をベースに、ローカル環境向けのカスタマイズを加えています。

## 本家との主な差分

### 1. Docker Override 構成
本家の `docker-compose.yml` を汚さずにカスタマイズを維持するため、`docker-compose.override.yml` を使用しています。
- **環境変数の維持**: `HOME` や `PICOCLAW_HOME` などのローカル固有設定を分離。
- **Ollama の統合**: ローカルで Ollama を実行するためのコンテナ定義を追加。

### 2. GPU トグル機能
`docker-rebuild.sh` スクリプトに `--gpu` フラグを追加し、GPU利用の有無を簡単に切り替えられるようにしています。
- **CPU版 (標準)**: `bash docker-rebuild.sh`
- **GPU版 (NVIDIA)**: `bash docker-rebuild.sh --gpu`

---

## 運用手順

### 1. 本家の最新更新を取り込む（頻繁に行う作業）

本家（Sipeed）側が新機能をリリースしたり、バグを修正したときに実行します。

```bash
# 本家の最新情報を取得
git fetch upstream
# 自分の main ブランチに本家の更新を合流させる
git merge upstream/main
```

### 2. 自分の変更を GitHub（フォーク先）に保存する

```bash
git add .
git commit -m "独自の機能を追加"
git push origin main
```

### 3. 起動と再構築
```bash
# 通常起動
bash docker-rebuild.sh

# GPUを有効にして起動
bash docker-rebuild.sh --gpu
```