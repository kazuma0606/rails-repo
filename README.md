# Ruby on Rails Todoアプリケーション

シンプルで実用的なTodo管理アプリケーションです。Ruby on Rails 8.0を使用して構築されています。

![Rails Version](https://img.shields.io/badge/Rails-8.0.2.1-red.svg)
![Ruby Version](https://img.shields.io/badge/Ruby-3.4.5-red.svg)
![Database](https://img.shields.io/badge/Database-SQLite3-blue.svg)

## 機能

- ✅ Todo作成・編集・削除
- ✅ Todo詳細表示
- ✅ 完了/未完了状態の管理
- ✅ 日本語完全対応
- ✅ レスポンシブデザイン
- ✅ フォームバリデーション

## 技術仕様

- **Ruby**: 3.4.5
- **Rails**: 8.0.2.1
- **データベース**: SQLite3
- **開発環境**: Docker + WSL (Windows)

## セットアップ方法

### 前提条件

- Windows 10/11 (WSL2がインストール済み)
- Docker Desktop for Windows
- Git

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd ruby-todo-app
```

### 2. Dockerを使った開発環境の起動

```bash
# Docker イメージの構築
docker build -f Dockerfile.dev -t ruby-todo-app .

# コンテナの起動（開発用）
docker run -p 3000:3000 -v "$(pwd):/app" ruby-todo-app
```

### 3. アプリケーションへのアクセス

ブラウザで [http://localhost:3000](http://localhost:3000) にアクセス

## 開発コマンド

### データベース操作

```bash
# データベース作成
docker exec -it <container-name> rails db:create

# マイグレーション実行
docker exec -it <container-name> rails db:migrate

# シードデータ投入
docker exec -it <container-name> rails db:seed

# データベースリセット
docker exec -it <container-name> rails db:reset
```

### テスト実行

```bash
# 全テスト実行
docker exec -it <container-name> rails test

# 特定のテストファイル実行
docker exec -it <container-name> rails test test/models/todo_test.rb
```

### Rails コンソール

```bash
docker exec -it <container-name> rails console
```

## プロジェクト構造

```
ruby-todo-app/
├── app/
│   ├── controllers/
│   │   └── todos_controller.rb     # Todo CRUD操作
│   ├── models/
│   │   └── todo.rb                 # Todoモデル（バリデーション含む）
│   └── views/
│       └── todos/                  # Todo関連ビュー
├── config/
│   ├── routes.rb                   # ルーティング設定
│   └── database.yml                # データベース設定
├── db/
│   └── migrate/                    # データベースマイグレーション
├── test/                           # テストファイル
├── Dockerfile.dev                  # 開発用Dockerファイル
├── Gemfile                         # Gem依存関係
└── CLAUDE.md                       # 実装手順書
```

## API エンドポイント

| HTTP Method | Path | Action | Description |
|-------------|------|--------|-------------|
| GET | `/` | `todos#index` | Todo一覧表示 |
| GET | `/todos` | `todos#index` | Todo一覧表示 |
| GET | `/todos/new` | `todos#new` | 新規Todo作成フォーム |
| POST | `/todos` | `todos#create` | Todo作成処理 |
| GET | `/todos/:id` | `todos#show` | Todo詳細表示 |
| GET | `/todos/:id/edit` | `todos#edit` | Todo編集フォーム |
| PATCH/PUT | `/todos/:id` | `todos#update` | Todo更新処理 |
| DELETE | `/todos/:id` | `todos#destroy` | Todo削除処理 |

## トラブルシューティング

### よくある問題と解決方法

**1. Docker コンテナが起動しない**
```bash
# Dockerサービスが起動しているか確認
docker --version
docker ps

# イメージの再構築
docker build --no-cache -f Dockerfile.dev -t ruby-todo-app .
```

**2. ポート3000が使用中**
```bash
# 異なるポートで起動
docker run -p 3001:3000 -v "$(pwd):/app" ruby-todo-app
```

**3. データベースエラー**
```bash
# データベースをリセット
docker exec -it <container-name> rails db:drop db:create db:migrate
```

**4. Gem依存関係のエラー**
```bash
# Bundler の更新
docker exec -it <container-name> bundle install
```

## 成功要因の詳細

Windows環境での開発における主要な成功要因については、[SUCCESS_FACTORS.md](SUCCESS_FACTORS.md)を参照してください。

## 開発履歴

- 初期環境構築でWindows + Ruby 3.4.5の互換性問題に直面
- WSL + Dockerソリューションで解決
- Rails 8.0.2.1 + SQLite3での完全CRUD機能実装
- 日本語UI完全対応
- レスポンシブデザイン実装

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。

## サポート

問題や質問がある場合は、Issueを作成してください。
