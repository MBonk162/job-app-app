import 'package:shared_preferences/shared_preferences.dart';
import '../../features/applications/domain/entities/application_entity.dart';

/// Service for managing sheet configuration (demo mode vs custom sheet)
class SheetConfigService {
  static const String _keyMode = 'sheet_config_mode';
  static const String _keySheetId = 'sheet_config_sheet_id';
  static const String _keySheetTitle = 'sheet_config_sheet_title';

  /// Load saved configuration
  static Future<SheetConfig> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_keyMode) ?? 'demo';
    final sheetId = prefs.getString(_keySheetId);
    final sheetTitle = prefs.getString(_keySheetTitle);

    return SheetConfig(
      mode: mode == 'demo' ? SheetMode.demo : SheetMode.custom,
      sheetId: sheetId,
      sheetTitle: sheetTitle,
    );
  }

  /// Save configuration
  static Future<void> saveConfig(SheetConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyMode, config.mode == SheetMode.demo ? 'demo' : 'custom');
    if (config.sheetId != null) {
      await prefs.setString(_keySheetId, config.sheetId!);
    }
    if (config.sheetTitle != null) {
      await prefs.setString(_keySheetTitle, config.sheetTitle!);
    }
  }

  /// Set demo mode
  static Future<void> setDemoMode() async {
    await saveConfig(SheetConfig(mode: SheetMode.demo));
  }

  /// Set custom sheet mode
  static Future<void> setCustomSheet(String sheetId, String? title) async {
    await saveConfig(SheetConfig(
      mode: SheetMode.custom,
      sheetId: sheetId,
      sheetTitle: title,
    ));
  }
}

/// Sheet configuration mode
enum SheetMode { demo, custom }

/// Sheet configuration data class
class SheetConfig {
  final SheetMode mode;
  final String? sheetId;
  final String? sheetTitle;

  SheetConfig({
    required this.mode,
    this.sheetId,
    this.sheetTitle,
  });

  bool get isDemo => mode == SheetMode.demo;
}

/// Demo data for portfolio showcase
class DemoData {
  static List<ApplicationEntity> getDemoApplications() {
    return [
      ApplicationEntity(
        id: 'demo-1',
        sheetRowId: 2,
        dateApplied: DateTime(2025, 1, 2),
        company: 'Stripe',
        roleTitle: 'Senior Full Stack Engineer',
        source: 'LinkedIn',
        applicationMethod: 'Full Application',
        salaryMin: 180000,
        salaryMax: 220000,
        location: 'Remote',
        companySize: 'Enterprise 1000+',
        roleType: 'Full-Stack',
        techStack: 'Ruby, React, TypeScript, PostgreSQL',
        customized: true,
        referral: false,
        confidenceMatch: 5,
        responseDate: DateTime(2025, 1, 8),
        responseType: 'Phone',
        interviewDate: DateTime(2025, 1, 15),
        status: ApplicationStatus.technical,
        notes: 'Great interview experience, technical round scheduled',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-2',
        sheetRowId: 3,
        dateApplied: DateTime(2025, 1, 5),
        company: 'Vercel',
        roleTitle: 'Frontend Engineer',
        source: 'Company Site',
        applicationMethod: 'Full Application',
        salaryMin: 160000,
        salaryMax: 200000,
        location: 'Remote',
        companySize: 'Mid 100-1000',
        roleType: 'Frontend',
        techStack: 'Next.js, React, TypeScript, Tailwind',
        customized: true,
        referral: true,
        confidenceMatch: 5,
        responseDate: DateTime(2025, 1, 10),
        responseType: 'Email',
        interviewDate: DateTime(2025, 1, 18),
        status: ApplicationStatus.phoneScreen,
        notes: 'Referred by former colleague, excited about the role',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-3',
        sheetRowId: 4,
        dateApplied: DateTime(2025, 1, 8),
        company: 'Notion',
        roleTitle: 'Software Engineer',
        source: 'LinkedIn',
        applicationMethod: 'Quick Apply',
        salaryMin: 150000,
        salaryMax: 190000,
        location: 'San Francisco, CA',
        companySize: 'Mid 100-1000',
        roleType: 'Full-Stack',
        techStack: 'TypeScript, React, Node.js, PostgreSQL',
        customized: false,
        referral: false,
        confidenceMatch: 4,
        responseDate: null,
        responseType: null,
        interviewDate: null,
        status: ApplicationStatus.applied,
        notes: 'Dream company, waiting to hear back',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-4',
        sheetRowId: 5,
        dateApplied: DateTime(2025, 1, 10),
        company: 'Figma',
        roleTitle: 'Full Stack Developer',
        source: 'Indeed',
        applicationMethod: 'Full Application',
        salaryMin: 170000,
        salaryMax: 210000,
        location: 'Remote',
        companySize: 'Mid 100-1000',
        roleType: 'Full-Stack',
        techStack: 'C++, TypeScript, React, WebGL',
        customized: true,
        referral: false,
        confidenceMatch: 3,
        responseDate: DateTime(2025, 1, 15),
        responseType: 'Rejection',
        interviewDate: null,
        status: ApplicationStatus.rejected,
        notes: 'Position filled internally',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-5',
        sheetRowId: 6,
        dateApplied: DateTime(2025, 1, 12),
        company: 'Datadog',
        roleTitle: 'Backend Engineer',
        source: 'Recruiter',
        applicationMethod: 'Email',
        salaryMin: 165000,
        salaryMax: 200000,
        location: 'New York, NY',
        companySize: 'Enterprise 1000+',
        roleType: 'Backend',
        techStack: 'Go, Python, Kubernetes, AWS',
        customized: true,
        referral: false,
        confidenceMatch: 4,
        responseDate: DateTime(2025, 1, 14),
        responseType: 'Phone',
        interviewDate: DateTime(2025, 1, 20),
        status: ApplicationStatus.phoneScreen,
        notes: 'Recruiter reached out, strong fit for observability team',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-6',
        sheetRowId: 7,
        dateApplied: DateTime(2025, 1, 14),
        company: 'Cloudflare',
        roleTitle: 'Systems Engineer',
        source: 'LinkedIn',
        applicationMethod: 'Full Application',
        salaryMin: 175000,
        salaryMax: 215000,
        location: 'Austin, TX',
        companySize: 'Enterprise 1000+',
        roleType: 'Backend',
        techStack: 'Rust, Go, Linux, Networking',
        customized: true,
        referral: false,
        confidenceMatch: 4,
        responseDate: null,
        responseType: null,
        interviewDate: null,
        status: ApplicationStatus.applied,
        notes: 'Interesting edge computing work',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-7',
        sheetRowId: 8,
        dateApplied: DateTime(2025, 1, 16),
        company: 'Linear',
        roleTitle: 'Product Engineer',
        source: 'Company Site',
        applicationMethod: 'Full Application',
        salaryMin: 155000,
        salaryMax: 195000,
        location: 'Remote',
        companySize: 'Startup <100',
        roleType: 'Full-Stack',
        techStack: 'TypeScript, React, GraphQL, PostgreSQL',
        customized: true,
        referral: false,
        confidenceMatch: 5,
        responseDate: DateTime(2025, 1, 19),
        responseType: 'Email',
        interviewDate: DateTime(2025, 1, 25),
        status: ApplicationStatus.response,
        notes: 'Love their product philosophy',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-8',
        sheetRowId: 9,
        dateApplied: DateTime(2025, 1, 18),
        company: 'Supabase',
        roleTitle: 'Developer Advocate',
        source: 'Referral',
        applicationMethod: 'Email',
        salaryMin: 140000,
        salaryMax: 180000,
        location: 'Remote',
        companySize: 'Startup <100',
        roleType: 'Developer Relations',
        techStack: 'PostgreSQL, TypeScript, Technical Writing',
        customized: true,
        referral: true,
        confidenceMatch: 4,
        responseDate: null,
        responseType: null,
        interviewDate: null,
        status: ApplicationStatus.applied,
        notes: 'Interesting blend of coding and community work',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-9',
        sheetRowId: 10,
        dateApplied: DateTime(2025, 1, 20),
        company: 'Anthropic',
        roleTitle: 'Software Engineer - Platform',
        source: 'Company Site',
        applicationMethod: 'Full Application',
        salaryMin: 200000,
        salaryMax: 280000,
        location: 'San Francisco, CA',
        companySize: 'Mid 100-1000',
        roleType: 'Backend',
        techStack: 'Python, Kubernetes, ML Infrastructure',
        customized: true,
        referral: false,
        confidenceMatch: 4,
        responseDate: null,
        responseType: null,
        interviewDate: null,
        status: ApplicationStatus.applied,
        notes: 'Excited about AI safety mission',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
      ApplicationEntity(
        id: 'demo-10',
        sheetRowId: 11,
        dateApplied: DateTime(2025, 1, 22),
        company: 'Planetscale',
        roleTitle: 'Database Engineer',
        source: 'LinkedIn',
        applicationMethod: 'Quick Apply',
        salaryMin: 160000,
        salaryMax: 200000,
        location: 'Remote',
        companySize: 'Startup <100',
        roleType: 'Backend',
        techStack: 'MySQL, Vitess, Go, Kubernetes',
        customized: false,
        referral: false,
        confidenceMatch: 3,
        responseDate: null,
        responseType: null,
        interviewDate: null,
        status: ApplicationStatus.applied,
        notes: 'Would need to ramp up on Vitess',
        isDirty: false,
        lastModified: DateTime.now(),
        lastSynced: DateTime.now(),
      ),
    ];
  }
}
