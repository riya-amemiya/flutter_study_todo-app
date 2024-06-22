# Daily Task Tracker - コード説明資料

## 1. アプリケーション概要

Daily Task Trackerは、ユーザーが日々のタスクを管理するためのFlutterアプリケーションです。主な機能は以下の通りです：

- タスクの追加、編集、削除
- タスクの完了状態の切り替え
- タスクのソート（期限日、作成日、タイトル、カテゴリ）
- タスクの検索
- カテゴリによるフィルタリング
- カテゴリの管理（追加、編集、削除）
- 多言語対応（日本語、英語）

## 2. プロジェクト構造

```txt
lib/
  ├── models/
  │   └── task.dart
  ├── providers/
  │   ├── task_provider.dart
  │   └── category_provider.dart
  ├── screens/
  │   ├── task_list_screen.dart
  │   ├── task_edit_screen.dart
  │   ├── task_detail_screen.dart
  │   └── category_management_screen.dart
  ├── helpers/
  │   └── shared_preferences_helper.dart
  ├── localization/
  │   └── app_localizations.dart
  └── main.dart
```

## 3. 主要クラスの説明

### 3.1 Task (models/task.dart)

タスクの基本的な情報を保持するモデルクラスです。

主な属性:

- id: タスクの一意識別子
- title: タスクのタイトル
- description: タスクの詳細説明
- dueDate: タスクの期限
- isCompleted: タスクの完了状態
- category: タスクのカテゴリ

### 3.2 TaskProvider (providers/task_provider.dart)

タスク関連の状態管理を行うProviderクラスです。

主な機能:

- タスクのリスト管理
- タスクの追加、編集、削除
- タスクの完了状態の切り替え
- タスクのソートとフィルタリング
- 言語設定の管理

### 3.3 CategoryProvider (providers/category_provider.dart)

カテゴリ関連の状態管理を行うProviderクラスです。

主な機能:

- カテゴリリストの管理
- カテゴリの追加、編集、削除

### 3.4 TaskListScreen (screens/task_list_screen.dart)

メイン画面となるタスク一覧を表示するウィジェットです。

主な機能:

- タスクリストの表示
- タスクの検索
- カテゴリフィルタリング
- ソートオプションの選択
- 言語切り替え
- 新規タスク追加画面への遷移
- カテゴリ管理画面への遷移

### 3.5 TaskEditScreen (screens/task_edit_screen.dart)

タスクの追加・編集を行うための画面ウィジェットです。

主な機能:

- タスク情報の入力フォーム
- カテゴリの選択（ドロップダウン）
- 日付選択
- タスクの保存

### 3.6 TaskDetailScreen (screens/task_detail_screen.dart)

タスクの詳細情報を表示する画面ウィジェットです。

主な機能:

- タスク詳細の表示
- タスク編集画面への遷移
- タスクの削除

### 3.7 CategoryManagementScreen (screens/category_management_screen.dart)

カテゴリの管理を行うための画面ウィジェットです。

主な機能:

- カテゴリリストの表示
- カテゴリの追加
- カテゴリの編集
- カテゴリの削除

### 3.8 SharedPreferencesHelper (helpers/shared_preferences_helper.dart)

データの永続化を担当するヘルパークラスです。

主な機能:

- タスクデータの保存と取得
- カテゴリデータの保存と取得
- 言語設定の保存と取得

### 3.9 AppLocalizations (localization/app_localizations.dart)

多言語対応のための翻訳を管理するクラスです。

主な機能:

- 各言語の翻訳テキストの提供

## 4. 主要な機能の実装

### 4.1 タスクの追加

1. `TaskListScreen`の浮動アクションボタンから`TaskEditScreen`に遷移
2. ユーザーがタスク情報を入力（タイトル、説明、期限、カテゴリ）
3. 保存ボタンを押すと`TaskProvider`の`addTask`メソッドが呼び出される
4. `TaskProvider`は新しいタスクをリストに追加し、`SharedPreferencesHelper`を使用してデータを永続化

### 4.2 タスクの完了状態の切り替え

1. `TaskListScreen`のチェックボックスをタップ
2. `TaskProvider`の`toggleTaskCompletion`メソッドが呼び出される
3. タスクの完了状態が切り替わり、データが更新される
4. 完了状態になった場合、3秒後に自動的に削除されるタイマーがセットされる

### 4.3 カテゴリの管理

1. `TaskListScreen`のカテゴリ管理アイコンをタップし、`CategoryManagementScreen`に遷移
2. カテゴリの追加：
   - 「+」ボタンをタップし、新しいカテゴリ名を入力
   - `CategoryProvider`の`addCategory`メソッドが呼び出される
3. カテゴリの編集：
   - カテゴリ横の編集アイコンをタップし、新しいカテゴリ名を入力
   - `CategoryProvider`の`editCategory`メソッドが呼び出される
   - `TaskProvider`の`updateTaskCategory`メソッドが呼び出され、関連するタスクのカテゴリも更新される
4. カテゴリの削除：
   - カテゴリ横の削除アイコンをタップし、確認ダイアログで削除を確定
   - `CategoryProvider`の`removeCategory`メソッドが呼び出される
   - `TaskProvider`の`updateTaskCategory`メソッドが呼び出され、関連するタスクのカテゴリが「未指定」に変更される

### 4.4 言語切り替え

1. `TaskListScreen`の言語選択ドロップダウンから言語を選択
2. `TaskProvider`の`setLanguage`メソッドが呼び出される
3. 新しい言語設定が`SharedPreferencesHelper`を使用して保存される
4. `AppLocalizations`が更新され、UI全体が新しい言語で再描画される

## 5. 状態管理とデータフロー

1. `TaskProvider`と`CategoryProvider`が`ChangeNotifier`を継承し、状態の変更を監視可能にしています。
2. `main.dart`で`MultiProvider`を使用して、両方のプロバイダーをアプリ全体で利用可能にしています。
3. 各画面では`Consumer`や`Provider.of`を使用して、必要な状態にアクセスしています。
4. データの永続化は`SharedPreferencesHelper`を通じて行われ、アプリの起動時にデータがロードされます。

## 6. 多言語対応

`AppLocalizations`クラスが各言語の翻訳を管理します。現在は日本語と英語に対応しており、必要に応じて他の言語を追加することが可能です。
