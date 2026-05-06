import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import '../../domain/entities/workout_history_entry.dart';
import '../../domain/services/history_archive.dart';
import '../dtos/workout_history_entry_dto.dart';

const _kArchiveVersion = 1;
const _kAppTag = 'tabata_timer';

class JsonHistoryArchive implements HistoryArchive {
  @override
  Future<bool> exportAndShare(List<WorkoutHistoryEntry> entries) async {
    final envelope = {
      'app': _kAppTag,
      'version': _kArchiveVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'entries': entries.map((e) => e.toDto().toJson()).toList(),
    };
    final json = const JsonEncoder.withIndent('  ').convert(envelope);
    final bytes = Uint8List.fromList(utf8.encode(json));

    final stamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');
    final fileName = 'tabata_history_$stamp.json';

    final path = await FilePicker.saveFile(
      dialogTitle: 'Save Tabata history',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: bytes,
    );
    return path != null;
  }

  @override
  Future<List<WorkoutHistoryEntry>?> pickAndParse() async {
    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (picked == null || picked.files.isEmpty) return null;
    final f = picked.files.first;

    String content;
    try {
      if (f.bytes != null) {
        content = utf8.decode(f.bytes!);
      } else if (f.path != null) {
        content = await File(f.path!).readAsString();
      } else {
        throw HistoryArchiveException('No readable file payload');
      }
    } on HistoryArchiveException {
      rethrow;
    } catch (e) {
      throw HistoryArchiveException('Cannot read file: $e');
    }

    return _parse(content);
  }

  List<WorkoutHistoryEntry> _parse(String content) {
    Object? decoded;
    try {
      decoded = jsonDecode(content);
    } catch (e) {
      throw HistoryArchiveException('Invalid JSON');
    }

    final List<dynamic> rawEntries;
    if (decoded is Map<String, dynamic>) {
      final entries = decoded['entries'];
      if (entries is! List) {
        throw HistoryArchiveException('Missing "entries" array');
      }
      rawEntries = entries;
    } else if (decoded is List) {
      rawEntries = decoded;
    } else {
      throw HistoryArchiveException('Unexpected JSON root');
    }

    try {
      return rawEntries
          .map((e) =>
              WorkoutHistoryEntryDto.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();
    } catch (e) {
      throw HistoryArchiveException('Entry shape mismatch: $e');
    }
  }
}
