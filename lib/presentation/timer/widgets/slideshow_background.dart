import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/providers.dart';
import '../../../domain/entities/slideshow_mode.dart';
import '../../../domain/entities/timer_phase.dart';
import '../../../domain/entities/workout_image.dart';
import '../../../domain/timer/phase_transition.dart';

class SlideshowBackground extends ConsumerStatefulWidget {
  const SlideshowBackground({
    super.key,
    required this.images,
    required this.mode,
    this.dim = 0.55,
  });

  final List<WorkoutImage> images;
  final SlideshowMode mode;

  /// 0..1 — black overlay opacity to keep foreground text readable.
  final double dim;

  @override
  ConsumerState<SlideshowBackground> createState() =>
      _SlideshowBackgroundState();
}

class _SlideshowBackgroundState extends ConsumerState<SlideshowBackground> {
  StreamSubscription<PhaseTransition>? _sub;
  int _index = -1;
  final _random = Random();
  final Map<String, String?> _resolved = {};

  List<WorkoutImage> get _enabled =>
      widget.images.where((i) => i.enabled).toList();

  @override
  void initState() {
    super.initState();
    _resolveAll();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctrl = ref.read(workoutControllerProvider.notifier);
      _sub = ctrl.transitions.listen(_onTransition);
    });
  }

  @override
  void didUpdateWidget(covariant SlideshowBackground old) {
    super.didUpdateWidget(old);
    _resolveAll();
  }

  @override
  void dispose() {
    _sub?.cancel();
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

  void _onTransition(PhaseTransition ev) {
    // The slideshow advances on every meaningful phase entry —
    // prepare, each work round, each rest, and the inter-set rest.
    // idle and completed are bookkeeping states; do nothing for them.
    if (ev.to == TimerPhase.idle || ev.to == TimerPhase.completed) return;

    final list = _enabled;
    if (list.isEmpty) return;

    setState(() {
      if (widget.mode == SlideshowMode.random && list.length > 1) {
        var next = _random.nextInt(list.length);
        if (next == _index) next = (next + 1) % list.length;
        _index = next;
      } else {
        _index = _index < 0 ? 0 : (_index + 1) % list.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _enabled;
    if (widget.mode == SlideshowMode.off || list.isEmpty || _index < 0) {
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
