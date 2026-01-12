# Job Application Tracker - Flutter Mobile App

A Flutter Android mobile application for tracking job applications with Google Sheets synchronization.

## 📱 Project Status

**Current Version:** MVP (Minimum Viable Product)
**Status:** ✅ Core functionality complete, ready for testing

### ✅ Completed Features

#### Phase 1-3: Foundation & Database
- [x] Flutter project structure with Clean Architecture
- [x] Riverpod 3.x state management
- [x] Drift (SQLite) local database with 19 fields + sync metadata
- [x] Material Design 3 theme with dark mode support
- [x] Bottom navigation (Dashboard, Applications, Analytics tabs)

#### Phase 4: Forms & CRUD
- [x] **Add Application** - 19-field form with validation
- [x] **Edit Application** - Full edit screen with all fields
- [x] **Delete Application** - With confirmation dialog
- [x] **View Applications** - Improved card layout with prominent company name
- [x] Offline-first architecture (all CRUD works without internet)

#### Phase 5: Google Authentication
- [x] Google Sign-In integration (version 6.2.1)
- [x] Offline mode option for testing without authentication
- [x] Sign-out functionality
- [x] Authentication state management

#### Phase 6: Google Sheets Sync
- [x] Google Sheets API data source (GET, POST, PUT, DELETE)
- [x] Two-way sync engine (download from Sheets, upload dirty records)
- [x] Conflict detection (last-write-wins strategy)
- [x] Sync status indicators in UI
- [x] Manual sync button with visual feedback
- [x] Timezone-safe date handling (matching web app fix)

#### UI/UX Improvements
- [x] **Prominent company name** on application cards (20px, bold)
- [x] Tap-to-edit functionality on all application cards
- [x] Visual status badges with color coding
- [x] Clean card layout with clear hierarchy
- [x] Debug database viewer for development

### 🚧 Not Yet Implemented

#### Analytics & Dashboard (Phase 7)
- [ ] Dashboard stats cards (total apps, response rate, active pipeline)
- [ ] Applications over time chart (fl_chart)
- [ ] Response rate by source chart
- [ ] Company size distribution chart
- [ ] Interactive analytics screen

#### Advanced Features (Future)
- [ ] Pull-to-refresh on applications list
- [ ] Automatic sync on app launch
- [ ] Background sync with WorkManager
- [ ] Conflict resolution UI (currently keeps local version)
- [ ] Search and filter functionality
- [ ] Sort by different fields
- [ ] Batch operations
- [ ] iOS support

## 🧪 Testing

### Test 1: Offline Mode (No Setup Required)
1. Launch app
2. Click **"Continue without sign-in (offline only)"**
3. Tap **+ button** to add an application
4. Fill out the form and save
5. Verify it appears in the list
6. **Tap the application card** to edit it
7. Make changes and update
8. Menu → **"Debug Database"** to verify data

### Test 2: Google Sign-In (After OAuth Setup)
1. Complete Google Cloud OAuth setup
2. Launch app
3. Click **"Sign in with Google"**
4. Sign in with mitchbonkowski@gmail.com
5. Grant permissions

### Test 3: Sync to Google Sheets
1. Sign in
2. Add an application
3. Click **sync button** (⟳ icon, top-right)
4. Open Google Sheet in browser to verify

## 🚀 Next Steps

1. **Complete OAuth Setup** - Finish Google Cloud Console configuration
2. **Test End-to-End Sync** - Verify sync works between mobile and web
3. **Implement Analytics Dashboard** - Stats cards and charts
4. **Add Auto-Sync** - Sync on app launch when online

---

**Last Updated:** January 12, 2026
**Status:** MVP Complete - Ready for OAuth setup and testing
