import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/storage/preset_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../data/tabata_preset.dart';

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
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final t = AppLocalizations.of(context);
    final repo = await ref.read(presetRepositoryProvider.future);
    final preset = TabataPreset(
      id: widget.original?.id ?? repo.newId(),
      name: _name.text.trim().isEmpty ? t.untitled : _name.text.trim(),
      prepareSeconds: prepare,
      workSeconds: work,
      restSeconds: rest,
      rounds: rounds,
      sets: sets,
      restBetweenSetsSeconds: restBetweenSets,
    );
    await repo.upsert(preset);
    ref.invalidate(presetsProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.original == null ? t.newPreset : t.editPreset),
        actions: [
          TextButton(onPressed: _save, child: Text(t.actionSave)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
              labelText: t.fieldName,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          _NumberField(
            label: t.fieldPrepare,
            value: prepare,
            min: 0,
            max: 60,
            onChanged: (v) => setState(() => prepare = v),
          ),
          _NumberField(
            label: t.fieldWork,
            value: work,
            min: 5,
            max: 600,
            onChanged: (v) => setState(() => work = v),
          ),
          _NumberField(
            label: t.fieldRest,
            value: rest,
            min: 0,
            max: 600,
            onChanged: (v) => setState(() => rest = v),
          ),
          _NumberField(
            label: t.fieldRounds,
            value: rounds,
            min: 1,
            max: 50,
            onChanged: (v) => setState(() => rounds = v),
          ),
          _NumberField(
            label: t.fieldSets,
            value: sets,
            min: 1,
            max: 20,
            onChanged: (v) => setState(() => sets = v),
          ),
          if (sets > 1)
            _NumberField(
              label: t.fieldRestBetweenSets,
              value: restBetweenSets,
              min: 10,
              max: 600,
              onChanged: (v) => setState(() => restBetweenSets = v),
            ),
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: value > min ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 56,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}
