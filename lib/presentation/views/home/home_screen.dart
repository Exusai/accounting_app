import 'package:accounting_app/presentation/views/dashboard/dashboard_view.dart';
import 'package:accounting_app/presentation/views/settings/settings_view.dart';
// import 'package:accounting_app/presentation/views/transactions/transactions_view.dart';
import 'package:accounting_app/presentation/views/insert_data/insert_data_dialog.dart';
import 'package:flutter/material.dart';
import 'package:accounting_app/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile Layout
          return Scaffold(
            body: _screens[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.dashboard_outlined),
                  selectedIcon: const Icon(Icons.dashboard),
                  label: l10n.dashboard,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: l10n.settings,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const InsertDataDialog(),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        } else {
          // Desktop / Tablet Layout
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    NavigationRailDestination(
                      icon: const Icon(Icons.dashboard_outlined),
                      selectedIcon: const Icon(Icons.dashboard),
                      label: Text(l10n.dashboard),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.settings_outlined),
                      selectedIcon: const Icon(Icons.settings),
                      label: Text(l10n.settings),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
               onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const InsertDataDialog(),
                );
              },
              tooltip: l10n.addTransaction,
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
}
