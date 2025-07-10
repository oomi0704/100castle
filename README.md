# Castle App

Rails 8.0.1を使用したWebアプリケーションです。

## 前提条件

- Docker
- Docker Compose

## 開発環境のセットアップ

### 1. 環境変数の設定

```bash
# .envファイルを作成
cp .env.example .env
```

必要な環境変数：
- `RAILS_MASTER_KEY`: Railsのマスターキー（config/master.keyから取得）

### 2. Dockerコンテナの起動

```bash
# イメージをビルド
make build

# コンテナを起動
make up
```

または、直接docker-composeコマンドを使用：

```bash
docker-compose up -d
```

### 3. データベースのセットアップ

```bash
# データベースを作成
make db-create

# マイグレーションを実行
make db-migrate

# シードデータを投入（オプション）
make db-seed
```

### 4. アプリケーションにアクセス

ブラウザで http://localhost:3000 にアクセスしてください。

## よく使用するコマンド

### 開発環境

```bash
make help          # 利用可能なコマンドを表示
make build         # Dockerイメージをビルド
make up            # 開発環境を起動
make down          # 開発環境を停止
make logs          # ログを表示
make shell         # Railsコンテナにシェルで接続
make db-shell      # データベースコンテナにシェルで接続
```

### データベース関連

```bash
make db-create     # データベースを作成
make db-migrate    # マイグレーションを実行
make db-seed       # シードデータを投入
make db-reset      # データベースをリセット
```

### 本番環境

```bash
make build-prod    # 本番用Dockerイメージをビルド
make up-prod       # 本番環境を起動
make down-prod     # 本番環境を停止
make logs-prod     # 本番環境のログを表示
```

### クリーンアップ

```bash
make clean         # 開発環境のクリーンアップ
make clean-prod    # 本番環境のクリーンアップ
```

## 本番環境でのデプロイ

### 1. 環境変数の設定

本番環境用の環境変数を設定してください：

```bash
export POSTGRES_PASSWORD=your_secure_password
export RAILS_MASTER_KEY=your_rails_master_key
```

### 2. 本番環境の起動

```bash
make build-prod
make up-prod
```

## トラブルシューティング

### コンテナが起動しない場合

```bash
# ログを確認
make logs

# コンテナの状態を確認
docker-compose ps
```

### データベース接続エラーの場合

```bash
# データベースコンテナの状態を確認
docker-compose ps db

# データベースログを確認
docker-compose logs db
```

### ボリュームのクリーンアップ

```bash
# すべてのデータを削除してクリーンな状態から開始
make clean
```

## 開発のヒント

- コードの変更は自動的に反映されます（ボリュームマウントにより）
- 新しいgemを追加した場合は `make build` を実行してください
- データベーススキーマを変更した場合は `make db-migrate` を実行してください
