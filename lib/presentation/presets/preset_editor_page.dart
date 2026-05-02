import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../di/providers.dart';
import '../../domain/entities/slideshow_mode.dart';
import '../../domain/entities/tabata_preset.dart';
import '../../domain/entities/workout_image.dart';
import '../../l10n/app_localizations.dart';
import '../shared/section_header.dart';
import 'widgets/image_gallery_editor.dart';

class PresetEditorPage extends ConsumerStatefulWidget {
  const PresetEditorPage({super.key, this.original});

  final TabataPreset? original;

  @override
  ConsumerState<PresetEditorPage> createState() => _PresetEditorPageState();
}

class _PresetEditorPageState extends ConsumerState<PresetEditorPage> {
  late TextEditingController _name;
  late int prepare;
  late int work;
  late int rest;
  late int rounds;
  late int sets;
  late int restBetweenSets;
  late List<WorkoutImage> images;
  late SlideshowMode slideshowMode;
  late int slideshowInterval;

  @override
  void initState() {
    super.initState();
    final o = widget.original;
    _name = TextEditingController(text: o?.name ?? '');
    prepare = o?.prepareSeconds ?? 10;
    work = o?.workSeconds ?? 20;
    rest = o?.restSeconds ?? 10;
    rounds = o?.rounds ?? 8;
    sets = o?.sets ?? 1;
    restBetweenSets = o?.restBetweenSetsSeconds ?? 60;
    images = [...(o?.images ?? const <WorkoutImage>[])];
    slideshowMode = o?.slideshowMode ?? SlideshowMode.off;
    slideshowInterval = o?.slideshowIntervalSeconds ?? 5;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final t = AppLocalizations.of(context);
    final ctrl = ref.read(presetsControllerProvider.notifier);
    final preset = TabataPreset(
      id: widget.original?.id ?? ctrl.newId(),
      name: _name.text.trim().isEmpty ? t.untitled : _name.text.trim(),
      prepareSeconds: prepare,
      workSeconds: work,
      restSeconds: rest,
      rounds: rounds,
      sets: sets,
      restBetweenSetsSeconds: restBetweenSets,
      images: images,
      slideshowMode: slideshowMode,
      slideshowIntervalSeconds: slideshowInterval,
    );
    await ctrl.upsert(preset);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.original == null ? t.newPreset : t.editPreset),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(t.actionSave, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: t.fieldName),
          ),
          const SizedBox(height: 24),
          _Stepper(label: t.fieldPrepare, value: prepare, min: 0, max: 60,
              onChanged: (v) => setState(() => prepare = v)),
          const Divider(),
          _Stepper(label: t.fieldWork, value: work, min: 5, max: 600,
              onChanged: (v) => setState(() => work = v)),
          const Divider(),
          _Stepper(label: t.fieldRest, value: rest, min: 0, max: 600,
              onChanged: (v) => setState(() => rest = v)),
          const Divider(),
          _Stepper(label: t.fieldRounds, value: rounds, min: 1, max: 50,
              onChanged: (v) => setState(() => rounds = v)),
          const Divider(),
          _Stepper(label: t.fieldSets, value: sets, min: 1, max: 20,
              onChanged: (v) => setState(() => sets = v)),
          if (sets > 1) ...[
            const Divider(),
            _Stepper(label: t.fieldRestBetweenSets, value: restBetweenSets,
                min: 10, max: 600,
                onChanged: (v) => setState(() => restBetweenSets = v)),
          ],
          SectionHeader(t.imagesSection),
          ImageGalleryEditor(
            images: images,
            onChanged: (list) => setState(() => images = list),
          ),
          SectionHeader(t.slideshowSection),
          _SlideshowModeSelector(
            mode: slideshowMode,
            onChanged: (m) => setState(() => slideshowMode = m),
          ),
          if (slideshowMode != SlideshowMode.off) ...[
            const SizedBox(height: 8),
            _Stepper(
              label: t.slideshowInterval,
              value: slideshowInterval,
              min: 1,
              max: 60,
              onChanged: (v) => setState(() => slideshowInterval = v),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SlideshowModeSelector extends StatelessWidget {
  const _SlideshowModeSelector({required this.mode, required this.onChanged});

  final SlideshowMode mode;
  final ValueChanged<SlideshowMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SegmentedButton<SlideshowMode>(
      segments: [
        ButtonSegment(
          value: SlideshowMode.off,
          label: Text(t.slideshowModeOff),
        ),
        ButtonSegment(
          value: SlideshowMode.sequential,
          label: Text(t.slideshowModeSequential),
        ),
        ButtonSegment(
          value: SlideshowMode.random,
          label: Text(t.slideshowModeRandom),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (s) => onChanged(s.first),
      showSelectedIcon: false,
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final clamped = value.clamp(min, max);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              _StepBtn(
                icon: Icons.remove,
                onPressed: value > min ? () => onChanged(value - 1) : null,
              ),
              SizedBox(
                width: 56,
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFeatures: const [FontFeature.tabularFigures()],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              _StepBtn(
                icon: Icons.add,
                onPressed: value < max ? () => onChanged(value + 1) : null,
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: scheme.primary,
              inactiveTrackColor: scheme.outline,
              thumbColor: scheme.primary,
              overlayColor: scheme.primary.withValues(alpha: 0.12),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
              showValueIndicator: ShowValueIndicator.never,
              tickMarkShape: SliderTickMarkShape.noTickMark,
            ),
            child: Slider(
              value: clamped.toDouble(),
              min: min.toDouble(),
              max: max.toDouble(),
              divisions: max - min,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
