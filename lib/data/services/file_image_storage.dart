import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/services/image_storage.dart';

class FileImageStorage implements ImageStorage {
  static const _subdir = 'workout_images';

  Future<Directory> _baseDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, _subdir));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  @override
  Future<String> import(String sourcePath, {required String imageId}) async {
    final base = await _baseDir();
    final ext = _safeExt(sourcePath);
    final fileName = '$imageId$ext';
    final dest = File(p.join(base.path, fileName));
    await File(sourcePath).copy(dest.path);
    return p.posix.join(_subdir, fileName);
  }

  @override
  Future<String?> resolveAbsolute(String relativePath) async {
    final docs = await getApplicationDocumentsDirectory();
    final abs = p.join(docs.path, relativePath);
    if (!await File(abs).exists()) return null;
    return abs;
  }

  @override
  Future<void> delete(String relativePath) async {
    try {
      final docs = await getApplicationDocumentsDirectory();
      final f = File(p.join(docs.path, relativePath));
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  String _safeExt(String path) {
    final ext = p.extension(path).toLowerCase();
    if (ext.isEmpty) return '.jpg';
    if (ext.length > 5) return '.jpg';
    return ext;
  }
}
