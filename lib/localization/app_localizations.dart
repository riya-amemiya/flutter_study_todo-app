class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Daily Task Tracker',
      'addTask': 'Add Task',
      'editTask': 'Edit Task',
      'taskDetails': 'Task Details',
      'title': 'Title',
      'description': 'Description',
      'dueDate': 'Due Date',
      'category': 'Category',
      'save': 'Save',
      'delete': 'Delete',
      'cancel': 'Cancel',
      'searchTasks': 'Search tasks',
      'filterByCategory': 'Filter by category',
      'allCategories': 'All categories',
      'sortBy': 'Sort by',
      // ignore: equal_keys_in_map
      'dueDate': 'Due Date',
      'creationDate': 'Creation Date',
      'completed': 'Completed',
      'pending': 'Pending',
      'pleaseEnterTitle': 'Please enter a title',
      'pleaseEnterCategory': 'Please enter a category',
      'status': 'Status',
      // ignore: equal_keys_in_map
      'completed': 'Completed',
      // ignore: equal_keys_in_map
      'pending': 'Pending',
      'deleteTask': 'Delete Task',
      'areYouSureDeleteTask': 'Are you sure you want to delete this task?',
      'manageCategories': 'Manage Categories',
      'addNewCategory': 'Add New Category',
      'enterCategoryName': 'Enter category name',
      'add': 'Add',
      'editCategory': 'Edit Category',
      'enterNewCategoryName': 'Enter new category name',
      // ignore: equal_keys_in_map
      'save': 'Save',
      'deleteCategory': 'Delete Category',
      'areYouSureDeleteCategory':
          'Are you sure you want to delete this category? Tasks in this category will be set to "Unspecified".',
      'pleaseSelectCategory': 'Please select a category',
      // ignore: equal_keys_in_map
      'allCategories': 'All Categories',
      'unspecified': 'Unspecified',
      'settings': 'Settings',
      'language': 'Language',
      'undo': 'Undo',
    },
    'ja': {
      'appTitle': 'デイリータスクトラッカー',
      'addTask': 'タスクを追加',
      'editTask': 'タスクを編集',
      'taskDetails': 'タスクの詳細',
      'title': 'タイトル',
      'description': '説明',
      'dueDate': '期限',
      'category': 'カテゴリ',
      'save': '保存',
      'delete': '削除',
      'cancel': 'キャンセル',
      'searchTasks': 'タスクを検索',
      'filterByCategory': 'カテゴリでフィルター',
      'allCategories': 'すべてのカテゴリ',
      'sortBy': '並び替え',
      // ignore: equal_keys_in_map
      'dueDate': '期限',
      'creationDate': '作成日',
      'completed': '完了',
      'pending': '未完了',
      'pleaseEnterTitle': 'タイトルを入力してください',
      'pleaseEnterCategory': 'カテゴリーを入力してください',
      'status': '状態',
      // ignore: equal_keys_in_map
      'completed': '完了',
      // ignore: equal_keys_in_map
      'pending': '未完了',
      'deleteTask': 'タスクを削除',
      'areYouSureDeleteTask': 'このタスクを削除してもよろしいですか？',
      'manageCategories': 'カテゴリー管理',
      'addNewCategory': '新しいカテゴリーを追加',
      'enterCategoryName': 'カテゴリー名を入力',
      'add': '追加',
      'editCategory': 'カテゴリーを編集',
      'enterNewCategoryName': '新しいカテゴリー名を入力',
      // ignore: equal_keys_in_map
      'save': '保存',
      'deleteCategory': 'カテゴリーを削除',
      'areYouSureDeleteCategory':
          'このカテゴリーを削除してもよろしいですか？このカテゴリーのタスクは「未指定」に設定されます。',
      'pleaseSelectCategory': 'カテゴリーを選択してください',
      // ignore: equal_keys_in_map
      'allCategories': 'すべてのカテゴリー',
      'unspecified': '未指定',
      'settings': '設定',
      'language': '言語',
      'undo': '元に戻す',
    },
  };

  String get(String key) {
    return _localizedValues[languageCode]?[key] ??
        _localizedValues['en']![key]!;
  }
}
