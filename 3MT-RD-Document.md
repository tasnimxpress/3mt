# Fulo — Complete R&D Document
### Version 3.0 — Build-Ready
*Updated after UI prototype review and stack finalisation*

---

## 1. App Identity

| | |
|---|---|
| **Name** | Fulo (Bengali: ফুলো — to flourish) |
| **Tagline** | Your money. Your clarity. |
| **Platform** | Android (APK, sideloaded) |
| **User** | Single user, personal use, offline-first |
| **Language** | English |
| **Default Currency** | BDT (changeable in Settings) |
| **Theme** | Dark (light mode toggle in Settings) |

---

## 2. Core Philosophy

### Three Pillars — Equal, Separate, Never Mixed

| EARNINGS | SAVINGS | EXPENSES |
|---|---|---|
| Money coming in | Money kept / growing | Money going out |
| Positive, green | Positive, gold | Negative, red |
| Salary, Freelance, Business | DPS, Stocks, FD | Rent, Food, Transport |

**Net Balance        = Earnings − Expenses**
Available to Spend = Earnings − Expenses − Savings
Savings Committed  = Total saved this month (locked, not liquid)

Primary display number: Available to Spend
Secondary display number: Net Balance

**Financial Health Score = (Total Saved ÷ Total Earned) × 100**

---

## 3. Design System (Confirmed from Prototype)

### Colors
```
Background        #0A0A0F
Surface (cards)   #13131A
Border            #1E1E2E

Earn (green)      #00D68F
Spend (red)       #FF4D6D
Save (gold)       #F5A623

Text primary      #F0F0F5
Text secondary    #7B7B9A
```

### Typography
```
Display / big numbers   Instrument Serif
UI / labels / buttons   DM Sans
All money amounts       JetBrains Mono
```

### Spacing & Shape
```
Card border radius      16px
Bottom sheet radius     24px
Card border             1px solid #1E1E2E (no shadows)
Button border radius    full pill for primary action buttons
```

---

## 4. Navigation Structure

### Bottom Navigation Bar (always visible on all 4 main screens)
```
[Dashboard]  [Earn]  [Spend]  [Save]
```
- Active tab: icon + label colored by pillar accent
- Inactive tabs: #7B7B9A
- Bar background: #13131A, top border: #1E1E2E

### Settings Access
- Gear icon ⚙ top-right corner on ALL four tab screens
- Settings opens as a new full screen (back arrow to return)
- No bottom nav bar on Settings screen

---

## 5. Screen Specifications

---

### SCREEN 1 — Dashboard

**Reference:** Dashboard.png ✅ approved

**Layout (scrollable, top to bottom):**

```
Header row
  Left:  < "April 2026" > month arrows
  Left below: "Good morning" subtitle #7B7B9A
  Right: ⚙ gear icon

Net Balance Card (#13131A, border #1E1E2E, rounded 16px)
  Large center: "BDT 1,19,500" Instrument Serif 42px white
  Label below: "Available to Spend" #7B7B9A
  Smaller below that: "BDT 1,24,500 Net Balance" #7B7B9A small
  Thin divider
  4 columns equal width:
    Earned    | +1,50,000  green   JetBrains Mono
    Spent     |   -20,500  red     JetBrains Mono
    Saved     |   -10,000  gold    JetBrains Mono
    Available |  1,19,500  white   JetBrains Mono 

Note: Saved shows minus sign because it reduces liquidity.
Gold color and "Saved" label keeps it feeling positive,
not a loss. Available = Earnings − Expenses − Savings.   

My Targets Card (#13131A, border #1E1E2E, rounded 16px)
  Header: "My Targets" left white | "April 2026" right #7B7B9A
  ─────────────────────────────────────────────────────
  Row — Save:
    ● gold dot | "Save" white | "Target 30%" #7B7B9A
    Far right: "Actual 22%" #F5A623 bold
    Progress bar full width, 8px, rounded:
      filled 22% in #F5A623
      unfilled #1E1E2E
      white vertical tick mark at the 30% position
    Below bar: "⚠ 8% short — save BDT 12,000 more this month"
               in #F5A623 small
  Thin divider
  Row — Spend:
    ● red dot | "Spend" white | "Target 50%" #7B7B9A
    Far right: "Actual 48%" #00D68F bold
    Progress bar full width, 8px, rounded:
      filled 48% in #00D68F
      unfilled #1E1E2E
      white vertical tick mark at the 50% position
    Below bar: "✅ On track — BDT 3,000 under limit"
               in #00D68F small

Donut Chart Card (#13131A, border #1E1E2E, rounded 16px)
  Left: donut chart, 3 segments green/red/gold
  Right: legend — colored dot + label + percentage each row

Financial Health Card (#13131A, border #1E1E2E, rounded 16px)
  "Financial Health" left white | "82%" right #00D68F bold
  Progress bar full width, 6px, green fill
  Below: "Savings rate this month" #7B7B9A small

Recent Activity (no card wrapper, plain background)
  Section title: "Recent Activity" white DM Sans medium
  5 most recent entries across all 3 types, sorted by date:
    Left:  colored circle icon
           ↑ green = earning, ↓ red = expense, ● gold = saving
    Center top: category name bold white
    Center below: date + time #7B7B9A small
    Right: amount JetBrains Mono colored by type
  Rows separated by #1E1E2E 1px line
```

**Prototype issue — behaviour in real build:**
> Donut chart in prototype shows proportions of the combined
> total (earned + spent + saved added together as 100%).
> In real build the formula must be:
>   Spent%  = Total Spent  ÷ Total Earned × 100
>   Saved%  = Total Saved  ÷ Total Earned × 100
>   Rest%   = 100 − Spent% − Saved%  (unallocated, shown grey)
> This correctly represents where earned money went.

---

### SCREEN 2 — Earn Tab

**Reference:** Earnings.png ✅ approved

**Layout:**

```
Header
  "Earnings" DM Sans bold white left
  "April 2026 • BDT 1,50,000 total" #7B7B9A small
  < > month arrows right
  ⚙ gear icon top-right

Entry Form Card (#13131A, border #1E1E2E, rounded 16px)
  Amount row:
    "BDT" #7B7B9A left | amount input right JetBrains Mono 32px
  Category chips horizontal scroll:
    [Salary] [Freelance] [Business] [Bonus] [Gift] [+ New]
    Selected chip: #00D68F background, black text, pill
    Unselected chip: #1E1E2E background, #7B7B9A text, pill
  Date row: 📅 icon | "Today, Apr 22" #7B7B9A
  Note row: "Add a note... (optional)" underline, no border
  Recurring row: "Recurring?" label left | toggle switch right
  Button: "Save Earning" full width pill, #00D68F bg, black text

This Month  (section title, DM Sans medium white)
  History list:
    Left:  green filled circle with ↑ arrow
    Center top: category name bold white
    Center bottom: date #7B7B9A small
    Right top: "+80,000" JetBrains Mono #00D68F
    Right bottom: note text if any, #7B7B9A small
  Rows separated by #1E1E2E 1px line
```

**Prototype issues — behaviour in real build:**

> **Issue A — Form collapse/expand:**
> Prototype shows form always open. In real build:
>
> Collapsed state (default):
>   [● green +]  "Add Earning"  [chevron ↓]
>   Single full-width row, tappable
>
> Expanded state (after tap, 300ms ease-out slide down):
>   Full form visible, keyboard opens immediately on amount field
>
> After tapping "Save Earning":
>   Form animates closed (300ms ease-in)
>   New entry slides into top of history list (fade + slide up)
>   Amount resets to 0, category keeps last selection
>
> Tapping the collapsed row again while form is open → closes form

> **Issue B — Category chip scroll indicator:**
> Prototype chips are cut off with no scroll hint. In real build:
>   Right edge of chip row: 40px fade gradient #0A0A0F→transparent
>   indicating more chips exist beyond visible area
>
> Tapping [+ New]:
>   A text input appears inline within the chip row
>   User types category name → taps enter/done on keyboard
>   New chip is created, saved to DB, selected immediately
>   No modal. No new screen.

---

### SCREEN 3 — Spend Tab

**Reference:** Expenses.png ✅ approved

**Layout:** Identical structure to Earn tab with these differences:
- Accent color: #FF4D6D (red) throughout
- Default categories: Rent, Food, Transport, Utilities, Health,
  Education, Entertainment, Shopping, Other
- Save button label: "Save Expense"
- History amounts prefixed "-", colored red

**Budget warning on chips (confirmed in prototype):**
```
Under the selected chip only:
  4px tall progress bar, full width of chip
  0–79% of budget used   → #00D68F green  (healthy)
  80–99% of budget used  → #F5A623 amber  (approaching limit)
  100%+ of budget used   → #FF4D6D red    (at or over limit)

Below selected chip:
  "Food: 6,500 / 10,000" #F5A623 small text
```

**Prototype issues — behaviour in real build:**

> **Issue A — Form collapse/expand:** Identical to Earn tab.
>
> **Issue B — Category chip scroll indicator:** Identical to Earn tab.
>
> **Issue C — Budget limit setup missing from prototype:**
> Prototype shows the budget warning bar but there is no way
> to set the limit amount. In real build:
>   Long-press any expense category chip →
>   Inline input appears below the chip row (no modal):
>     "Monthly limit for Food:  [________] BDT  [Set]"
>   User enters amount, taps Set → saved to DB immediately
>   Chip now shows budget bar on selection
>   Long-press again to edit or clear the limit

---

### SCREEN 4 — Save Tab

**Reference:** Savings.png ✅ approved

**Layout:**

```
Header
  "Savings" DM Sans bold white left
  "April 2026 • BDT 10,000 saved" #7B7B9A small
  < > month arrows right
  ⚙ gear icon top-right

Entry Form Card (gold accent, same structure as Earn/Spend)
  Categories: [DPS] [Stocks] [FD] [Emergency] [Mutual Fund]
              [Crypto] [+ New]
  Selected chip: #F5A623 bg, black text
  Button: "Save Entry" full width pill, #F5A623 bg, black text

Goals Section (between form and history)
  Title: "Goals" DM Sans medium white

  Goal cards, each (#13131A, border #1E1E2E, rounded 16px, p16):
    Top row:
      Category name bold white left
      Percentage right, colored:
        0–49%:   #F5A623 gold
        50–99%:  #00D68F green
        100%:    #00D68F + "✅ Complete" label
    Progress bar 8px rounded:
      Fill color matches percentage color above
      Unfilled: #1E1E2E
    Bottom: "BDT X saved of BDT Y goal" #7B7B9A small

  Nudge card (conditional — only shown when savings target set
  in Settings AND current actual% is below target%):
    Background: #F5A62315 (amber 8% opacity)
    Left border: 3px solid #F5A623
    Text: "To hit your 30% target, save BDT 12,000 more this month."
    ✕ dismiss button — hides for the day, reappears next day

History Section
  Title: "History" DM Sans medium white
  Entries (hollow gold circle icon ○ — approved, keeping this UI):
    Left:  hollow gold circle ○
    Center top: category name bold white
    Center bottom: date #7B7B9A small
    Right top: amount +gold JetBrains Mono
    Right bottom: note #7B7B9A small
  Rows separated by #1E1E2E line
```

**Prototype issues — behaviour in real build:**

> **Issue A — Form collapse/expand:** Identical to Earn tab.
>
> **Issue B — Category chip scroll indicator:** Identical to Earn tab.
>
> **Issue C — Saving goal target setup missing from prototype:**
> In real build:
>   Long-press any saving category chip →
>   Inline input appears below chip row (no modal):
>     "Savings goal for DPS:  [________] BDT  [Set]"
>   User enters target amount, taps Set → saved to DB
>   Goal card now appears in Goals section for that category
>   Long-press again to edit or clear the goal

---

### SCREEN 5 — Settings

**Reference:** Settings.png ✅ approved

**Layout (single scrollable screen, no sub-pages except categories):**

```
Header: ← back arrow | "Settings" center DM Sans bold white

─── PREFERENCES ────────────────────────────────── (section label)
Card (#13131A, border #1E1E2E, rounded 16px):
  Currency          BDT ৳           [chevron]
  ──────────────────────────────────────────
  Theme             Dark            [toggle ON]
  ──────────────────────────────────────────
  Month starts on   1st             [chevron]
  ──────────────────────────────────────────
  Haptic feedback                   [toggle ON]

─── MY TARGETS ──────────────────────────────────
Card (#13131A, border #1E1E2E, rounded 16px):
  ● "Save at least"           [30] %
    "of your monthly earnings" #7B7B9A small
  ──────────────────────────────────────────
  ● "Spend no more than"      [50] %
    "of your monthly earnings" #7B7B9A small
  ──────────────────────────────────────────
  Summary row (#0A0A0F bg, rounded 12px, inside card):
    30% SAVINGS (gold) | 50% SPENDING (red) | 20% FREE (green)
    All in JetBrains Mono bold, labels below in #7B7B9A small caps

Validation banner (only shown if save% + spend% > 100%):
  Background #F5A62315, left border 3px #F5A623
  "Targets exceed 100% of earnings. Please adjust." #F5A623 small

─── CATEGORIES ──────────────────────────────────
Card (#13131A, border #1E1E2E, rounded 16px):
  Earning Categories    6 categories    [chevron]
  ──────────────────────────────────────────────
  Expense Categories    8 categories    [chevron]
  ──────────────────────────────────────────────
  Saving Categories     7 categories    [chevron]

─── DATA & BACKUP ───────────────────────────────
Amber banner (only shown if no backup in 7+ days):
  Background #F5A62315, left border 3px #F5A623
  "Back up your data — 7 days since last backup"

Card (#13131A, border #1E1E2E, rounded 16px):
  Backup Now               [Export JSON]  (gold pill button)
  ──────────────────────────────────────────────
  Restore Backup           [Import]       (dark pill button)
  ──────────────────────────────────────────────
  Last backup    Apr 20, 2026 at 10:32 AM  #7B7B9A

─── DANGER ZONE ─────────────────────────────────
  Clear All Data (text in #FF4D6D)    [Reset]  (outline red button)
  "This cannot be undone. Export a backup first." #7B7B9A tiny
```

**Category management sub-screen (tapping any category chevron):**
```
Opens new screen:
  Header: ← back | "Earning Categories" center

  List of all categories, each row:
    Icon (emoji) | Category name bold white | ✕ delete right
    Default categories: ✕ is hidden (cannot delete defaults)

  Bottom row (always visible):
    [+ Add Category]
    Tapping: inline text input appears at bottom of list
    User types name → taps done → new category added instantly
    No modal. No confirmation.

  Reorder: long-press any row → drag handle appears → drag to reorder
```

---

## 6. Interaction Patterns (Real Build Behaviour)

### Form Collapse / Expand (all 3 entry tabs)
```
Collapsed (default):
  ┌─────────────────────────────────────────┐
  │  ●  Add Earning                      ↓  │
  └─────────────────────────────────────────┘

Tap → expands (300ms ease-out, slides down):
  Full form revealed, keyboard opens on amount field immediately

After "Save" tap:
  Validated: amount > 0 AND category selected
  Form slides closed (300ms ease-in)
  New entry appears at top of history list:
    fade-in + translateY animation (200ms)
  Amount resets to 0
  Category keeps last selection (faster repeat entry)
  Haptic: single soft tap

Tap collapsed row while form is open → form closes, no save
```

### Entry Delete (swipe left)
```
Swipe entry left:
  Red delete zone slides in from right edge
  Full swipe completes delete:
    Entry collapses with slide-left animation (200ms)
    Snackbar at bottom: "Deleted  [Undo]"  3 seconds
    Haptic: single medium tap
  Undo tap within 3s:
    Entry reappears at original position with fade-in
    Snackbar dismissed
  No confirmation dialog at any point
```

### Entry Edit (swipe right)
```
Swipe entry right:
  Entry row expands inline into edit form
  All fields pre-filled with existing data
  "Update" button replaces "Save" button
  Haptic: single soft tap on expand
  Cancel: swipe back left OR tap anywhere outside the row
```

### Month Navigation
```
Tap < or > arrows next to month title:
  All data on current screen filters to selected month
  All computed values recalculate for that month
  Dashboard and all tab screens share the same selected month
  Smooth crossfade on data change (150ms)
```

### Recurring Entries
```
Toggle "Recurring?" ON in entry form:
  Frequency chips appear inline below toggle:
    [Monthly]  [Weekly]   (no dropdown, just two chips)

On save:
  Entry saved for current date
  Recurring rule stored in recurring_rules table

Auto-creation (runs silently on every app launch):
  Check recurring_rules for any next_date ≤ today
  For each due rule: auto-create entry, advance next_date
  User sees auto-created entries in history list
```

---

## 7. Data Architecture

### Storage: sqflite (SQLite on Android file system)
Real SQLite file on phone internal storage. Not browser
memory. Survives app restarts, phone restarts, everything
except a full factory reset — which is why backup exists.

### Database Schema

```sql
CREATE TABLE entries (
  id            TEXT PRIMARY KEY,
  type          TEXT NOT NULL,     -- 'earning' | 'expense' | 'saving'
  amount        REAL NOT NULL,
  category_id   TEXT NOT NULL,
  date          TEXT NOT NULL,     -- ISO 8601: 2026-04-22
  note          TEXT,
  is_recurring  INTEGER DEFAULT 0,
  recur_period  TEXT,              -- 'monthly' | 'weekly' | null
  recur_rule_id TEXT,
  created_at    TEXT NOT NULL
);

CREATE TABLE categories (
  id         TEXT PRIMARY KEY,
  type       TEXT NOT NULL,        -- 'earning' | 'expense' | 'saving'
  name       TEXT NOT NULL,
  icon       TEXT,                 -- emoji
  color      TEXT,
  sort_order INTEGER DEFAULT 0,
  is_default INTEGER DEFAULT 0     -- 1 = cannot be deleted
);

CREATE TABLE budget_limits (
  id          TEXT PRIMARY KEY,
  category_id TEXT NOT NULL,
  amount      REAL NOT NULL,
  created_at  TEXT NOT NULL
);

CREATE TABLE saving_goals (
  id          TEXT PRIMARY KEY,
  category_id TEXT NOT NULL,
  target      REAL NOT NULL,
  created_at  TEXT NOT NULL
);

CREATE TABLE recurring_rules (
  id          TEXT PRIMARY KEY,
  type        TEXT NOT NULL,
  amount      REAL NOT NULL,
  category_id TEXT NOT NULL,
  period      TEXT NOT NULL,       -- 'monthly' | 'weekly'
  note        TEXT,
  next_date   TEXT NOT NULL,
  created_at  TEXT NOT NULL
);

CREATE TABLE settings (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
```

### Default Settings (seeded on first launch)
```
currency         = 'BDT'
theme            = 'dark'
month_start      = '1'
haptic           = 'true'
target_save_pct  = '30'
target_spend_pct = '50'
last_backup      = ''
```

### Default Categories (seeded on first launch, is_default = 1)

**Earnings:** Salary 💼, Freelance 💻, Business 🏪, Bonus 🎯, Gift 🎁, Other 📥

**Expenses:** Rent 🏠, Food 🍽️, Transport 🚗, Utilities 💡, Health 🏥,
Education 📚, Entertainment 🎬, Shopping 🛍️, Other 📤

**Savings:** DPS 🏦, Stocks 📈, FD 🔒, Emergency 🛡️,
Mutual Fund 📊, Crypto ₿, Cash Reserve 💵

### Computed Values (always calculated live, never stored)
```dart
totalEarned    = SUM(entries WHERE type='earning' AND month=M)
totalSpent     = SUM(entries WHERE type='expense' AND month=M)
totalSaved     = SUM(entries WHERE type='saving'  AND month=M)
availableToSpend = totalEarned - totalSpent - totalSaved
netBalance     = totalEarned - totalSpent
healthScore    = (totalSaved / totalEarned) * 100
actualSavePct  = (totalSaved / totalEarned) * 100
actualSpendPct = (totalSpent / totalEarned) * 100
freePct        = 100 - actualSavePct - actualSpendPct
targetSaveAmt  = totalEarned * (target_save_pct / 100)
saveRemaining  = targetSaveAmt - totalSaved
chipBudgetPct  = categoryMonthTotal / budgetLimit * 100
goalProgressPct= totalSavedForCategory / goalTarget * 100
```

---

## 8. Backup & Restore

### Export — "Backup Now"
```
1. Read all rows from all tables
2. Serialize to JSON:
   { version, exported_at, entries, categories,
     budget_limits, saving_goals, recurring_rules, settings }
3. Write to phone Downloads folder via path_provider:
   fulo-backup-2026-04-22.json
4. Update last_backup in settings
5. Snackbar: "Backup saved to Downloads ✓"
```

### Import — "Restore Backup"
```
1. file_picker opens phone file browser
2. User selects fulo-backup-XXXX.json
3. App validates JSON structure and version field
4. Show the ONE confirmation dialog in the entire app:
   "This will replace all current data with the backup."
   [Cancel]  [Restore]
5. On Restore: drop all tables → recreate → insert from JSON
6. Snackbar: "Data restored successfully ✓"
7. On invalid file: "Invalid backup file. Please try another."
```

### Backup Reminder
```
On every app launch:
  If last_backup is empty OR > 7 days ago:
    Show amber banner on Dashboard (not a popup)
    Tap banner → navigates to Settings Data & Backup section
```

---

## 9. Tech Stack

| Layer | Choice | Reason |
|---|---|---|
| Framework | **Flutter** | Near-native performance, mobile-first |
| Language | **Dart** | Typed, fast, small ecosystem, fewer vulnerabilities |
| Package manager | **pub (pub.dev)** | Google-managed, strict versioning, safe |
| Database | **sqflite** | SQLite on device file system, mature, stable |
| State management | **Riverpod** | Type-safe, Flutter-idiomatic |
| Charts | **fl_chart** | Best Flutter chart library, donut + bar |
| File system | **path_provider** | Access Downloads and app document directories |
| File picker | **file_picker** | Pick backup JSON from phone storage |
| Haptics | **haptic_feedback** | Built into Flutter SDK |
| Navigation | **go_router** | Declarative, clean, well maintained |
| Build | **flutter build apk** | Single command, no extra services |
| Code hosting | **GitHub** | Free, version controlled |

**No backend. No server. No npm. No subscription. No cost. Ever.**

### pubspec.yaml Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.3
  path_provider: ^2.1.4
  path: ^1.9.0
  flutter_riverpod: ^2.5.1
  riverpod: ^2.5.1
  go_router: ^14.2.0
  fl_chart: ^0.68.0
  file_picker: ^8.1.2
  uuid: ^4.4.0
  intl: ^0.19.0
```

9 packages total. Each has one clear purpose. No bloat.

---

## 10. Project Folder Structure

```
fulo/
├── lib/
│   ├── main.dart                        # Entry point, DB init
│   ├── app.dart                         # MaterialApp, theme, router
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart              # All design system tokens
│   │   │   ├── text_styles.dart         # 3 font definitions
│   │   │   └── default_categories.dart  # Seed data for first launch
│   │   ├── utils/
│   │   │   ├── currency_formatter.dart  # "1,50,000" BDT format
│   │   │   ├── date_helpers.dart        # Month ranges, ISO dates
│   │   │   └── recurring_engine.dart    # Auto-create due entries
│   │   └── router.dart                  # go_router definitions
│   │
│   ├── db/
│   │   ├── database_helper.dart         # sqflite init, migrations
│   │   ├── schema.dart                  # All CREATE TABLE SQL
│   │   ├── seed.dart                    # First-launch seeding
│   │   └── queries/
│   │       ├── entry_queries.dart
│   │       ├── category_queries.dart
│   │       ├── budget_queries.dart
│   │       ├── goal_queries.dart
│   │       ├── settings_queries.dart
│   │       └── computed_queries.dart    # Aggregated calculations
│   │
│   ├── models/
│   │   ├── entry.dart
│   │   ├── category.dart
│   │   ├── budget_limit.dart
│   │   ├── saving_goal.dart
│   │   ├── recurring_rule.dart
│   │   └── month_summary.dart           # Computed totals data class
│   │
│   ├── providers/                       # Riverpod providers
│   │   ├── selected_month_provider.dart
│   │   ├── entries_provider.dart
│   │   ├── categories_provider.dart
│   │   ├── summary_provider.dart
│   │   └── settings_provider.dart
│   │
│   ├── screens/
│   │   ├── dashboard/
│   │   │   └── dashboard_screen.dart
│   │   ├── earn/
│   │   │   └── earn_screen.dart
│   │   ├── spend/
│   │   │   └── spend_screen.dart
│   │   ├── save/
│   │   │   └── save_screen.dart
│   │   └── settings/
│   │       ├── settings_screen.dart
│   │       └── category_management_screen.dart
│   │
│   ├── widgets/
│   │   ├── shared/
│   │   │   ├── bottom_nav_bar.dart
│   │   │   ├── screen_header.dart       # Title + month nav + gear
│   │   │   ├── entry_form.dart          # Collapse/expand form
│   │   │   ├── entry_row.dart           # Swipeable history row
│   │   │   ├── category_chips.dart      # Horizontal chip row
│   │   │   └── section_title.dart
│   │   ├── dashboard/
│   │   │   ├── net_balance_card.dart
│   │   │   ├── targets_card.dart
│   │   │   ├── donut_chart_card.dart
│   │   │   ├── health_score_card.dart
│   │   │   └── recent_activity_list.dart
│   │   └── save/
│   │       └── goal_card.dart
│   │
│   └── services/
│       └── backup_service.dart          # Export/import JSON
│
├── assets/
│   └── fonts/
│       ├── InstrumentSerif-Regular.ttf
│       ├── DMSans-Regular.ttf
│       ├── DMSans-Medium.ttf
│       ├── DMSans-Bold.ttf
│       └── JetBrainsMono-Regular.ttf
│
└── pubspec.yaml
```

---

## 11. Milestone Plan

### M1 — Project Foundation
- Flutter project created, pubspec packages added
- Custom fonts loaded (Instrument Serif, DM Sans, JetBrains Mono)
- colors.dart and text_styles.dart complete
- go_router: 4 tab routes + settings route configured
- Bottom navigation bar widget with correct active states
- Gear icon on all tab headers → navigates to Settings shell
- sqflite: DB initialized, all tables created on first launch
- Default categories seeded on first launch
- Each screen: correct header, empty body placeholder
- **Deliverable:** Installable APK, correct navigation, fonts, colors

### M2 — Earn Tab (fully working)
- EntryForm widget with collapse/expand animation
- CategoryChips with horizontal scroll, fade gradient, [+ New]
- Inline new category text input (no modal)
- Full CRUD via entry_queries.dart
- EntryRow widget with swipe-left delete + undo snackbar
- Swipe-right inline edit (pre-filled, Update button)
- Month navigation filtering history list
- Recurring toggle + inline frequency chip selector
- Haptic feedback on save and delete
- Empty state: "No earnings this month. Tap to add your first."
- **Deliverable:** Full earnings logging working end to end

### M3 — Spend Tab (fully working)
- Reuse EntryForm, CategoryChips, EntryRow from M2
- Long-press chip → inline budget limit input → save to DB
- Budget progress bar on selected chip (3 color thresholds)
- Budget text below selected chip
- Haptic buzz at 100% budget
- Empty state
- **Deliverable:** Full expense logging + budget tracking

### M4 — Save Tab (fully working)
- Reuse all shared widgets
- Long-press chip → inline saving goal input → save to DB
- GoalCard widget with progress bar + color threshold logic
- Nudge card: conditional, dismissable, resets daily
- Empty states for goals and history
- **Deliverable:** Full savings logging + goal tracking

### M5 — Dashboard (fully working)
- All cards live from summary_provider
- Correct donut chart formula (% of earned)
- Targets card: tick marks at target%, correct color logic
- Recent Activity: last 5 entries across all 3 types by date
- Month navigation synced via selected_month_provider
- Number count-up animation on load
- **Deliverable:** Dashboard fully accurate and live

### M6 — Settings (fully working)
- All preference controls persisted to DB
- My Targets % inputs with live summary row + validation
- Category management sub-screen (add, delete, reorder)
- Backup: JSON export to Downloads
- Restore: file_picker → validate → confirm → import
- Backup reminder banner on launch
- Danger zone with the one confirmation dialog
- **Deliverable:** App production-ready, data protected

### M7 — Polish & Production
- All animations tuned and consistent
- Haptic audit across all interactions
- Every screen has an empty state (no blank areas)
- Recurring entries engine running on launch
- Light theme implementation
- BDT number formatting: 1,50,000 style
- Release APK signed and tested
- GitHub README: setup + build + install guide
- **Deliverable:** Daily-use ready, ship quality

---

## 12. One-Time Setup

### On Your Laptop
```
1. Install Flutter SDK
   https://docs.flutter.dev/get-started/install

2. Install Android Studio (free)
   Required for Android SDK and build tools

3. Run: flutter doctor
   Fix anything it reports

4. Clone and get packages:
   git clone https://github.com/yourname/fulo.git
   cd fulo
   flutter pub get
```

No npm. No Node.js. No Expo. No accounts required.

### On Your Phone (one time)
```
Android Settings → Security → Install unknown apps → Allow
```

---

## 13. Build & Install Commands

```bash
# Develop — run on phone via USB (USB debugging ON)
flutter run

# Build release APK
flutter build apk --release

# APK output:
# build/app/outputs/flutter-apk/app-release.apk

# Transfer to phone:
# USB cable, or Google Drive, or WhatsApp/Telegram to yourself

# Install:
# Tap APK in phone Files app → Install
# Reinstalling over existing app preserves all data
```

---

## 14. Total Cost

| Item | Cost |
|---|---|
| Flutter + Dart | Free / Open Source |
| All pub.dev packages | Free / Open Source |
| Android Studio | Free |
| GitHub | Free |
| Hosting | None needed |
| Accounts | None needed |
| **Monthly forever** | **BDT 0** |

---

## 15. Approved Prototype Screens

| Screen | File | Status |
|---|---|---|
| Dashboard | Dashboard.png | ✅ Approved |
| Earn | Earnings.png | ✅ Approved |
| Spend | Expenses.png | ✅ Approved |
| Save | Savings.png | ✅ Approved |
| Settings | Settings.png | ✅ Approved |
| FuloDashboard | FuloDashboard.png | ❌ Discarded |

All deviations from prototype are documented under each
screen's "Prototype issues" section above.

---

*Document status: Build-ready. Start with Milestone 1.*
