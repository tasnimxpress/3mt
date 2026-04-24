# 3MT — M2 New Session Briefing
## Earn Tab — Full Implementation
*Stack: Flutter + Dart + sqflite + Riverpod + go_router + fl_chart*
*Targeting: Android 8.0+ | Scoped Storage | 2026 Compliance*

---

## PART 1 — PROJECT CONTEXT

App name: 3MT (My Money Management & Tracker)
Package:  com.threetmt.app
R&D document: 3MT-RD-Document.md (attach to session)
Prototype screens: Earnings.png is the visual reference for M2.

**The R&D is the single source of truth.**
Prototype screens are visual references only.
Where they conflict with R&D, R&D wins.

---

## PART 2 — M1 STATUS (COMPLETE — DO NOT REBUILD)

M1 is fully built and delivered as 3MT-M1.zip.
The following files exist and must NOT be regenerated.
Only extend or import them.

### Existing file tree (M1 output):
```
lib/
├── main.dart                          ✅ DB init, recurring engine, runApp
├── app.dart                           ✅ MaterialApp, ThemeData, router
├── core/
│   ├── constants/
│   │   ├── colors.dart                ✅ All AppColors tokens
│   │   ├── text_styles.dart           ✅ All AppTextStyles definitions
│   │   └── default_categories.dart    ✅ 22 seed category rows
│   ├── utils/
│   │   ├── currency_formatter.dart    ✅ Bengali grouping: 1,50,000
│   │   ├── date_helpers.dart          ✅ getMonthRange(), ISO parse/format
│   │   └── recurring_engine.dart      ✅ Auto-create overdue entries
│   └── router.dart                    ✅ StatefulShellRoute, 4 branches
├── db/
│   ├── database_helper.dart           ✅ sqflite open, onCreate, onUpgrade
│   ├── schema.dart                    ✅ All 6 CREATE TABLE SQL constants
│   ├── seed.dart                      ✅ insertDefaultCategories/Settings
│   └── queries/
│       ├── entry_queries.dart         ✅ insert, update, delete, getByMonth
│       ├── category_queries.dart      ✅ insert, delete, reorder, getByType
│       ├── budget_queries.dart        ✅ upsert, delete, getForCategory
│       ├── goal_queries.dart          ✅ upsert, delete, getForCategory
│       ├── settings_queries.dart      ✅ get(key), set(key, value), getAll
│       └── computed_queries.dart      ✅ SUM aggregations, getMonthTotals
├── models/
│   ├── entry.dart                     ✅ Entry + fromMap/toMap/copyWith
│   ├── category.dart                  ✅ Category + fromMap/toMap
│   ├── budget_limit.dart              ✅ BudgetLimit + fromMap
│   ├── saving_goal.dart               ✅ SavingGoal + fromMap
│   ├── recurring_rule.dart            ✅ RecurringRule + fromMap/toMap
│   └── month_summary.dart             ✅ All computed derived getters
├── providers/
│   ├── selected_month_provider.dart   ✅ StateProvider<DateTime>
│   ├── entries_provider.dart          ✅ FutureProvider.family by (month, type)
│   ├── categories_provider.dart       ✅ FutureProvider.family by type
│   ├── summary_provider.dart          ✅ FutureProvider.family by month
│   └── settings_provider.dart        ✅ StateNotifierProvider<SettingsNotifier>
├── screens/
│   ├── dashboard/dashboard_screen.dart  ✅ M1 placeholder (font test)
│   ├── earn/earn_screen.dart            ✅ M1 placeholder — REPLACE IN M2
│   ├── spend/spend_screen.dart          ✅ M1 placeholder
│   ├── save/save_screen.dart            ✅ M1 placeholder
│   └── settings/
│       ├── settings_screen.dart         ✅ M1 placeholder
│       └── category_management_screen.dart ✅ M1 placeholder
├── widgets/
│   └── shared/
│       ├── bottom_nav_bar.dart          ✅ 4-tab nav, pillar accent colors
│       └── screen_header.dart           ✅ TabScreenHeader + DashboardHeader
└── services/
    └── backup_service.dart              ✅ Stub — full impl in M6
```

### Key implementation facts from M1:
- `selectedMonthProvider` anchors to `DateTime(year, month, 1)`
- `entriesProvider` takes `(DateTime, String)` tuple — month + type
- `SettingsNotifier.monthStart` returns `int` (1, 15, or 25)
- `DateHelpers.getMonthRange()` returns named record `({DateTime start, DateTime end})`
- `CurrencyFormatter.format(symbol, amount, showSign: false)` — main formatter
- `DatabaseHelper.instance.database` — singleton getter
- All haptics must go through `HapticService` (to be created in M2)
- `ref.invalidate(entriesProvider)` + `ref.invalidate(summaryProvider)` after every DB write

---

## PART 3 — M2 DELIVERABLE: EARN TAB (FULLY WORKING)

### M2 Scope (from R&D milestone plan):
```
✅ entry_form.dart: collapse/expand animation (AnimationController)
✅ category_chips.dart: scroll, fade gradient, [+ New] inline input
✅ Full CRUD: insertEntry, updateEntry, deleteEntry, getByMonth
✅ entry_row.dart: swipe left delete + undo snackbar
✅ entry_row.dart: swipe right inline edit
✅ Month navigation filters history list
✅ Recurring toggle + frequency chips + rule saved to DB
✅ Haptic on save and delete (via HapticService)
✅ Empty state message
✅ HapticService wrapper (services/haptic_service.dart)
```

### New files to create in M2:
```
lib/
├── screens/
│   └── earn/
│       └── earn_screen.dart           REPLACE M1 placeholder
├── widgets/
│   └── shared/
│       ├── entry_form.dart            NEW — collapse/expand animated form
│       ├── entry_row.dart             NEW — swipeable row (delete + edit)
│       ├── category_chips.dart        NEW — horizontal scroll + fade + [+New]
│       └── section_title.dart         NEW — reusable section heading widget
└── services/
    └── haptic_service.dart            NEW — wraps HapticFeedback calls
```

Also need to create `recurring_rule` insert logic in:
```
lib/db/queries/recurring_rule_queries.dart   NEW
```

---

## PART 4 — DETAILED SPECS FOR EVERY M2 COMPONENT

### A. HapticService (services/haptic_service.dart)

```dart
// Reads haptic setting from settingsProvider before firing.
// ALL haptic calls in the app go through here — never direct.

class HapticService {
  static Future<void> light(WidgetRef ref) async { ... }
  static Future<void> medium(WidgetRef ref) async { ... }
  static Future<void> heavy(WidgetRef ref) async { ... }
}

// Mapping:
// Save entry:       light()
// Delete entry:     medium()
// Swipe right edit: light()
// Budget 100% hit:  medium()   (M3)
// Set budget/goal:  light()    (M3/M4)
```

---

### B. entry_form.dart (widgets/shared/entry_form.dart)

The form is shared across Earn, Spend, Save tabs.
It is parameterised by `entryType` ('earning' | 'expense' | 'saving').

#### COLLAPSED STATE (default on every screen load):
```
Full-width tappable row
Background: #13131A, border: #1E1E2E, borderRadius: 16px
Layout: [● accent_color +icon]  "Add Earning"  [chevron ↓]
Tapping: animates to expanded (300ms easeOut SizeTransition)
```

#### EXPANDED STATE:
```
Card background #13131A, border #1E1E2E, borderRadius 16px
Keyboard opens immediately on amount field on expand

Row 1 — Amount:
  Left:  "BDT" label  #7B7B9A  DM Sans 13px
  Right: amount input  JetBrains Mono 32px white
  Default: shows "0"
  On focus: clears to empty (TextEditingController, clear on focus)
  Keyboard: TextInputType.numberWithOptions(decimal: false)
  Validation: red border if 0 when Save tapped

Row 2 — Category chips (CategoryChips widget)

Row 3 — Date:
  📅 icon  date string  #7B7B9A
  Default: today
  Tap → showDatePicker() (native Android picker)
  Display: "Today, Apr 22" if today, else "Apr 15, 2026"
  DateHelpers.toFormDate(dt) handles this formatting

Row 4 — Note:
  Placeholder: "Add a note... (optional)"  #7B7B9A
  Single underline only (no box)
  Optional — not validated

Row 5 — Recurring:
  "Recurring?" label left  DM Sans white
  Toggle switch right, default OFF
  If ON: frequency chips appear below with SizeTransition 300ms:
    [Monthly]  [Weekly]
    Default selected: Monthly
    Same pill chip style as category chips (accent color when selected)

Row 6 — Save button:
  Full width pill shape
  Earn:  bg #00D68F, text black, label "Save Earning"
  Spend: bg #FF4D6D, text black, label "Save Expense"
  Save:  bg #F5A623, text black, label "Save Entry"
  Validation: amount must be > 0 AND category selected
  If amount = 0: red border on amount input, do nothing else
```

#### AFTER SAVE:
```
1. Insert entry to DB via EntryQueries.insert()
2. If recurring ON: insert rule to recurring_rules via RecurringRuleQueries.insert()
   next_date = entry date + 1 period
3. ref.invalidate(entriesProvider((month, type)))
   ref.invalidate(summaryProvider(month))
4. Form slides closed (300ms easeIn)
5. New entry appears at top of history list (AnimatedList)
6. Amount resets to 0
7. Category keeps last selection
8. Date resets to today
9. Note clears
10. Recurring resets to OFF
11. HapticService.light(ref)
```

#### COLLAPSE WITHOUT SAVING:
```
Tap collapsed trigger row while form open → closes, no save, no confirm
```

---

### C. CategoryChips (widgets/shared/category_chips.dart)

```
Horizontal ScrollView of pill chips
Right edge: 40px ShaderMask fade gradient (#0A0A0F → transparent)

Selected chip:   accent_color bg, black text, pill 8px radius
Unselected chip: #1E1E2E bg, #7B7B9A text, pill 8px radius

Default selected:
  - Last used category for this type (stored in memory during session only)
  - First ever use: first category in sort_order

[+ New] chip always at end:
  Style: #1E1E2E bg, accent_color text, + icon
  Tap → inline text input appears in chip row (no modal, no new screen)
  Placeholder: "Category name..."
  User types → taps keyboard Done
  → CategoryQueries.insert(type, name) → new chip created, selected
  → ref.invalidate(categoriesProvider(type))
  Max 20 chars enforced with maxLength

Categories loaded from: categoriesProvider(type) FutureProvider
```

---

### D. entry_row.dart (widgets/shared/entry_row.dart)

```
Use Dismissible widget for both swipe directions.

SWIPE LEFT (endToStart) — DELETE:
  secondaryBackground: #FF4D6D with white trash icon, right-aligned
  confirmDismiss: always returns false (handle manually)
  On swipe past 50%:
    → EntryQueries.delete(entry.id)
    → ref.invalidate(entriesProvider)
    → ref.invalidate(summaryProvider)
    → HapticService.medium(ref)
    → AnimatedList.removeItem() with slide-left 200ms
    → ScaffoldMessenger snackbar: "Deleted  [Undo]" 3s
    → Undo within 3s: re-insert at original position
    → After 3s: deletion committed (already done — just dismiss snackbar)

SWIPE RIGHT (startToEnd) — EDIT:
  background: #1E1E2E with white edit icon, left-aligned
  confirmDismiss: always returns false
  On swipe right:
    → Row expands inline to pre-filled form (AnimatedContainer)
    → All fields editable, same layout as add form
    → Save button labeled "Update"
    → HapticService.light(ref)
    → On Update: EntryQueries.update(), invalidate providers, collapse row
    → Cancel: swipe back left OR tap anywhere outside

ROW LAYOUT (non-swipe state):
  Left:   circle icon (40px) colored by type, arrow icon inside
          Earning: #00D68F filled circle, ↑ arrow
          Expense: #FF4D6D filled circle, ↓ arrow
          Saving:  hollow gold circle ○ (border only, no fill)
  Center: Column(
            category name  DM Sans bold white  13px
            date           DM Sans #7B7B9A 11px  "Apr 22, 2026"
          )
  Right:  Column(
            amount   JetBrains Mono 15px colored by type
                     Earning: +80,000  #00D68F
                     Expense:  −4,200  #FF4D6D
                     Saving:   +5,000  #F5A623
            note     DM Sans 11px #7B7B9A (if exists)
          )
  Rows separated by 1px #1E1E2E divider
```

---

### E. RecurringRuleQueries (db/queries/recurring_rule_queries.dart)

```dart
static Future<String> insert({
  required String type,
  required double amount,
  required String categoryId,
  required String period,      // 'monthly' | 'weekly'
  String? note,
  required String nextDate,    // ISO date string
}) async { ... }
```

`nextDate` calculation (done in entry_form.dart before calling insert):
```
If period = 'monthly': nextDate = entryDate + 1 month (same day)
If period = 'weekly':  nextDate = entryDate + 7 days
Use DateHelpers logic — handle month overflow (e.g. Jan 31 + 1 month = Feb 28)
```

---

### F. EarnScreen (screens/earn/earn_screen.dart)

```
Scaffold:
  backgroundColor: AppColors.background
  resizeToAvoidBottomInset: true
  body: SafeArea → Column:
    TabScreenHeader(
      title: 'Earnings',
      subtitle: '$monthLabel • $currencySymbol $formattedTotal total'
    )
    EntryForm(
      entryType: 'earning',
      accentColor: AppColors.earn,
      onSaved: () { ... }   // triggers list refresh
    )
    SizedBox(height: 16)
    Padding → Text('This Month', style: AppTextStyles.sectionTitle)
    Expanded → history list (AnimatedList or ListView)

History list:
  Watches: entriesProvider((selectedMonth, 'earning'))
  AsyncValue.when(
    data: (entries) =>
      entries.isEmpty
        ? EmptyState("No earnings this month. Tap above to add your first.")
        : AnimatedList of EntryRow widgets
    loading: () => SizedBox.shrink()
    error: (e, _) => Text(e.toString())
  )

Category name resolution:
  Each EntryRow needs the category name for display.
  Query via CategoryQueries.getById(entry.categoryId)
  If null: show "Deleted Category" in #7B7B9A italic

Total in subtitle:
  Watch summaryProvider(selectedMonth)
  totalEarned from MonthSummary
  Format: CurrencyFormatter.format(currencySymbol, totalEarned)
```

---

## PART 5 — ANIMATION SPECS

### Form expand/collapse:
```dart
AnimationController controller = AnimationController(
  duration: const Duration(milliseconds: 300),
  vsync: this,
);
CurvedAnimation expand = CurvedAnimation(parent: controller, curve: Curves.easeOut);
CurvedAnimation collapse = CurvedAnimation(parent: controller, curve: Curves.easeIn);

SizeTransition(sizeFactor: animation, child: formContent)
```

### New entry appearing in list:
```dart
// Use AnimatedList. On insert:
_listKey.currentState?.insertItem(
  0,  // insert at top
  duration: const Duration(milliseconds: 200),
);
// Item builder uses FadeTransition + SlideTransition:
//   from Offset(0, 0.1) to Offset.zero  (translateY ~20px)
//   FadeTransition: 0.0 → 1.0
//   Curve: Curves.easeOut  200ms
```

### Entry delete collapse:
```dart
_listKey.currentState?.removeItem(
  index,
  (context, animation) => SizeTransition(
    sizeFactor: animation,
    child: FadeTransition(opacity: animation, child: removedRow),
  ),
  duration: const Duration(milliseconds: 200),
);
```

### Frequency chips expand/collapse (recurring toggle):
```dart
// Same SizeTransition pattern as form, 300ms
// Appears below Recurring toggle row
```

---

## PART 6 — SNACKBAR SPEC

```dart
// "Deleted [Undo]" snackbar — appears ABOVE bottom nav bar.
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Deleted'),
    action: SnackBarAction(label: 'Undo', onPressed: _undoDelete),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: 64 + MediaQuery.of(context).padding.bottom + 8,
      left: 16,
      right: 16,
    ),
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.border),
    ),
  ),
);

// Undo logic:
// Keep deleted entry in memory (local variable).
// On Undo: re-insert to DB, re-insert to AnimatedList at original index.
// Actual DB delete happens BEFORE snackbar (not after).
// Undo re-inserts — this is simpler and safe.
```

---

## PART 7 — CATEGORY NAME RESOLUTION PATTERN

```dart
// In EntryRow or EarnScreen — resolve category name for display.
// CategoryQueries.getById returns Category? (nullable).
// If category was deleted: show "Deleted Category" in italic grey.

Future<String> resolveCategoryName(String categoryId) async {
  final cat = await CategoryQueries.getById(categoryId);
  return cat?.name ?? 'Deleted Category';
}

// Use FutureBuilder or async provider to resolve per-row.
// Do NOT block the list build on this — show loading state briefly.
```

---

## PART 8 — DESIGN TOKENS REMINDER (most relevant for M2)

```
Background:      #0A0A0F
Surface (cards): #13131A
Border:          #1E1E2E
Earn accent:     #00D68F
Spend accent:    #FF4D6D
Save accent:     #F5A623
Text primary:    #F0F0F5
Text secondary:  #7B7B9A
Delete bg:       #FF4D6D  (swipe left reveal)
Edit bg:         #1E1E2E  (swipe right reveal)

Card:            borderRadius 16px, border 1px #1E1E2E, no shadow
Chips:           borderRadius 8px pill, no shadow
Save button:     full pill shape
```

---

## PART 9 — CRITICAL RULES (carry-over from M1 briefing)

1. Bengali grouping for ALL currencies: 1,50,000 not 150,000
   Use CurrencyFormatter.format() — never format manually.

2. Deleted category display: "Deleted Category" in #7B7B9A italic.
   Never crash on missing category_id.

3. Amounts are always stored POSITIVE in DB.
   `type` field determines sign in UI display.
   Earning: +  (green)
   Expense: −  (red)
   Saving:  +  (gold)

4. No FK enforcement in sqflite. Do NOT call PRAGMA foreign_keys = ON.

5. ref.invalidate() both entriesProvider AND summaryProvider after every write.

6. ALL haptics via HapticService — never call HapticFeedback directly.

7. Form default state: COLLAPSED on every screen load (not just first).

8. Date format in DB: 'YYYY-MM-DD'. Use DateHelpers.toDateString().

9. No confirmation dialog for entry delete — only Undo snackbar.
   (Only 2 confirmation dialogs in entire app: Restore Backup + Clear All Data)

10. No decimal input — BDT is whole numbers only.
    TextInputType.numberWithOptions(decimal: false)

---

## PART 10 — M2 EXACT DELIVERABLE CHECKLIST

When M2 is complete, ALL of the following must work:

□ Earn tab shows correct header: "Earnings" + month + total
□ Total in subtitle updates when entries are added/deleted
□ Entry form is COLLAPSED by default on every screen load
□ Tapping collapsed row expands form with 300ms easeOut animation
□ Keyboard opens on amount field immediately on expand
□ Amount field shows "0", clears on tap, accepts whole numbers only
□ Category chips load from DB (6 default earning categories)
□ Category chips scroll horizontally with right-edge fade gradient
□ First chip (Salary) selected by default on first use
□ Tapping a chip selects it (accent color)
□ [+ New] chip creates a new category inline (no modal)
□ New category appears at end of chip list, selected immediately
□ Date field shows "Today, Apr 22" format
□ Tapping date opens native Android date picker
□ Note field is optional, single underline style
□ Recurring toggle OFF by default
□ Toggling Recurring ON shows Monthly/Weekly chips (300ms animate)
□ Toggling Recurring OFF hides frequency chips (300ms animate)
□ Tapping Save with amount = 0: red border on amount, no save
□ Tapping Save with valid amount: entry saved to DB
□ After save: form collapses, new entry appears at top of list
□ New entry appears with fade-in + slide animation (200ms)
□ Amount resets to 0, date resets to today, note clears after save
□ Category selection persists after save (last used)
□ Recurring entry: recurring_rule row inserted to DB with correct next_date
□ Haptic light pulse fires on successful save
□ History list shows all entries for selected month
□ Entries sorted by date DESC (most recent first)
□ Entry row shows: circle icon, category name, date, amount, note
□ Category name shows "Deleted Category" in grey italic if category deleted
□ Amount right-aligned in JetBrains Mono, green color
□ Swipe left on entry reveals red delete background
□ Full swipe left: entry deleted from DB and list, Undo snackbar appears
□ Undo snackbar appears ABOVE bottom nav bar
□ Tapping Undo: entry re-appears at original list position
□ Haptic medium pulse fires on delete
□ Swipe right on entry reveals edit background, expands inline form
□ Edit form pre-fills all fields from entry data
□ Tapping Update: entry updated in DB and row updates inline
□ Haptic light pulse fires on swipe-to-edit
□ Month navigation arrows filter history list correctly
□ Month change updates subtitle total
□ Empty state shows when no entries for selected month
□ No errors in flutter run output

---

## PART 11 — WHAT M2 DOES NOT BUILD

These are NOT in M2 scope. Do not build them:
- Dashboard cards (M5)
- Spend tab budget progress bar (M3)
- Spend tab long-press budget input (M3)
- Save tab goals (M4)
- Save tab nudge card (M4)
- Settings screens (M6)
- Backup/Restore (M6)
- Any light theme work (M7)

---

*Attach this file + 3MT-RD-Document.md to the new session.*
*Do NOT attach the old briefing (3MT-NewSession-Briefing.md) — it is superseded.*
*Do NOT regenerate any M1 files. Build only what is listed in Part 3.*
*Read the R&D Section 5 (Earn tab spec) and Section 6 (interaction patterns) before coding.*
