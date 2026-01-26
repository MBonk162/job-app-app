import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/services/sheet_config_service.dart';
import 'features/applications/presentation/providers/applications_provider.dart';
import 'features/applications/presentation/screens/add_application_screen.dart';
import 'features/applications/presentation/screens/edit_application_screen.dart';
import 'features/applications/presentation/screens/debug_database_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/screens/sign_in_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: JobTrackerApp(),
    ),
  );
}

class JobTrackerApp extends ConsumerWidget {
  const JobTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedIn = ref.watch(isSignedInProvider);

    return MaterialApp(
      title: 'Job Application Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: isSignedIn ? const HomeScreen() : const SignInScreen(),
    );
  }
}

/// Main home screen with navigation
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // Screens for navigation
  final List<Widget> _screens = [
    const PlaceholderScreen(title: 'Dashboard'),
    const ApplicationsListScreen(),
    const PlaceholderScreen(title: 'Analytics'),
  ];

  void _showSheetConfigDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController sheetIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Source'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current status
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppConstants.isDemoMode
                      ? Colors.amber.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConstants.isDemoMode ? Colors.amber : Colors.green,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      AppConstants.isDemoMode ? Icons.science : Icons.check_circle,
                      color: AppConstants.isDemoMode ? Colors.amber : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppConstants.isDemoMode
                          ? 'Currently in Demo Mode'
                          : 'Connected to your sheet',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppConstants.isDemoMode ? Colors.amber[800] : Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Demo mode option
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Radio<bool>(
                  value: true,
                  groupValue: AppConstants.isDemoMode,
                  onChanged: (value) {
                    AppConstants.enableDemoMode();
                    SheetConfigService.setDemoMode();
                    ref.invalidate(applicationsProvider);
                    Navigator.pop(context);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Switched to Demo Mode'),
                        backgroundColor: Colors.amber,
                      ),
                    );
                  },
                ),
                title: const Text('Demo Mode'),
                subtitle: const Text('View sample data to explore the app'),
              ),

              const Divider(),

              // Custom sheet option
              const Text(
                'Connect Your Own Sheet',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: sheetIdController,
                decoration: const InputDecoration(
                  hintText: 'Paste Sheet ID or URL',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final input = sheetIdController.text.trim();
                    if (input.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a Sheet ID'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Extract sheet ID from URL if needed
                    String sheetId = input;
                    final urlMatch = RegExp(r'/spreadsheets/d/([a-zA-Z0-9-_]+)')
                        .firstMatch(input);
                    if (urlMatch != null) {
                      sheetId = urlMatch.group(1)!;
                    }

                    AppConstants.disableDemoMode(sheetId);
                    SheetConfigService.setCustomSheet(sheetId, null);
                    ref.invalidate(applicationsProvider);
                    Navigator.pop(context);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Connected to custom sheet'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Connect'),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Note: Your sheet must be shared with your Google account and have the same column structure.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
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

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isOfflineMode = ref.watch(offlineModeProvider);
    final syncStatus = ref.watch(syncStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Application Tracker'),
        actions: [
          // Sync button
          IconButton(
            icon: syncStatus == SyncStatus.syncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.sync),
            tooltip: 'Sync with Google Sheets',
            onPressed: currentUser != null && syncStatus != SyncStatus.syncing
                ? () async {
                    // Start sync
                    ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.syncing);

                    try {
                      final syncFunction = ref.read(syncApplicationsProvider);
                      final result = await syncFunction();

                      if (result.hasErrors) {
                        ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.error);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sync failed: ${result.errors.join(', ')}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.success);
                        ref.read(lastSyncTimeProvider.notifier).update(DateTime.now());

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Sync complete: ${result.downloaded} downloaded, ${result.uploaded} uploaded',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.error);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sync error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } finally {
                      // Reset status after a delay
                      Future.delayed(const Duration(seconds: 2), () {
                        ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.idle);
                      });
                    }
                  }
                : null, // Disabled in offline mode or while syncing
          ),
          // Menu button
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'sheetConfig':
                  _showSheetConfigDialog(context, ref);
                  break;
                case 'debug':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DebugDatabaseScreen(),
                    ),
                  );
                  break;
                case 'clearResync':
                  // Show confirmation dialog
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear & Re-sync'),
                      content: const Text(
                        'This will delete all local data and re-download from Google Sheets. '
                        'Any unsaved changes will be lost. Continue?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(foregroundColor: Colors.orange),
                          child: const Text('Clear & Re-sync'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true && context.mounted) {
                    ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.syncing);

                    try {
                      final clearAndResyncFunction = ref.read(clearAndResyncProvider);
                      final result = await clearAndResyncFunction();

                      if (result.hasErrors) {
                        ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.error);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Clear & re-sync failed: ${result.errors.join(', ')}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.success);
                        ref.read(lastSyncTimeProvider.notifier).update(DateTime.now());

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Clear & re-sync complete: ${result.downloaded} downloaded'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.error);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Clear & re-sync error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } finally {
                      Future.delayed(const Duration(seconds: 2), () {
                        ref.read(syncStatusProvider.notifier).setStatus(SyncStatus.idle);
                      });
                    }
                  }
                  break;
                case 'signout':
                  if (currentUser != null) {
                    await ref.read(currentUserProvider.notifier).signOut();
                  } else {
                    // Offline mode - just reset the flag
                    ref.read(offlineModeProvider.notifier).disable();
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'sheetConfig',
                child: Row(
                  children: [
                    Icon(
                      AppConstants.isDemoMode ? Icons.science : Icons.table_chart,
                      color: AppConstants.isDemoMode ? Colors.amber : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(AppConstants.isDemoMode ? 'Demo Mode' : 'Connected Sheet'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'debug',
                child: Row(
                  children: [
                    Icon(Icons.bug_report),
                    SizedBox(width: 8),
                    Text('Debug Database'),
                  ],
                ),
              ),
              if (currentUser != null)
                const PopupMenuItem(
                  value: 'clearResync',
                  child: Row(
                    children: [
                      Icon(Icons.refresh, color: Colors.orange),
                      SizedBox(width: 8),
                      Text('Clear & Re-sync'),
                    ],
                  ),
                ),
              if (currentUser != null || isOfflineMode)
                PopupMenuItem(
                  value: 'signout',
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      const SizedBox(width: 8),
                      Text(currentUser != null ? 'Sign Out' : 'Exit Offline Mode'),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Demo mode banner
          if (AppConstants.isDemoMode)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.amber,
              child: const Row(
                children: [
                  Icon(Icons.science, size: 16, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Demo Mode: Viewing sample data',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          // Main content
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddApplicationScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

/// Placeholder screen for testing navigation
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'This screen is under construction',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          const SizedBox(height: 24),
          const Card(
            margin: EdgeInsets.all(24),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✅ Flutter project created',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ Dependencies configured',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ Project structure set up',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ Core utilities created',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ Basic navigation working',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '🚧 Next: Database, API integration, and feature screens',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Applications List Screen - Shows all applications from database
class ApplicationsListScreen extends ConsumerWidget {
  const ApplicationsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsAsync = ref.watch(applicationsProvider);

    return applicationsAsync.when(
      data: (applications) {
        if (applications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.work_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No applications yet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tap the + button to add a test application',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Header with count and debug button
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                children: [
                  Text(
                    '${applications.length} application${applications.length == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DebugDatabaseScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bug_report, size: 18),
                    label: const Text('Debug DB'),
                  ),
                ],
              ),
            ),

            // List of applications
            Expanded(
              child: ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  final app = applications[index];
                  final statusColor = AppTheme.getStatusColor(app.status.displayName);

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditApplicationScreen(application: app),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Company name - PROMINENT
                            Text(
                              app.company,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Role title
                            Text(
                              app.roleTitle,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Status badge and date
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    app.status.displayName,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  '${app.daysSinceApplied} days ago',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const Spacer(),
                                Icon(Icons.chevron_right, color: Colors.grey[400]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
          ],
        ),
      ),
    );
  }
}
