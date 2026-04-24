# 3MT — New Session Briefing (Updated v1.1)
## Gap Analysis, Q&A, and Answers for Coding AI
*Targeting: Android 8.0+ | Scoped Storage | 2026 Compliance*

---

## PART 1 — CONTEXT FOR NEW SESSION

App name: 3MT (My Money Management & Tracker)
Stack: Flutter + Dart + sqflite + Riverpod + go_router + fl_chart
R&D document: 3MT-RD-Document.md (attached)
Prototype screens: Dashboard.png, Earnings.png, Expenses.png,
                   Savings.png, Settings.png (approved with deviations)

The R&D is the single source of truth. Prototype screens are
visual references only. Where they conflict with the R&D,
the R&D wins. All deviations from prototype are documented
in Section 5 of the R&D.

---

## PART 2 — QUESTIONS A CODING AI WOULD ASK + ANSWERS

### FLUTTER PROJECT SETUP

Q: What should the Flutter app package name be?
A: com.threetmt.app

Q: What should the app display name be on the phone?
A: 3MT

Q: What Android SDK versions should be used?
A: minSdkVersion 26 (Android 8.0+)
   targetSdkVersion 35 (Android 15 / 2026 Compliance)

Q: Should I use Material 2 or Material 3?
A: Material 3 (Material You) with useMaterial3: true
   Override all component defaults with custom design system
   colors — do not use Material 3 color scheme generation

Q: What orientation should the app support?
A: Portrait only. Lock landscape.
   Add to AndroidManifest.xml:
   android:screenOrientation="portrait"

Q: Should I use null safety?
A: Yes. Full null safety. All Dart files use sound null safety.

---

### FONTS

Q: Where do I download the 3 custom fonts?
A: All 3 are free on Google Fonts:
   Instrument Serif: fonts.google.com/specimen/Instrument+Serif
   DM Sans: fonts.google.com/specimen/DM+Sans
   JetBrains Mono: fonts.google.com/specimen/JetBrains+Mono

Q: Which weights/styles are needed for each font?
A: Instrument Serif: Regular only
   DM Sans: Regular (400), Medium (500), Bold (700)
   JetBrains Mono: Regular only

Q: What font sizes to use for which elements?
A: Balance display number (Available to Spend): 42px
   Section titles: 16px DM Sans Medium
   Card titles: 15px DM Sans Medium
   Body / labels: 13px DM Sans Regular
   Secondary / subtitles: 11px DM Sans Regular
   Amount values: 14px JetBrains Mono Regular
   Large amount values (history rows): 15px JetBrains Mono Regular
   Tiny labels (column headers in summary): 10px DM Sans Regular

---

### NAVIGATION & ROUTING

Q: What are the exact route paths for go_router?
A: /dashboard         → DashboardScreen
   /earn              → EarnScreen
   /spend             → SpendScreen
   /save              → SaveScreen
   /settings          → SettingsScreen
   /settings/categories/earning  → CategoryManagementScreen(type:'earning')
   /settings/categories/expense  → CategoryManagementScreen(type:'expense')
   /settings/categories/saving   → CategoryManagementScreen(type:'saving')

Q: Is the bottom nav a StatefulShellRoute or separate routes?
A: Use StatefulShellRoute with 4 branches so tab state is
   preserved when switching between tabs.
   Dashboard, Earn, Spend, Save are the 4 branches.

Q: What happens when back button is pressed on Dashboard?
A: Exit the app. Dashboard is the root screen.
   Use PopScope or WillPopScope to handle Android back button.

Q: What happens when back button is pressed on Settings?
A: Navigate back to whichever tab the user came from.
   go_router handles this automatically with pop().

Q: Does the bottom nav show on Settings screen?
A: No. Settings has no bottom nav bar.

Q: Does the bottom nav show on Category Management screen?
A: No. Category Management is a sub-screen of Settings.

---

### STATE MANAGEMENT

Q: What type of Riverpod providers to use for each concern?
A: selected_month_provider   → StateProvider<DateTime>
   entries_provider          → FutureProvider.family<List<Entry>, DateTime>
                               (parameterised by selected month)
   categories_provider       → FutureProvider.family<List<Category>, String>
                               (parameterised by type: earning/expense/saving)
   summary_provider          → FutureProvider.family<MonthSummary, DateTime>
                               (parameterised by selected month)
   settings_provider         → StateNotifierProvider<SettingsNotifier, Map<String,String>>
   budget_limits_provider    → FutureProvider<List<BudgetLimit>>
   saving_goals_provider     → FutureProvider<List<SavingGoal>>

Q: After inserting/updating/deleting an entry, how do I refresh the list?
A: Use ref.invalidate(entriesProvider) and ref.invalidate(summaryProvider)
   after every DB write operation. This triggers all watchers to rebuild.

Q: Should providers be scoped or global?
A: Global (defined at root level). Use ProviderScope at app root.

---

### DATABASE

Q: How do I detect first launch to seed default data?
A: In database_helper.dart onCreate callback:
   Call seed.dart insertDefaultCategories() and
   insertDefaultSettings() inside the onCreate block.
   onCreate only runs when the DB file does not exist yet.

Q: What is the database filename?
A: 3mt_database.db

Q: Should I implement database migrations (onUpgrade)?
A: Yes. Set version: 1 now.
   onUpgrade scaffold should be present but empty for now.
   Future milestones may add columns.

Q: How do I filter entries by month when month_start is not 1st?
A: month_start setting affects the definition of "this month."
   If month_start = '1': month = calendar month (Apr 1 – Apr 30)
   If month_start = '15': month = Apr 15 – May 14
   If month_start = '25': month = Mar 25 – Apr 24
   date_helpers.dart must expose:
     getMonthRange(DateTime selected, int startDay)
     → returns {start: DateTime, end: DateTime}
   All DB queries use this range, not a simple month= filter.

Q: How do I generate UUIDs for primary keys?
A: Use the uuid package: Uuid().v4()
   Import: import 'package:uuid/uuid.dart';

Q: What datetime format is stored in created_at and date fields?
A: date field (entries): 'YYYY-MM-DD' e.g. '2026-04-22'
   created_at field: ISO 8601 full datetime '2026-04-22T10:32:00'
   Use intl package for formatting and parsing.

Q: How do I handle the FK relationship (category_id) when
   a category is deleted?
A: SQLite FK enforcement is OFF by default in sqflite.
   Do NOT enable FK enforcement.
   On category delete: do NOT cascade delete entries.
   Entries with deleted category_id are kept.
   In UI: query category name by id; if not found,
   display "Deleted Category" in #7B7B9A italic.

---

### ENTRY FORM

Q: When user taps amount field showing "0", does it clear or
   does cursor appear at end?
A: Clears to empty on first tap. User types fresh.
   Use a TextEditingController, clear on focus.

Q: What keyboard type for amount input?
A: TextInputType.numberWithOptions(decimal: false)
   No decimal points — BDT amounts are whole numbers only.

Q: What is the maximum amount a user can enter?
A: No enforced maximum. No validation on amount size.
   Just must be > 0 to save.

Q: Can a user enter a future date for an entry?
A: Yes. Native date picker allows any date.
   No restriction on past or future.

Q: When recurring is toggled ON then OFF, do the frequency
   chips disappear?
A: Yes. Frequency chips are only visible when Recurring = ON.
   Animate out with same 300ms slide when toggled OFF.

Q: If user saves a recurring entry, does the recurring rule
   use the entry's date as next_date?
A: Yes. next_date = entry date + 1 period.
   If entry date = Apr 22 and period = monthly:
   next_date = May 22.
   If entry date = Apr 22 and period = weekly:
   next_date = Apr 29.

Q: What happens if user edits a recurring entry (swipe right)?
A: Edits apply to THAT ENTRY ONLY.
   The recurring rule is NOT updated.
   The rule continues auto-creating from its own next_date.

Q: What if user deletes a recurring entry?
A: Deletes THAT ENTRY ONLY. Rule is not affected.
   Rule continues creating future entries.

Q: Is there a way to stop a recurring rule from the UI?
A: Not in M1–M6. Marked as future feature.
   Do not build it. Do not mention it in UI.

---

### CATEGORY CHIPS

Q: What happens if the user's last used category was deleted
   since their last session?
A: Fall back to the first category in sort_order for that type.
   If no categories exist at all: show only [+ New] chip.

Q: Can the user delete ALL categories including defaults?
A: No. is_default = 1 categories cannot be deleted.
   There will always be at least the default categories.

Q: What if the user creates a category with the same name as
   an existing one?
A: Allow it. No duplicate name validation.
   Categories are identified by UUID, not name.

Q: How many characters maximum for a category name?
A: 20 characters. Enforce with maxLength on the input.

Q: When user adds a new category via [+ New] chip, does it
   appear at the end of the chip list or beginning?
A: End of the list, before [+ New] chip.
   sort_order = max(existing sort_order) + 1

---

### SWIPE INTERACTIONS

Q: What Flutter widget to use for swipe-to-delete?
A: Dismissible widget with confirmDismiss for the undo logic.
   direction: DismissDirection.endToStart for left swipe.

Q: What Flutter widget for swipe-to-edit (right swipe)?
A: Dismissible with direction: DismissDirection.startToEnd
   But instead of dismissing, expand the row inline.
   Use AnimatedContainer for the expansion.

Q: Can both swipes be active on the same row simultaneously?
A: Yes. Use Dismissible with both backgrounds defined.
   background (right swipe): edit color/icon
   secondaryBackground (left swipe): delete color/icon

Q: What color is the delete background revealed on swipe left?
A: #FF4D6D with a white trash icon centered right-aligned.

Q: What color is the edit background revealed on swipe right?
A: #1E1E2E (surface color) with a white edit/pencil icon.

---

### DASHBOARD CARDS

Q: In the Balance Card Zone 2 segmented bar — what if
   availableToSpend is negative (user spent more than earned)?
A: Show the bar as fully red (#FF4D6D) — no gold segment.
   Available label shows negative amount in red.
   Saved label still shows gold but note it is ring-fenced.

Q: What if totalSaved > netBalance (edge case)?
A: availableToSpend becomes negative.
   Show negative Available to Spend in red in Zone 1.
   Zone 2 bar: full red, no segments.
   This is a valid state — user overspent.

Q: In the Targets card, what if ONLY save target is set
   (spend = 0) or ONLY spend target is set (save = 0)?
A: Show only the row that has a non-zero target.
   If save% = 0: hide the Save row entirely.
   If spend% = 0: hide the Spend row entirely.
   If both = 0: hide the entire Targets card from Dashboard.

Q: The Expense Breakdown chart tick mark formula in R&D says:
   tick position = (budgetLimit ÷ highestCategoryTotal) × barWidth
   This seems wrong — shouldn't it use the category's own total?
A: Yes, the R&D formula is incorrect. Correct formula:
   Bar fill width = (categoryTotal ÷ totalSpent) × barWidth
   Tick mark position = (budgetLimit ÷ totalSpent) × barWidth
   This places the tick at the same scale as the fill bar.
   If budgetLimit > totalSpent: tick is beyond bar end (don't show tick)

Q: In the Expense Breakdown chart, how many categories max?
A: Show all categories that have at least 1 expense entry.
   No hard limit. List scrolls if many categories.
   Card itself does not scroll — it expands to fit all rows.

Q: What is the bar height for expense breakdown rows?
A: 8px height, rounded ends, same as goal progress bars.

Q: Recent Activity shows 5 entries — is this 5 per type or
   5 total across all types?
A: 5 TOTAL across all 3 types combined, sorted by date DESC.
   Not 5 per type.

Q: Does Recent Activity respect the selected month filter?
A: Yes. Only shows entries from the selected month.
   If user navigates to March 2026, Recent Activity shows
   the 5 most recent entries from March 2026.

---

### SETTINGS

Q: When currency changes, do existing entry amounts change?
A: No. Amounts in DB are never converted.
   Only the currency SYMBOL changes everywhere in the UI.
   BDT 1,50,000 becomes $ 1,50,000 if user switches to USD.
   No exchange rate conversion. Ever.

Q: When month_start changes, does historical data re-sort?
A: Yes. All monthly groupings recalculate immediately.
   Data doesn't move — the date ranges used to filter it change.

Q: The Settings screen says "Back up your data" banner tapping
   "scrolls to backup section" — Settings is a ScrollController
   with a GlobalKey or anchor?
A: Use a ScrollController with a GlobalKey on the Data & Backup
   card. On banner tap: Scrollable.ensureVisible(context)
   targeting the backup card's key.

Q: Targets input — does the summary row update as user types
   or only after they leave the field?
A: Updates live as user types (onChanged).
   DB write happens onEditingComplete or onFocusLost.

Q: What keyboard type for the targets % input?
A: TextInputType.number
   Max 2 digits enforced with maxLength: 2

Q: Category reorder — is drag-and-drop available on default
   categories too?
A: Yes. Default categories can be reordered.
   They just cannot be deleted.
   sort_order is updated for all categories on reorder.

---

### BACKUP & RESTORE

Q: The R&D says "filter to .json files only" in file_picker.
   How to implement this?
A: FilePickerResult result = await FilePicker.platform.pickFiles(
     type: FileType.custom,
     allowedExtensions: ['json'],
   );

Q: After restore, does the app navigate anywhere?
A: Navigate to Dashboard and reload all providers:
   ref.invalidate(entriesProvider)
   ref.invalidate(categoriesProvider)
   ref.invalidate(summaryProvider)
   ref.invalidate(settingsProvider)

Q: The backup file includes settings — does restoring overwrite
   currency, targets, and theme too?
A: Yes. All settings from the backup JSON replace current settings.
   This is intentional — a full restore means everything.

Q: How do we handle Storage Permissions for Backup/Restore?
A:
* No Blanket Permissions: Do not request WRITE_EXTERNAL_STORAGE on Android 13+.
* Scoped Storage: Use the file_picker package. The user selecting a location via the system picker provides a temporary URI permission.
* Manifest: Include permissions with maxSdkVersion to ensure backward compatibility for older devices (API 26-32) without bothering modern users.

Q: What if the Downloads folder doesn't exist or isn't writable?
A: Do not attempt to write directly to a path string. Use FilePicker.platform.saveFile(). This invokes the system's native "Save As" dialog, bypassing the need for broad storage permissions on Android 13+.

---

### HAPTICS

Q: The R&D says haptic_feedback is "built into Flutter SDK."
   What is the exact API to use?
A: import 'package:flutter/services.dart';
   Soft pulse:    HapticFeedback.lightImpact()
   Medium pulse: HapticFeedback.mediumImpact()
   Heavy:         HapticFeedback.heavyImpact()
   
   Mapping:
   Save entry:       lightImpact()
   Delete entry:     mediumImpact()
   Swipe right edit: lightImpact()
   Budget 100% hit:  mediumImpact()
   Set budget/goal:  lightImpact()

Q: When haptic is OFF in settings, how do I disable all calls?
A: Create a HapticService wrapper in services/:
   class HapticService {
     static Future<void> light() async {
       if (settingsProvider.haptic == 'true')
         HapticFeedback.lightImpact();
     }
   }
   All haptic calls go through HapticService, never direct.

---

### RECURRING ENGINE

Q: Where exactly in main.dart does the recurring engine run?
A: After DB initialization, before runApp():
   await RecurringEngine.processOverdue(db);
   runApp(ProviderScope(child: App()));

Q: What if the recurring engine creates duplicate entries
   because it ran twice (e.g. app crashed mid-run)?
A: Add a check: before creating an auto-entry, query if an
   entry already exists with:
   recur_rule_id = ruleId AND date = scheduledDate
   If exists: skip creation, still advance next_date.

Q: If user has no internet and opens the app, does the
   recurring engine still run?
A: Yes. It is 100% local. No internet dependency ever.

---

### ANIMATIONS

Q: What Flutter animation to use for form slide down/up?
A: AnimationController + CurvedAnimation with:
   Expand: Curves.easeOut 300ms
   Collapse: Curves.easeIn 300ms
   Use SizeTransition wrapping the form content.

Q: What animation for new entry appearing in list?
A: AnimatedList with:
   insertItem triggering FadeTransition + SlideTransition
   from translateY +20px to 0, 200ms, Curves.easeOut

Q: What animation for number count-up on Dashboard load?
A: TweenAnimationBuilder<double>
   From: 0
   To: actual value
   Duration: 800ms
   Curve: Curves.easeOut
   Apply to Available to Spend and all 4 summary column values.

---

### EMPTY STATES

Q: What does the Save tab Goals section show when no goals
   are set AND no saving entries exist?
A: Goals section hidden entirely.
   History section shows empty state:
   "No savings this month. Tap above to add your first."

Q: What does Dashboard show when the app is brand new
   (no data at all)?
A: Balance Card: shows BDT 0 for all values
   My Targets Card: shows (30% save / 50% spend defaults from seed)
                    with 0% actual — bars empty
   Donut Chart: full grey circle + "No data this month"
   Financial Health: 0%, "Add earnings to track health"
   Expense Breakdown: "No expenses this month"
   Recent Activity: "No activity this month"
   Backup banner: shown (never backed up)

---

### MISSING FROM R&D — DECISIONS MADE HERE

The following were not in the R&D but are needed for build.
These answers are final:

Q: Should snackbars appear above or below the bottom nav bar?
A: Above the bottom nav bar.
   Use ScaffoldMessenger with bottom padding equal to
   bottom nav bar height.

Q: What is the bottom nav bar height?
A: 64px total height including safe area padding.

Q: Should the app icon be custom or default Flutter icon?
A: Default Flutter icon for M1–M6.
   Custom icon is M7 polish task.

Q: What happens if user rotates phone to landscape?
A: Locked to portrait. Rotation is disabled.
   See AndroidManifest answer above.

Q: Is there a splash screen?
A: No custom splash screen.
   Use Flutter's default white splash in M1–M6.
   Custom splash is M7 polish task.

Q: Should amounts in history list be right-aligned or left?
A: Right-aligned always. Use Expanded + Text(textAlign: TextAlign.end)

Q: What happens when keyboard opens on entry form — does the
   screen scroll to keep Save button visible?
A: Yes. Wrap screen in SingleChildScrollView with
   resizeToAvoidBottomInset: true on Scaffold.
   The form and Save button should remain accessible.

Q: The category management screen says reorder with long-press.
   What Flutter widget?
A: ReorderableListView.builder
   On reorder: update sort_order for all affected categories in DB.

Q: What if user has no entries at all and taps < month arrow
   going back many months?
A: Show empty states for all cards. No error. No restriction.
   User can navigate to any month freely.

Q: Is there a "today" button to jump back to current month?
A: No. Not in R&D. Not needed. Use < > only.

Q: What happens if totalEarned < totalSpent + totalSaved?
   (user overspent and over-saved)
A: availableToSpend is negative. Show as negative in red.
   No error. No warning beyond the red color.
   Donut chart: Spent% + Saved% may exceed 100%.
   Cap display at 100% total, scale segments proportionally.
   Unallocated segment disappears (shows 0%).

Q: Should the app ask for any permissions on first launch?
A: No. On modern Android (API 33+), there is no storage permission to ask for in the context of JSON files. Permission is granted implicitly via the File Picker. For users on API 26–32, request Permission.storage only when the user initiates a Backup/Restore.

---

## PART 3 — CRITICAL FORMULA CORRECTIONS

These are errors in the R&D that must be corrected in code:

### Error 1 — Expense Breakdown tick mark formula
R&D says:
  tick position = (budgetLimit ÷ highestCategoryTotal) × barWidth

Correct formula:
  Bar fill = (categoryTotal ÷ totalSpent) × barWidth
  Tick mark = (budgetLimit ÷ totalSpent) × barWidth
  If tick position > barWidth: do not render tick (budget not reached)

### Error 2 — Danger Zone confirmation dialog
R&D Section 5 (Danger Zone) says:
  "shows the ONE confirmation dialog in entire app"
But Section 8 (Backup Import) also has a confirmation dialog.
The locked decisions table says "these two only."

Clarification: There are EXACTLY TWO confirmation dialogs:
  1. Restore Backup dialog (Section 8)
  2. Clear All Data dialog (Section 5 Danger Zone)
  No other dialogs anywhere in the app.

### Error 3 — Settings backup banner behaviour
Section 5 says banner "scrolls to backup card (same screen)"
Section 8 says banner "navigates to Settings, scrolls to backup section"

Clarification: Banner is on Dashboard (not Settings).
  Tapping it: go_router.push('/settings') then scroll to backup card.
  Banner is NOT on the Settings screen itself.
  The Data & Backup section in Settings has its own amber
  warning banner that is separate — that one does NOT navigate,
  it just reminds the user who is already on Settings.

### Error 4 — number formatting for non-BDT currencies
R&D specifies Bengali grouping (1,50,000) for BDT.
It does not specify formatting for USD, EUR etc.

Answer: Use Bengali grouping (1,50,000) for ALL currencies.
  This is a personal app used by one person (BDT-primary).
  The currency setting only changes the symbol, not the grouping.

---

## PART 4 — MILESTONE 1 EXACT DELIVERABLE CHECKLIST

When M1 is complete, ALL of the following must work:

□ App installs on Android phone via APK
□ App launches without crash
□ "3MT" appears as app name on phone
□ **minSdkVersion 26 (Android 8.0+) & targetSdkVersion 35 confirmed in build.gradle**
□ Portrait only — no landscape (locked in Manifest)
□ Dark background #0A0A0F on all screens
□ Bottom nav shows 4 tabs: Dashboard, Earn, Spend, Save
□ Tapping each tab navigates to correct screen
□ Each screen shows correct header title
□ "Hello there..." subtitle on Dashboard header
□ < "April 2026" > shows current month on all tabs
□ Tapping < goes to previous month
□ Tapping > goes to next month
□ Month change on one tab reflects on all tabs
□ Gear icon visible top-right on all 4 tabs
□ Tapping gear opens Settings screen
□ Settings back arrow returns to previous tab
□ Instrument Serif font renders on screen (test with placeholder)
□ DM Sans font renders on screen
□ JetBrains Mono font renders on screen
□ SQLite DB file created on first launch
□ All 6 tables exist in DB after first launch
□ Default categories seeded (verify count: 6+9+7 = 22 rows)
□ Default settings seeded (verify 8 key-value rows)
□ App re-launches without re-seeding (data persists)
□ **Scoped Storage Protocol: Backup logic uses FilePicker (No blanket storage permission requested on API 33+)**
□ "Coming soon" placeholder on each tab body
□ No errors in flutter run output

---

*This document is the complete briefing for a new coding session.*
*Read the R&D document alongside this file.*
*Clear any further clarification you need before Start coding for Milestone 1 of the checklist above.*