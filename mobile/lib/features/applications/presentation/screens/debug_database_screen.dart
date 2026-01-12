import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database_provider.dart';

/// Debug screen to view raw database data
class DebugDatabaseScreen extends ConsumerWidget {
  const DebugDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug: Database'),
      ),
      body: FutureBuilder(
        future: database.getAllApplications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final applications = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Database Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('Total Records: ${applications.length}'),
                      Text('Table: applications'),
                      Text('Database: job_tracker.sqlite'),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () => _showSqlQuery(context, database),
                        icon: const Icon(Icons.code),
                        label: const Text('Run SQL Query'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Applications Table
              ...applications.map((app) => Card(
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        child: Text(app.company.substring(0, 1)),
                      ),
                      title: Text(app.company),
                      subtitle: Text('${app.roleTitle} - ${app.status}'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildField('ID', app.id),
                              _buildField('Sheet Row ID', app.sheetRowId?.toString() ?? 'null'),
                              _buildField('Date Applied', app.dateApplied),
                              _buildField('Company', app.company),
                              _buildField('Role Title', app.roleTitle),
                              _buildField('Status', app.status),
                              _buildField('Source', app.source),
                              _buildField('Application Method', app.applicationMethod),
                              _buildField('Location', app.location),
                              _buildField('Company Size', app.companySize),
                              _buildField('Role Type', app.roleType),
                              _buildField('Tech Stack', app.techStack),
                              _buildField('Salary Min', app.salaryMin?.toString() ?? 'null'),
                              _buildField('Salary Max', app.salaryMax?.toString() ?? 'null'),
                              _buildField('Customized', app.customized),
                              _buildField('Referral', app.referral),
                              _buildField('Confidence Match', app.confidenceMatch?.toString() ?? 'null'),
                              _buildField('Response Date', app.responseDate ?? 'null'),
                              _buildField('Response Type', app.responseType ?? 'null'),
                              _buildField('Interview Date', app.interviewDate ?? 'null'),
                              _buildField('Notes', app.notes),
                              _buildField('Is Dirty', app.isDirty.toString()),
                              _buildField('Last Modified', app.lastModified),
                              _buildField('Last Synced', app.lastSynced ?? 'null'),
                              const SizedBox(height: 8),
                              ElevatedButton.icon(
                                onPressed: () => _copyToClipboard(context, app),
                                icon: const Icon(Icons.copy),
                                label: const Text('Copy as JSON'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildField(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SelectableText(
              value.toString(),
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, dynamic app) {
    final json = '''
{
  "id": "${app.id}",
  "sheetRowId": ${app.sheetRowId},
  "dateApplied": "${app.dateApplied}",
  "company": "${app.company}",
  "roleTitle": "${app.roleTitle}",
  "status": "${app.status}",
  "source": "${app.source}",
  "applicationMethod": "${app.applicationMethod}",
  "location": "${app.location}",
  "companySize": "${app.companySize}",
  "roleType": "${app.roleType}",
  "techStack": "${app.techStack}",
  "salaryMin": ${app.salaryMin},
  "salaryMax": ${app.salaryMax},
  "customized": "${app.customized}",
  "referral": "${app.referral}",
  "confidenceMatch": ${app.confidenceMatch},
  "responseDate": "${app.responseDate}",
  "responseType": "${app.responseType}",
  "interviewDate": "${app.interviewDate}",
  "notes": "${app.notes}",
  "isDirty": ${app.isDirty},
  "lastModified": "${app.lastModified}",
  "lastSynced": "${app.lastSynced}"
}
''';

    Clipboard.setData(ClipboardData(text: json));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  void _showSqlQuery(BuildContext context, database) {
    final controller = TextEditingController(text: 'SELECT * FROM applications LIMIT 10;');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Run SQL Query'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter SQL query:'),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'SELECT * FROM applications;',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: Only SELECT queries are safe in debug mode',
              style: TextStyle(fontSize: 12, color: Colors.orange),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final query = controller.text;
              Navigator.pop(context);
              _executeQuery(context, database, query);
            },
            child: const Text('Run'),
          ),
        ],
      ),
    );
  }

  Future<void> _executeQuery(BuildContext context, database, String query) async {
    try {
      // For safety, we'll only show the getAllApplications result
      // In production, you'd want to sanitize and execute custom queries
      final results = await database.getAllApplications();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Query Results'),
            content: SingleChildScrollView(
              child: Text(
                'Found ${results.length} records\n\n${results.map((r) => '${r.company} - ${r.roleTitle}').join('\n')}',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
