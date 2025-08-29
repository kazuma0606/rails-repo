# Ruby on Rails Todoアプリケーション実装手順

## フェーズ1: 環境構築（Windows）

### 1. Rubyのインストール
- [ ] [RubyInstaller for Windows](https://rubyinstaller.org/) からRuby 3.2.x をダウンロード
- [ ] インストール実行（WITH DEVKIT版を推奨）
- [ ] `ruby -v` でバージョン確認
- [ ] `gem -v` でRubyGemsが使用可能か確認

### 2. Railsのインストール  
- [ ] `gem install rails` 実行
- [ ] `rails -v` でバージョン確認（Rails 7.x系がインストールされることを確認）

### 3. 必要ツールの確認・インストール
- [ ] `sqlite3 --version` でSQLite確認
- [ ] `gem install bundler` でBundler追加
- [ ] Node.js インストール（アセットパイプライン用）
- [ ] `git --version` でGit確認（推奨）

## フェーズ2: Railsアプリケーション作成

### 4. 新規アプリ作成
- [ ] `rails new ruby-todo-app --database=sqlite3` 実行
- [ ] `cd ruby-todo-app` でディレクトリ移動
- [ ] `bundle install` でGem依存関係インストール

### 5. 初期設定と動作確認
- [ ] `rails db:create` でデータベース作成
- [ ] `rails server` で開発サーバー起動
- [ ] ブラウザで http://localhost:3000 にアクセスして動作確認

## フェーズ3: Todo機能実装

### 6. Todoモデル作成
- [ ] `rails generate model Todo title:string description:text completed:boolean` 実行
- [ ] 生成されたマイグレーションファイル（db/migrate/xxx_create_todos.rb）を編集
  ```ruby
  # completedフィールドにデフォルト値を設定
  t.boolean :completed, default: false
  ```
- [ ] `rails db:migrate` でマイグレーション実行

### 7. Todoコントローラ作成
- [ ] `rails generate controller Todos index show new create edit update destroy` 実行
- [ ] app/controllers/todos_controller.rb に各アクションを実装
  - index: 全Todo一覧表示
  - show: 個別Todo詳細表示
  - new: 新規Todo作成フォーム
  - create: 新規Todo保存処理
  - edit: Todo編集フォーム
  - update: Todo更新処理  
  - destroy: Todo削除処理

### 8. ビュー作成
- [ ] app/views/todos/index.html.erb（一覧画面）作成
- [ ] app/views/todos/_form.html.erb（フォーム部分テンプレート）作成
- [ ] app/views/todos/new.html.erb（新規作成画面）作成
- [ ] app/views/todos/show.html.erb（詳細画面）作成
- [ ] app/views/todos/edit.html.erb（編集画面）作成

### 9. ルーティング設定
- [ ] config/routes.rb を編集
  ```ruby
  Rails.application.routes.draw do
    root 'todos#index'
    resources :todos
  end
  ```
- [ ] `rails routes` でルーティング確認

## フェーズ4: UI・スタイリング

### 10. 基本スタイリング
- [ ] Bootstrap追加または基本CSS作成
- [ ] app/views/layouts/application.html.erb レイアウト改善
- [ ] レスポンシブデザイン対応
- [ ] app/assets/stylesheets/application.css でスタイル調整

### 11. JavaScript機能
- [ ] 完了状態トグル機能（AJAX）実装
- [ ] 削除時の確認ダイアログ追加
- [ ] クライアントサイドフォームバリデーション
- [ ] Stimulus.js の活用（Rails標準）

## フェーズ5: テスト・仕上げ

### 12. バリデーション・テスト
- [ ] app/models/todo.rb にバリデーション追加
  ```ruby
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  ```
- [ ] test/models/todo_test.rb でモデルテスト作成
- [ ] test/controllers/todos_controller_test.rb でコントローラテスト作成

### 13. 最終仕上げ
- [ ] フラッシュメッセージ追加（成功・エラー通知）
- [ ] エラーハンドリング改善
- [ ] 検索・フィルタリング機能追加（オプション）
- [ ] ページネーション追加（オプション）
- [ ] 最終動作確認

## よく使うコマンド一覧

```bash
# 環境確認
ruby -v
rails -v
sqlite3 --version
bundle -v

# アプリ作成・初期化
rails new ruby-todo-app --database=sqlite3
cd ruby-todo-app
bundle install

# データベース操作
rails db:create
rails db:migrate
rails db:seed
rails db:reset  # 開発時のDB初期化

# サーバー起動・停止
rails server
# Ctrl+C でサーバー停止

# 生成コマンド
rails generate model ModelName
rails generate controller ControllerName
rails generate migration MigrationName

# ルーティング確認
rails routes

# テスト実行
rails test
```

## 実装予定機能チェックリスト

- [ ] 新しいTodoの作成
- [ ] Todoリストの表示
- [ ] 既存Todoの編集
- [ ] Todoの削除
- [ ] Todoの完了/未完了切り替え
- [ ] 基本的な検索・フィルタリング（オプション）
- [ ] レスポンシブデザイン
- [ ] フラッシュメッセージ
- [ ] バリデーション
- [ ] テスト

## トラブルシューティング

### よくあるエラー

**Rails server が起動しない**
- Gemfileの依存関係を確認: `bundle install`
- ポート3000が使用中の場合: `rails server -p 3001`

**SQLite関連エラー**  
- Windows環境でSQLiteが見つからない場合は、sqlite3.dllを確認

**アセット関連エラー**
- Node.jsがインストールされているか確認
- `yarn install` または `npm install` を実行

**マイグレーションエラー**
- `rails db:drop db:create db:migrate` で DB再作成

**Permission denied エラー**
- 管理者権限でコマンドプロンプトを起動
- ウイルス対策ソフトがファイルアクセスをブロックしていないか確認

## 推奨開発環境

- **エディタ**: Visual Studio Code + Ruby拡張
- **ブラウザ**: Chrome（開発者ツール活用）
- **コマンドライン**: Windows PowerShell または Git Bash
- **データベース管理**: DB Browser for SQLite（GUI）

## 参考資料

- [Ruby on Rails ガイド（日本語）](https://railsguides.jp/)
- [Rails API Documentation](https://api.rubyonrails.org/)
- [RubyInstaller for Windows](https://rubyinstaller.org/)