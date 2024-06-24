abstract class StorageInterface {
  Future<void> saveData(String key, dynamic data);
  Future<dynamic> getData(String key);
  Future<void> removeData(String key);
}
