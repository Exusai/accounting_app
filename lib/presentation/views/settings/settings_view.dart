import 'package:flutter/material.dart';
import 'package:accounting_app/l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader(context, l10n.settings),
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: (bool value) {
            // TODO: Implement Theme Switching Bloc
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Theme switching not implemented yet')),
            );
          },
          secondary: const Icon(Icons.dark_mode),
        ),
        const Divider(),
        _buildSectionHeader(context, 'Data Management'),
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Export to CSV'),
          subtitle: const Text('Save your transactions to a CSV file'),
          onTap: () {
            // TODO: Implement CSV Export
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Export not implemented yet')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.picture_as_pdf),
          title: const Text('Export to PDF'),
          subtitle: const Text('Generate a PDF report'),
          onTap: () {
             // TODO: Implement PDF Export
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Export not implemented yet')),
            );
          },
        ),
        const Divider(),
        _buildSectionHeader(context, 'About'),
        const ListTile(
          leading: Icon(Icons.info),
          title: Text('Version'),
          subtitle: Text('1.0.0'),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
