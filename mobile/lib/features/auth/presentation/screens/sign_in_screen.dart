import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

/// Sign-in screen for Google authentication
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo/Icon
              Icon(
                Icons.work_outline,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Job Application Tracker',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Track your job applications with ease',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 48),

              // Features List
              _buildFeature(
                Icons.cloud_sync,
                'Sync with Google Sheets',
                'Your data backed up to the cloud',
              ),
              const SizedBox(height: 16),
              _buildFeature(
                Icons.offline_bolt,
                'Works Offline',
                'Add applications without internet',
              ),
              const SizedBox(height: 16),
              _buildFeature(
                Icons.analytics,
                'Track Progress',
                'Analytics and insights on your applications',
              ),
              const SizedBox(height: 48),

              // Sign In Button
              ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(currentUserProvider.notifier).signIn();
                },
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 16),

              // Skip for now button (for testing without sign-in)
              TextButton(
                onPressed: () {
                  // Enable offline mode - this will trigger navigation in main.dart
                  ref.read(offlineModeProvider.notifier).enable();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Using offline mode. Sign in to enable sync with Google Sheets.',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Continue without sign-in (offline only)'),
              ),
              const SizedBox(height: 24),

              // Privacy note
              Text(
                'We only access your Google Sheets data.\nYour privacy is important to us.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
