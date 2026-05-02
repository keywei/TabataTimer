import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/providers.dart';
import '../../../domain/entities/slideshow_mode.dart';
import '../../../domain/entities/workout_image.dart';

class SlideshowBackground extends ConsumerStatefulWidget {
  const SlideshowBackground({
    super.key,
    required this.images,
    required this.mode,
    required this.intervalSeconds,
    this.dim = 0.55,
  });

  final List<WorkoutImage> images;
  final SlideshowMode mode;
  final int intervalSeconds;

  /// 0..1 — how much black overlay to draw over the image to keep
  /// foreground text readable.
  final double dim;

  @override
  ConsumerState<SlideshowBackground> createState() =>
      _SlideshowBackgroundState();
}

class _SlideshowBackgroundState extends ConsumerState<SlideshowBackground> {
  Timer? _timer;
  int _index = 0;
  final _random = Random();
  final Map<String, String?> _resolved = {};

  List<WorkoutImage> get _enabled =>
      widget.images.where((i) => i.enabled).toList();

  @override
  void initState() {
    super.initState();
    _resolveAll();
    _scheduleNext();
  }

  @override
  void didUpdateWidget(covariant SlideshowBackground old) {
    super.didUpdateWidget(old);
    if (widget.intervalSeconds != old.intervalSeconds ||
        widget.mode != old.mode ||
        widget.images.length != old.images.length) {
      _timer?.cancel();
      _scheduleNext();
    }
    _resolveAll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resolveAll() async {
    final storage = ref.read(imageStorageProvider);
    for (final img in widget.images) {
      if (_resolved.containsKey(img.id)) continue;
      final abs = await storage.resolveAbsolute(img.relativePath);
      if (!mounted) return;
      setState(() => _resolved[img.id] = abs);
    }
  }

  void _scheduleNext() {
    if (widget.mode == SlideshowMode.off) return;
    final list = _enabled;
    if (list.length <= 1) return;
    _timer = Timer.periodic(
      Duration(seconds: widget.intervalSeconds.clamp(1, 60)),
      (_) => _advance(),
    );
  }

  void _advance() {
    final list = _enabled;
    if (list.isEmpty) return;
    setState(() {
      if (widget.mode == SlideshowMode.random && list.length > 1) {
        var next = _random.nextInt(list.length);
        if (next == _index) next = (next + 1) % list.length;
        _index = next;
      } else {
        _index = (_index + 1) % list.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _enabled;
    if (widget.mode == SlideshowMode.off || list.isEmpty) {
      return const SizedBox.shrink();
    }
    final current = list[_index.clamp(0, list.length - 1)];
    final path = _resolved[current.id];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: KeyedSubtree(
        key: ValueKey('${current.id}#$_index'),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (path != null)
              Image.file(File(path), fit: BoxFit.cover)
            else
              const SizedBox.shrink(),
            ColoredBox(color: Colors.black.withValues(alpha: widget.dim)),
          ],
        ),
      ),
    );
  }
}
