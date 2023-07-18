abstract class IForceUpdateAppService {
  Future<bool> get needsUpdate;

  Future<String> get enforcedVersionRaw;

  Future<String> get currentVersionRaw;
}
