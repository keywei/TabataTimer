import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/history/presentation/history_page.dart';
import '../features/presets/data/tabata_preset.dart';
import '../features/presets/presentation/preset_editor_page.dart';
import '../features/presets/presentation/preset_list_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/timer/presentation/timer_page.dart';
import '../shell/home_shell.dart';

final _rootKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/presets',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, shell) => HomeShell(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/presets',
              builder: (_, _) => const PresetListPage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (_, state) =>
                      PresetEditorPage(original: state.extra as TabataPreset?),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (_, _) => const HistoryPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (_, _) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/timer',
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) => MaterialPage(
        fullscreenDialog: true,
        child: TimerPage(preset: state.extra as TabataPreset),
      ),
    ),
  ],
);
