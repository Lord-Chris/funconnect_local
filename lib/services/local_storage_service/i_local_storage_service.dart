abstract class ILocalStorageService {
  Future<void> init();
  Future<void> write(String boxId, {required String key, required data});
  T read<T>(String boxId, {required String key, T? def});
  Future<void> clearBox(String boxId);
  Future<void> clearAll();
}
