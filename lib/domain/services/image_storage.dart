/// Persists workout image files outside the JSON-serialized preset.
/// Domain only knows about a relative path; data resolves to the actual
/// file on disk.
abstract class ImageStorage {
  /// Copies [sourcePath] (a path returned by image_picker / file picker)
  /// into permanent storage and returns the **relative** path that
  /// should be stored in [WorkoutImage.relativePath]. Throws on failure.
  Future<String> import(String sourcePath, {required String imageId});

  /// Resolves a relative path to an absolute file path the UI can load.
  /// Returns null if the file is missing.
  Future<String?> resolveAbsolute(String relativePath);

  /// Removes the file at [relativePath]. Silent if it does not exist.
  Future<void> delete(String relativePath);
}
