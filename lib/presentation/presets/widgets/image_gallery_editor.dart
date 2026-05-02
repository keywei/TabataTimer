import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../di/providers.dart';
import '../../../domain/entities/workout_image.dart';
import '../../../l10n/app_localizations.dart';
import 'image_full_screen_viewer.dart';

const int kMaxImages = 10;

class ImageGalleryEditor extends ConsumerWidget {
  const ImageGalleryEditor({
    super.key,
    required this.images,
    required this.onChanged,
  });

  final List<WorkoutImage> images;
  final ValueChanged<List<WorkoutImage>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final atLimit = images.length >= kMaxImages;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (images.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              t.imagesEmpty,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          )
        else
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) {
              final list = [...images];
              if (newIndex > oldIndex) newIndex -= 1;
              final item = list.removeAt(oldIndex);
              list.insert(newIndex, item);
              onChanged(list);
            },
            children: [
              for (int i = 0; i < images.length; i++)
                _ImageRow(
                  key: ValueKey(images[i].id),
                  index: i,
                  image: images[i],
                  onToggleEnabled: () {
                    final list = [...images];
                    list[i] = list[i].copyWith(enabled: !list[i].enabled);
                    onChanged(list);
                  },
                  onReplace: () => _replace(context, ref, i),
                  onDelete: () => _confirmDelete(context, i),
                ),
            ],
          ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: atLimit ? null : () => _add(context, ref),
          icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
          label: Text(atLimit ? t.imagesLimitReached(kMaxImages) : t.imagesAdd),
        ),
      ],
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final remaining = kMaxImages - images.length;
    if (remaining <= 0) return;
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(
      limit: remaining,
      imageQuality: 80,
      maxWidth: 1280,
    );
    if (picked.isEmpty) return;
    final storage = ref.read(imageStorageProvider);
    const uuid = Uuid();
    final newOnes = <WorkoutImage>[];
    for (final x in picked) {
      try {
        final id = uuid.v4();
        final relativePath = await storage.import(x.path, imageId: id);
        newOnes.add(WorkoutImage(id: id, relativePath: relativePath));
      } catch (_) {/* skip on error */}
    }
    onChanged([...images, ...newOnes]);
  }

  Future<void> _replace(BuildContext context, WidgetRef ref, int index) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1280,
    );
    if (picked == null) return;
    final storage = ref.read(imageStorageProvider);
    final old = images[index];
    try {
      final newRel = await storage.import(picked.path, imageId: old.id);
      // Best-effort delete of the old file (may share imageId path on same ext).
      if (newRel != old.relativePath) {
        await storage.delete(old.relativePath);
      }
      final list = [...images];
      list[index] = old.copyWith(relativePath: newRel);
      onChanged(list);
    } catch (_) {}
  }

  Future<void> _confirmDelete(BuildContext context, int index) async {
    final t = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.imageDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.actionDelete),
          ),
        ],
      ),
    );
    if (ok == true) {
      final list = [...images]..removeAt(index);
      onChanged(list);
    }
  }
}

class _ImageRow extends ConsumerWidget {
  const _ImageRow({
    super.key,
    required this.index,
    required this.image,
    required this.onToggleEnabled,
    required this.onReplace,
    required this.onDelete,
  });

  final int index;
  final WorkoutImage image;
  final VoidCallback onToggleEnabled;
  final VoidCallback onReplace;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final storage = ref.read(imageStorageProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.drag_indicator,
                  size: 20, color: scheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final abs = await storage.resolveAbsolute(image.relativePath);
                if (abs != null && context.mounted) {
                  await ImageFullScreenViewer.show(context, abs);
                }
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.outline, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.hardEdge,
                child: FutureBuilder<String?>(
                  future: storage.resolveAbsolute(image.relativePath),
                  builder: (context, snap) {
                    final path = snap.data;
                    if (path == null) {
                      return Center(
                        child: Icon(Icons.broken_image_outlined,
                            color: scheme.onSurfaceVariant, size: 22),
                      );
                    }
                    return Opacity(
                      opacity: image.enabled ? 1.0 : 0.35,
                      child: Image.file(File(path), fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Tooltip(
            message: t.imagesEnable,
            child: Checkbox(
              value: image.enabled,
              onChanged: (_) => onToggleEnabled(),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            onSelected: (v) {
              if (v == 'replace') onReplace();
              if (v == 'delete') onDelete();
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'replace', child: Text(t.imagesReplace)),
              PopupMenuItem(value: 'delete', child: Text(t.imagesDelete)),
            ],
          ),
        ],
      ),
    );
  }
}
