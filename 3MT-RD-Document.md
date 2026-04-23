# 3MT — Complete R&D Document
### Version 1.0 — Build-Ready
*All decisions locked. No open questions. No assumptions needed.*

---

## 1. App Identity

| | |
|---|---|
| **Name** | 3MT (My money manager & tracker) |
| **Tagline** | Your money. Your clarity. |
| **Platform** | Android only. APK sideloaded. No Play Store. No iOS. No web. |
| **User** | Single user, personal use, fully offline |
| **Language** | English only |
| **Default Currency** | BDT ৳ |
| **Default Theme** | Dark |

---

## 2. Core Philosophy

### Three Pillars — Equal, Separate, Never Mixed

| EARNINGS | SAVINGS | EXPENSES |
|---|---|---|
| Money coming in | Money ring-fenced, growing | Money gone |
| Color: #00D68F green | Color: #F5A623 gold | Color: #FF4D6D red |
| Salary, Freelance, Business | DPS, Stocks, FD | Rent, Food, Transport |

### Balance Formulas
```
Net Balance        = Earnings − Expenses
                   = everything you have (savings ring-fenced inside)

Available to Spend = Earnings − Expenses − Savings
                   = what you can freely use right now

Financial Health   = (Total Saved ÷ Total Earned) × 100
```

**Available to Spend is the primary number shown on Dashboard.**
Net Balance is secondary — shown smaller below Available to Spend
to explain the difference, with label "savings inside" below it.

Savings is NEVER shown as a loss. Gold color and "Saved" label
always frame it as wealth accumulation, not expenditure.
However savings DOES reduce Available to Spend — it is
ring-fenced, not spendable.

---

## 3. Design System

### Colors
```
Background              #0A0A0F
Surface (cards)         #13131A
Border                  #1E1E2E
Unallocated (chart)     #3A3A4A

Earn accent             #00D68F   (green)
Spend accent            #FF4D6D   (red)
Save accent             #F5A623   (gold/amber)

Text primary            #F0F0F5
Text secondary          #7B7B9A
```

### Typography
```
Display / big numbers   Instrument Serif   (balance figures)
UI / labels / buttons   DM Sans            (all interface text)
All money amounts       JetBrains Mono     (every currency value)
```

### Shape & Border
```
Card border radius      16px
Bottom sheet radius     24px
Card border             1px solid #1E1E2E
Shadows                 NONE — use border only
Primary button          Full pill shape
```

### Number Formatting
```
All BDT amounts use Bengali-style grouping: 1,50,000 not 150,000
Positive amounts prefixed with +
Negative amounts prefixed with −
Savings in summary row shown with − (reduces liquidity)
but labeled "Saved" not "Deducted"
```

---

## 4. Navigation Structure

### Bottom Navigation Bar
Always visible on all 4 main tab screens. Never on Settings.
```
[Dashboard]  [Earn]  [Spend]  [Save]
```
- Active tab: icon + label in that pillar's accent color
- Inactive tabs: #7B7B9A icon + label
- Bar background: #13131A
- Top border: 1px solid #1E1E2E

### Settings Access
- Gear icon ⚙ top-right corner on ALL 4 tab screens
- Tapping gear opens Settings as a new full screen
- Back arrow on Settings returns to previous tab
- Settings has NO bottom nav bar

### Month Navigation
- Every tab screen header shows: < "April 2026" >
- Default on app launch: current month and year
- Format: full month name + 4-digit year e.g. "April 2026"
- < arrow: previous month, > arrow: next month
- No restriction on navigation range (past or future)
- Selected month is GLOBAL — shared across all 4 tabs
- Changing month on any tab changes it everywhere
- All data, totals, charts recalculate for selected month

---

## 5. Screen Specifications

---

### SCREEN 1 — Dashboard

**Reference:** Dashboard.png ✅ approved
**Layout:** Scrollable, top to bottom

---

#### Header
```
Left:  < "April 2026" >   DM Sans medium white
       (dynamic: current month/year, updates on arrow tap)
Below: "Hello there..."   DM Sans small #7B7B9A
       (static text, never changes, no time-based logic)
Right: ⚙ gear icon        #7B7B9A
```

---

#### Card 1 — Balance Card
```
Background #13131A, border #1E1E2E, rounded 16px, padding 20px

── ZONE 1: Available to Spend ──────────────────────────────
Label:  "Available to Spend"   DM Sans small #7B7B9A centered
Number: "BDT 1,19,500"         Instrument Serif 42px white centered
        (primary dominant number)

Badge (conditional — only shown if last month data exists):
  Pill shape, centered below number
  If this month > last month:
    background #00D68F20, border 1px #00D68F
    text: "↑ BDT 5,000 vs last month"  #00D68F DM Sans 11px
  If this month < last month:
    background #FF4D6D20, border 1px #FF4D6D
    text: "↓ BDT 3,000 vs last month"  #FF4D6D DM Sans 11px
  If no last month data: badge hidden entirely, no placeholder

── DIVIDER: 1px #1E1E2E full width ─────────────────────────

── ZONE 2: Net Balance ─────────────────────────────────────
Two columns same row, left aligned:
  Left:  "Net Balance"    DM Sans small #7B7B9A
  Right: "BDT 1,24,500"  JetBrains Mono medium white
Below left aligned:
  "savings inside"        DM Sans 10px #7B7B9A

Below that — full width segmented bar, 6px height, rounded:
  Segment 1: Available portion
    width = (availableToSpend / netBalance) × 100%
    color = #00D68F green
  Segment 2: Saved portion
    width = (totalSaved / netBalance) × 100%
    color = #F5A623 gold
  No gap between segments. Together = 100% width.

Below bar — two labels:
  Left:  "Available  1,19,500"  #7B7B9A 10px
  Right: "Saved  10,000"        #F5A623 10px

── DIVIDER: 1px #1E1E2E full width ─────────────────────────

── ZONE 3: 4-column summary row ────────────────────────────
4 equal columns, label above value:
  Earned    | +1,50,000  | #00D68F  | JetBrains Mono
  Spent     |   −20,500  | #FF4D6D  | JetBrains Mono
  Saved     |   −10,000  | #F5A623  | JetBrains Mono
  Available |  1,19,500  | #F0F0F5  | JetBrains Mono
  All labels in #7B7B9A DM Sans 10px above each value
```

---

#### Card 2 — My Targets
```
Background #13131A, border #1E1E2E, rounded 16px

Header row:
  Left:  "My Targets"   DM Sans medium white
  Right: "April 2026"   DM Sans small #7B7B9A
         (shows selected month, not always current month)

── SAVE ROW ────────────────────────────────────────────────
Left:  ● gold dot  "Save"  DM Sans white
       "Target 30%"  DM Sans small #7B7B9A (right of label)
Right: "Actual 22%"  DM Sans bold #F5A623

Progress bar full width, 8px rounded:
  Fill: 22% width in #F5A623
  Unfilled: #1E1E2E
  White vertical tick mark 2px wide at exactly 30% position
  Tick mark indicates target — not current fill

Status line below bar:
  If actual < target:
    "⚠ X% short — save BDT [amount] more this month"  #F5A623 small
    amount = (target% − actual%) × totalEarned ÷ 100
  If actual ≥ target:
    "✅ Target reached this month"  #00D68F small

── DIVIDER: 1px #1E1E2E full width ─────────────────────────

── SPEND ROW ───────────────────────────────────────────────
Left:  ● red dot  "Spend"  DM Sans white
       "Target 50%"  DM Sans small #7B7B9A
Right: "Actual 48%"  DM Sans bold #00D68F

Progress bar full width, 8px rounded:
  Fill: 48% width in #00D68F (green = within target)
  If actual > target: fill color changes to #FF4D6D
  Unfilled: #1E1E2E
  White vertical tick mark at exactly 50% position

Status line below bar:
  If actual ≤ target:
    "✅ On track — BDT [amount] under limit"  #00D68F small
    amount = (target% − actual%) × totalEarned ÷ 100
  If actual > target:
    "⚠ Over limit by BDT [amount] this month"  #FF4D6D small

Note: My Targets card only shows if targets are set in Settings.
If target_save_pct = 0 AND target_spend_pct = 0:
  Card is hidden entirely from Dashboard.
```

---

#### Card 3 — Donut Chart
```
Background #13131A, border #1E1E2E, rounded 16px

Left side: donut chart, 3 segments
Right side: legend, one row per segment

Segments and formula:
  Spent%       = (totalSpent ÷ totalEarned) × 100   → #FF4D6D red
  Saved%       = (totalSaved ÷ totalEarned) × 100   → #F5A623 gold
  Unallocated% = 100 − Spent% − Saved%              → #3A3A4A grey

Legend rows (right of chart):
  ● #FF4D6D  "Spent"        XX%
  ● #F5A623  "Saved"        XX%
  ● #3A3A4A  "Unallocated"  XX%

"Earned" does NOT appear in chart or legend.
Chart represents where earned money went.

If totalEarned = 0 for selected month:
  Show empty donut (full grey circle) + "No data this month"
```

---

#### Card 4 — Financial Health
```
Background #13131A, border #1E1E2E, rounded 16px

Left:  "Financial Health"   DM Sans medium white
Right: "[XX]%"              DM Sans bold #00D68F

Progress bar full width, 6px rounded:
  Fill width = healthScore %
  Fill color:
    0–29%:   #FF4D6D  (poor)
    30–59%:  #F5A623  (moderate)
    60–100%: #00D68F  (healthy)
  Unfilled: #1E1E2E

Below: "Savings rate this month"  DM Sans small #7B7B9A

healthScore = (totalSaved ÷ totalEarned) × 100
If totalEarned = 0: show 0% and "Add earnings to track health"
```

---

#### Card 5 — Expense Breakdown by Category - Missing in UI image, you will build it
```
Background #13131A, border #1E1E2E, rounded 16px

Title row:
  Left:  "Expense Breakdown"  DM Sans medium white
  Right: "April 2026"         DM Sans small #7B7B9A

Horizontal bar chart — one row per expense category:
  Sorted: highest spend amount first
  Only categories with at least 1 entry shown

Each row:
  Category name   DM Sans small white    left
  Bar             full remaining width
    Fill:  proportional to (categoryTotal ÷ totalSpent)
    Color: #FF4D6D red
    If budget limit set for this category:
      Show white vertical tick mark on bar at budget position
      tick position = (budgetLimit ÷ highestCategoryTotal) × barWidth
      If categoryTotal > budgetLimit:
        bar fill color changes to #FF4D6D with #F5A623 border
        (signals over budget)
  Amount + %      JetBrains Mono small #7B7B9A  right
  Format: "−6,500  32%"

If no expense entries for selected month:
  Show "No expenses this month" centered #7B7B9A
```

---

#### Section — Recent Activity
```
No card wrapper. Plain background.

Title: "Recent Activity"  DM Sans medium white

5 most recent entries across ALL 3 types, sorted by date DESC.
If fewer than 5 entries total: show however many exist.
If 0 entries: show "No activity this month" centered #7B7B9A

Each row:
  Left:   circle icon, filled, colored by type
          Earning: #00D68F circle + ↑ arrow icon
          Expense: #FF4D6D circle + ↓ arrow icon
          Saving:  hollow gold circle ○  (approved UI)
  Center top:    category name  DM Sans bold white
  Center bottom: date + time    DM Sans small #7B7B9A
                 Format: "Apr 22, 09:00 AM"
  Right top:     amount         JetBrains Mono colored by type
                 Earning: +1,50,000  green
                 Expense:   −4,200  red
                 Saving:    +5,000  gold
  Right bottom:  note if exists  DM Sans small #7B7B9A

Rows separated by 1px #1E1E2E line
No swipe actions on Dashboard — view only
```

---

### SCREEN 2 — Earn Tab

**Reference:** Earnings.png ✅ approved

---

#### Header
```
Left:  "Earnings"                        DM Sans bold white
Below: "April 2026 • BDT 1,50,000 total" DM Sans small #7B7B9A
       (total updates live for selected month)
Right top: ⚙ gear icon
Right:     < > month arrows
```

---

#### Entry Form (collapsed by default)
```
COLLAPSED STATE (default on every screen load):
  Full width tappable row, background #13131A,
  border #1E1E2E, rounded 16px:
  [● green +]  "Add Earning"  [chevron ↓]

EXPANDED STATE (after tap, 300ms ease-out slide down):
  Card background #13131A, border #1E1E2E, rounded 16px

  Row 1 — Amount:
    "BDT" label  #7B7B9A left
    Amount input right, JetBrains Mono 32px white
    Keyboard opens immediately on amount field on expand
    Default value: 0 (clears on tap, not pre-selected)

  Row 2 — Category chips (horizontal scroll):
    [Salary] [Freelance] [Business] [Bonus] [Gift] [+ New]
    Selected chip: #00D68F bg, black text, pill shape
    Unselected chip: #1E1E2E bg, #7B7B9A text, pill shape
    Right edge: 40px fade gradient #0A0A0F→transparent
    Default selected: last used category
    First ever use: Salary selected by default

  [+ New] chip behaviour:
    Tap → inline text input appears within chip row
    Placeholder: "Category name..."
    User types → taps keyboard Done
    New chip created, saved to categories table, selected
    No modal. No new screen.

  Row 3 — Date:
    📅 icon  "Today, Apr 22"  #7B7B9A
    Tap → native Android date picker opens
    Default: today's date
    Format displayed: "Today, Apr 22" if today
                      "Apr 15, 2026" if past date

  Row 4 — Note:
    Placeholder: "Add a note... (optional)"  #7B7B9A
    Single underline, no box border
    Optional — not validated

  Row 5 — Recurring:
    "Recurring?"  label left  DM Sans white
    Toggle switch right, default OFF
    If toggled ON: frequency chips appear inline below:
      [Monthly]  [Weekly]
      Default selected: Monthly

  Row 6 — Save button:
    "Save Earning"  full width pill
    Background: #00D68F, text: black DM Sans bold
    Validation: amount must be > 0 AND category selected
    If invalid: button does nothing, no error shown
                (amount field highlights red border only)

AFTER SAVE:
  Form slides closed (300ms ease-in)
  New entry slides into top of history list
    (fade-in + translateY 200ms)
  Amount resets to 0
  Category keeps last selection
  Haptic: single soft pulse

COLLAPSE WITHOUT SAVING:
  Tap collapsed row while form open → closes form, no save
  No confirmation needed
```

---

#### History List — "This Month"
```
Section title: "This Month"  DM Sans medium white

Each entry row:
  Left:   green filled circle + ↑ arrow
  Center top:    category name  DM Sans bold white
  Center bottom: date           DM Sans small #7B7B9A
                 Format: "Apr 22, 2026"
  Right top:     "+80,000"      JetBrains Mono #00D68F
  Right bottom:  note if any    DM Sans small #7B7B9A
Rows separated by 1px #1E1E2E

SWIPE LEFT — delete:
  Red zone reveals on right
  Full swipe: entry collapses (slide-left 200ms)
  Snackbar: "Deleted  [Undo]"  3 second timer
  Haptic: medium pulse on delete
  Undo: entry reappears at original position, fade-in
  No confirmation dialog

SWIPE RIGHT — edit:
  Entry expands inline to pre-filled form
  All fields editable
  Save button becomes "Update"
  Cancel: swipe back OR tap outside row
  Haptic: soft pulse on expand

EMPTY STATE (no entries this month):
  "No earnings this month. Tap above to add your first."
  Centered, #7B7B9A, DM Sans
```

---

### SCREEN 3 — Spend Tab

**Reference:** Expenses.png ✅ approved

Identical structure to Earn tab with these specific differences:

```
Header title:   "Expenses"
Subtitle total: "April 2026 • BDT 20,500 total"
Accent color:   #FF4D6D red throughout
Collapsed row:  "Add Expense"
Save button:    "Save Expense"  bg #FF4D6D, text black
History icon:   red filled circle + ↓ arrow
Amounts:        prefixed −, colored #FF4D6D
Empty state:    "No expenses this month. Tap above to add your first."
```

#### Budget Warning on Chips
```
Only shown under the SELECTED chip, not all chips.

4px progress bar below selected chip, full chip width:
  categoryMonthTotal ÷ budgetLimit × 100 = usedPct
  0–79%:    fill #00D68F  (healthy)
  80–99%:   fill #F5A623  (approaching limit)
  100%+:    fill #FF4D6D  (at or over limit)

Text below bar (selected chip only):
  "Food: 6,500 / 10,000"  DM Sans small #F5A623

If no budget set for this category: bar not shown at all.
```

#### Budget Limit Setup
```
Long-press any expense category chip:
  Inline input appears below chip row (no modal, no new screen):
  "Monthly limit for Food:  [________] BDT  [Set]"
  Input: numeric, JetBrains Mono
  Tap Set → saved to budget_limits table
  Chip now shows progress bar on selection
  Long-press again → same input, pre-filled with current limit
  Clear field + Set → removes budget limit for that category

Haptic: medium pulse on Set confirmation
```

---

### SCREEN 4 — Save Tab

**Reference:** Savings.png ✅ approved

Identical structure to Earn tab with these specific differences:

```
Header title:   "Savings"
Subtitle total: "April 2026 • BDT 10,000 saved"
Accent color:   #F5A623 gold throughout
Collapsed row:  "Add Saving"
Save button:    "Save Entry"  bg #F5A623, text black
History icon:   hollow gold circle ○  (approved UI, keep as is)
Amounts:        prefixed +, colored #F5A623
Empty state:    "No savings this month. Tap above to add your first."

Category chips: [DPS] [Stocks] [FD] [Emergency]
                [Mutual Fund] [Crypto] [+ New]
```

#### Goals Section (between form and history)
```
Section title: "Goals"  DM Sans medium white

Goal cards — one per saving category that has a goal set.
If no goals set: section hidden entirely.

Each goal card (#13131A, border #1E1E2E, rounded 16px, p16):
  Top row:
    Left:  category name  DM Sans bold white
    Right: percentage     DM Sans bold, colored:
      0–49%:   #F5A623 gold
      50–99%:  #00D68F green
      100%:    #00D68F + "✅ Complete" appended

  Progress bar 8px rounded, below top row:
    Fill width = goalProgressPct %
    Fill color matches percentage color above
    Unfilled: #1E1E2E

  Bottom text:
    "BDT 12,000 saved of BDT 50,000 goal"
    DM Sans small #7B7B9A

goalProgressPct = totalSavedForCategory (all time) ÷ goalTarget × 100
Note: goal progress is ALL TIME, not just selected month.
This means saving BDT 12,000 toward DPS goal counts
even across months. Only entry logging is month-filtered.
```

#### Nudge Card
```
Shown below Goals section, above History section.
Conditional — shown ONLY when ALL of these are true:
  1. target_save_pct is set (> 0) in Settings
  2. Current month actualSavePct < target_save_pct
  3. User has not dismissed it today

Card style:
  Background: #F5A62315 (8% opacity amber)
  Left border: 3px solid #F5A623
  Text: "To hit your [X]% target, save BDT [Y] more this month."
        DM Sans small white
  ✕ button: right aligned, #7B7B9A
  Dismiss: hides for rest of calendar day, reappears next day
  Dismiss state stored in settings table as:
    nudge_dismissed_date = '2026-04-22'
  On app launch: if stored date ≠ today → show nudge again
```

#### Saving Goal Setup
```
Long-press any saving category chip:
  Inline input appears below chip row (no modal, no new screen):
  "Savings goal for DPS:  [________] BDT  [Set]"
  Input: numeric, JetBrains Mono
  Tap Set → saved to saving_goals table
  Goal card now appears in Goals section
  Long-press again → same input, pre-filled with current goal
  Clear field + Set → removes goal for that category

Haptic: medium pulse on Set confirmation
```

---

### SCREEN 5 — Settings

**Reference:** Settings.png ✅ approved
**Layout:** Single scrollable screen. Back arrow returns to previous tab.

---

#### PREFERENCES section
```
Card (#13131A, border #1E1E2E, rounded 16px):

Currency  →  BDT ৳  [chevron right]
  Tapping opens a bottom sheet with 6 options:
    BDT ৳   Bangladeshi Taka  (default)
    USD $   US Dollar
    EUR €   Euro
    GBP £   British Pound
    AED د.إ  UAE Dirham
    SGD $   Singapore Dollar
  Selecting updates currency symbol everywhere in app
  Symbol stored in settings table as currency = 'BDT'
  No free text entry. No other currencies.

Theme  →  Dark  [toggle]
  Toggle ON = dark theme (default)
  Toggle OFF = light theme
  In M1–M6: toggle saves preference but does nothing visually
  In M7: full light theme implemented
  Stored: theme = 'dark' | 'light'

Month starts on  →  1st  [chevron right]
  Tapping opens bottom sheet:
    1st (default)
    15th
    25th
  Affects how "this month" is calculated for all summaries
  Stored: month_start = '1' | '15' | '25'

Haptic feedback  [toggle]
  ON by default
  When OFF: all haptic calls are no-ops (no vibration)
  Stored: haptic = 'true' | 'false'
```

#### MY TARGETS section
```
Card (#13131A, border #1E1E2E, rounded 16px):

● "Save at least"      [30]  %
  "of your monthly earnings"  DM Sans small #7B7B9A
  Input: numeric only, max 2 digits, no decimal

─── divider ───────────────────────────────────────────

● "Spend no more than" [50]  %
  "of your monthly earnings"  DM Sans small #7B7B9A
  Input: numeric only, max 2 digits, no decimal

─── divider ───────────────────────────────────────────

Summary row (#0A0A0F bg, rounded 12px inside card):
  30% SAVINGS  |  50% SPENDING  |  20% FREE
  Colors: gold | red | green
  Font: JetBrains Mono bold
  Labels below in #7B7B9A DM Sans small caps

  FREE% = 100 − save% − spend%
  If FREE% goes negative (total > 100%):
    Show validation banner BELOW the card:
    Background #F5A62315, left border 3px #F5A623
    "Targets exceed 100% of earnings. Please adjust."
    FREE shows as negative in red

Stored: target_save_pct, target_spend_pct as integers
Changes apply immediately to Dashboard My Targets card
```

#### CATEGORIES section
```
Card (#13131A, border #1E1E2E, rounded 16px):

Earning Categories   6 categories  [chevron]
─── divider ───────────────────────────────
Expense Categories   8 categories  [chevron]
─── divider ───────────────────────────────
Saving Categories    7 categories  [chevron]

Category count updates live as user adds/removes categories.
```

#### Category Management Sub-Screen
```
Opens when tapping any category chevron.
Header: ← back  |  "Earning Categories" center  |  ⚙ hidden

List of all categories for that type, each row:
  Emoji icon  |  Category name  DM Sans bold white  |  ✕ right
  Default categories (is_default=1): ✕ hidden, cannot delete
  User categories: ✕ visible, tapping deletes immediately
    No confirmation on category delete
    If deleted category has entries: entries keep category_id
    but category name shows as "Deleted Category" in grey

Drag to reorder:
  Long-press any row → drag handle ≡ appears on left
  Drag up/down to reorder
  Order saved to sort_order column

Bottom of list (always visible, not scrolled away):
  [+ Add Category] row
  Tapping: text input appears inline at bottom of list
  Placeholder: "Category name..."
  User types → taps keyboard Done
  New category appended to list, emoji defaults to 📌
  No modal. No confirmation.
```

#### DATA & BACKUP section
```
Amber warning banner (conditional):
  Shown if last_backup is empty OR > 7 days ago:
  Background #F5A62315, left border 3px #F5A623
  "Back up your data — [X] days since last backup"
  Tapping banner scrolls to backup card (same screen)

Card (#13131A, border #1E1E2E, rounded 16px):
  Backup Now     [Export JSON]  gold pill button
  ─── divider ──────────────────────────────────
  Restore Backup [Import]       dark pill button
  ─── divider ──────────────────────────────────
  Last backup    "Apr 20, 2026 at 10:32 AM"  #7B7B9A
                 If never backed up: "Never"  #FF4D6D
```

#### DANGER ZONE section
```
No card wrapper. Plain rows.
  "Clear All Data"  text #FF4D6D  |  [Reset]  outline red button

Tapping Reset: shows the ONE confirmation dialog in entire app:
  "This will permanently delete all your data.
   This cannot be undone."
  [Cancel]  [Delete Everything]
  Cancel: dismisses
  Delete Everything: drops all tables, recreates schema,
  reseeds default categories and default settings,
  navigates to Dashboard

Below button:
  "This cannot be undone. Export a backup first."
  DM Sans tiny #7B7B9A
```

---

## 6. Interaction Patterns

### Form Collapse / Expand (Earn, Spend, Save tabs)
```
Default: collapsed on every screen load (not just first load)

Collapsed → Expanded:
  Animation: slide down 300ms ease-out
  Keyboard: opens immediately on amount input
  No delay between tap and keyboard appearance

Expanded → Collapsed (after save):
  Animation: slide up 300ms ease-in
  New entry: fade-in + translateY into top of history list 200ms
  Amount: resets to 0
  Category: keeps last selection
  Date: resets to today
  Note: clears
  Recurring: resets to OFF

Expanded → Collapsed (without saving):
  Tap collapsed trigger row while form is open
  Form closes, nothing saved, no confirmation

Validation on Save tap:
  amount = 0: amount input border turns red, no other action
  no category: should not be possible (always one selected)
```

### Swipe Delete
```
Swipe left on any entry row (Earn, Spend, Save history):
  Right side reveals red delete background
  Full swipe (past 50% of row width): commits delete
  Entry slides left and collapses (200ms)
  Snackbar bottom: "Deleted  [Undo]"  3 second auto-dismiss
  Haptic: medium pulse
  Undo within 3s: entry reinserted at original position
  After 3s: deletion committed to DB, snackbar gone
  No confirmation dialog ever
```

### Swipe Edit
```
Swipe right on any entry row:
  Entry expands inline to pre-filled edit form
  All fields editable (same layout as add form)
  Save button labeled "Update"
  Haptic: soft pulse
  Cancel: swipe back left OR tap anywhere outside row
  On Update tap: same validation as add form
                 entry updates in DB and in list inline
```

### Recurring Entries Engine
```
Runs once on every app launch (not on resume, only cold start)

For each row in recurring_rules where next_date ≤ today:
  1. Create new entry with same type/amount/category/note
     date = next_date (not today, the scheduled date)
  2. If period = 'monthly': advance next_date by 1 month
     If period = 'weekly': advance next_date by 7 days
  3. Repeat until next_date > today (catches missed months)

Auto-created entries appear in history list normally.
User can delete individual auto-created entries without
affecting the recurring rule.
Recurring rules management: Settings → future milestone
```

---

## 7. Data Architecture

### Storage
sqflite SQLite file on Android internal storage.
Not browser. Not cloud. Real file, persists through
restarts. Lost only on factory reset or app uninstall.

### Database Schema

```sql
CREATE TABLE entries (
  id            TEXT PRIMARY KEY,   -- UUID v4
  type          TEXT NOT NULL,      -- 'earning' | 'expense' | 'saving'
  amount        REAL NOT NULL,      -- always positive, type determines sign
  category_id   TEXT NOT NULL,      -- FK → categories.id
  date          TEXT NOT NULL,      -- ISO 8601: '2026-04-22'
  note          TEXT,               -- nullable
  is_recurring  INTEGER DEFAULT 0,  -- 0 = no, 1 = yes
  recur_period  TEXT,               -- 'monthly' | 'weekly' | null
  recur_rule_id TEXT,               -- FK → recurring_rules.id | null
  created_at    TEXT NOT NULL       -- ISO 8601 datetime
);

CREATE TABLE categories (
  id         TEXT PRIMARY KEY,      -- UUID v4
  type       TEXT NOT NULL,         -- 'earning' | 'expense' | 'saving'
  name       TEXT NOT NULL,
  icon       TEXT,                  -- single emoji character
  color      TEXT,                  -- hex, reserved for future use
  sort_order INTEGER DEFAULT 0,     -- lower = shown first
  is_default INTEGER DEFAULT 0      -- 1 = cannot be deleted
);

CREATE TABLE budget_limits (
  id          TEXT PRIMARY KEY,     -- UUID v4
  category_id TEXT NOT NULL,        -- FK → categories.id (expense only)
  amount      REAL NOT NULL,        -- monthly limit
  created_at  TEXT NOT NULL
);

CREATE TABLE saving_goals (
  id          TEXT PRIMARY KEY,     -- UUID v4
  category_id TEXT NOT NULL,        -- FK → categories.id (saving only)
  target      REAL NOT NULL,        -- all-time target amount
  created_at  TEXT NOT NULL
);

CREATE TABLE recurring_rules (
  id          TEXT PRIMARY KEY,     -- UUID v4
  type        TEXT NOT NULL,        -- 'earning' | 'expense' | 'saving'
  amount      REAL NOT NULL,
  category_id TEXT NOT NULL,
  period      TEXT NOT NULL,        -- 'monthly' | 'weekly'
  note        TEXT,
  next_date   TEXT NOT NULL,        -- ISO 8601 date of next auto-entry
  created_at  TEXT NOT NULL
);

CREATE TABLE settings (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
```

### Default Settings (inserted on first launch only)
```
currency              = 'BDT'
theme                 = 'dark'
month_start           = '1'
haptic                = 'true'
target_save_pct       = '30'
target_spend_pct      = '50'
last_backup           = ''
nudge_dismissed_date  = ''
```

### Default Categories (inserted on first launch, is_default = 1)
```
EARNINGS (type='earning'):
  Salary        💼  sort_order=1
  Freelance     💻  sort_order=2
  Business      🏪  sort_order=3
  Bonus         🎯  sort_order=4
  Gift          🎁  sort_order=5
  Other         📥  sort_order=6

EXPENSES (type='expense'):
  Rent          🏠  sort_order=1
  Food          🍽️  sort_order=2
  Transport     🚗  sort_order=3
  Utilities     💡  sort_order=4
  Health        🏥  sort_order=5
  Education     📚  sort_order=6
  Entertainment 🎬  sort_order=7
  Shopping      🛍️  sort_order=8
  Other         📤  sort_order=9

SAVINGS (type='saving'):
  DPS           🏦  sort_order=1
  Stocks        📈  sort_order=2
  FD            🔒  sort_order=3
  Emergency     🛡️  sort_order=4
  Mutual Fund   📊  sort_order=5
  Crypto        ₿   sort_order=6
  Cash Reserve  💵  sort_order=7
```

### Computed Values (never stored, always calculated live)
```dart
// Scoped to selected month (year + month filter on entries.date)

totalEarned    = SUM(amount WHERE type='earning' AND month=M)
totalSpent     = SUM(amount WHERE type='expense' AND month=M)
totalSaved     = SUM(amount WHERE type='saving'  AND month=M)

netBalance     = totalEarned - totalSpent
availableToSpend = totalEarned - totalSpent - totalSaved

healthScore    = totalEarned > 0
                 ? (totalSaved / totalEarned) * 100
                 : 0

actualSavePct  = totalEarned > 0
                 ? (totalSaved / totalEarned) * 100
                 : 0

actualSpendPct = totalEarned > 0
                 ? (totalSpent / totalEarned) * 100
                 : 0

freePct        = 100 - actualSavePct - actualSpendPct

targetSaveAmt  = totalEarned * (target_save_pct / 100)
saveRemaining  = targetSaveAmt - totalSaved

// Month-over-month badge
prevMonthAvailable = availableToSpend calculated for M-1
badgeDelta         = availableToSpend - prevMonthAvailable
showBadge          = prevMonthAvailable data exists

// Category-level (expense)
categoryMonthTotal = SUM(amount WHERE category_id=C AND month=M)
chipBudgetPct      = budgetLimit > 0
                     ? categoryMonthTotal / budgetLimit * 100
                     : null  (no bar shown if no budget set)

// Category-level (saving goals — ALL TIME not monthly)
goalProgressPct    = totalSavedForCategory / goalTarget * 100
totalSavedForCategory = SUM(amount WHERE category_id=C AND type='saving')
                        (no month filter — all time total)
```

### Division by Zero Rule
```
Any formula dividing by totalEarned:
  If totalEarned = 0: result = 0, no crash, no NaN
  Show "—" instead of percentage in UI
  Show "Add earnings to see this" as subtitle where relevant
```

---

## 8. Backup & Restore

### Export
```
Trigger: "Backup Now" button in Settings
1. Read all rows from all 6 tables
2. Serialize to JSON structure:
   {
     "version": 1,
     "app": "3MT",
     "exported_at": "2026-04-22T10:32:00",
     "entries": [...],
     "categories": [...],
     "budget_limits": [...],
     "saving_goals": [...],
     "recurring_rules": [...],
     "settings": {...}
   }
3. Write file to phone Downloads folder (path_provider)
   Filename: 3MT-backup-2026-04-22.json
   If file with same name exists: overwrite silently
4. Update last_backup in settings table to current datetime
5. Snackbar: "Backup saved to Downloads ✓"
```

### Import
```
Trigger: "Restore Backup" button in Settings
1. file_picker opens — filter to .json files only
2. User selects file
3. App reads and parses JSON
4. Validates: must have "app":"3MT" and "version":1
   Invalid: snackbar "Invalid backup file. Please try another."
   Valid: proceed
5. Show the ONE AND ONLY confirmation dialog in the app:
   Title: "Restore Backup?"
   Body:  "This will replace all your current data."
   Buttons: [Cancel]  [Restore]
6. On Restore:
   Drop all tables
   Recreate schema (same CREATE TABLE statements)
   Insert all rows from JSON
   Snackbar: "Data restored successfully ✓"
7. On Cancel: dismiss dialog, nothing changes
```

### Backup Reminder
```
On every cold app launch:
  Read last_backup from settings
  If last_backup = '' OR (today - last_backup) > 7 days:
    Show amber banner at top of Dashboard content area
    (below header, above Balance card)
    Background #F5A62315, left border 3px #F5A623
    "Back up your data — [X] days since last backup"
    X = number of days since last backup
    If never backed up: "Back up your data — never backed up"
    Tapping banner: navigates to Settings, scrolls to backup section
    Banner stays visible until user backs up (no dismiss button)
```

---

## 9. Tech Stack

| Layer | Choice | Notes |
|---|---|---|
| Framework | **Flutter** | Near-native Android performance |
| Language | **Dart** | Typed, compiled, small ecosystem |
| Package manager | **pub (pub.dev)** | Google-managed, no npm |
| IDE | **VS Code** | Flutter + Dart extensions. Android Studio installed for SDK/build tools only — never opened for coding |
| Database | **sqflite** | SQLite on device file system |
| State management | **Riverpod** | Type-safe, no BuildContext dependency |
| Charts | **fl_chart** | Donut chart + horizontal bar chart |
| File system | **path_provider** | Downloads folder access |
| File picker | **file_picker** | JSON restore picker |
| Haptics | **haptic_feedback** | Built into Flutter SDK |
| Navigation | **go_router** | Declarative routing |
| Build | **flutter build apk** | Single command, no services |
| Code hosting | **GitHub** | Free |

**No backend. No server. No npm. No accounts. BDT 0/month forever.**

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

---

## 10. Project Folder Structure

```
3MT/
├── lib/
│   ├── main.dart                        # Entry, DB init, recurring engine
│   ├── app.dart                         # MaterialApp, ThemeData, router
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart              # All hex tokens as const Color
│   │   │   ├── text_styles.dart         # TextStyle for 3 typefaces
│   │   │   └── default_categories.dart  # Seed list for first launch
│   │   ├── utils/
│   │   │   ├── currency_formatter.dart  # Bengali grouping: 1,50,000
│   │   │   ├── date_helpers.dart        # Month range, ISO parse/format
│   │   │   └── recurring_engine.dart    # Auto-create overdue entries
│   │   └── router.dart                  # go_router all routes defined
│   │
│   ├── db/
│   │   ├── database_helper.dart         # sqflite open, onCreate, onUpgrade
│   │   ├── schema.dart                  # All CREATE TABLE SQL constants
│   │   ├── seed.dart                    # insertDefaultCategories(),
│   │   │                               # insertDefaultSettings()
│   │   └── queries/
│   │       ├── entry_queries.dart       # insert, update, delete, getByMonth
│   │       ├── category_queries.dart    # insert, delete, reorder, getByType
│   │       ├── budget_queries.dart      # upsert, delete, getByCategory
│   │       ├── goal_queries.dart        # upsert, delete, getByCategory
│   │       ├── settings_queries.dart    # get(key), set(key, value)
│   │       └── computed_queries.dart    # all SUM aggregations
│   │
│   ├── models/
│   │   ├── entry.dart                   # Entry data class + fromMap/toMap
│   │   ├── category.dart
│   │   ├── budget_limit.dart
│   │   ├── saving_goal.dart
│   │   ├── recurring_rule.dart
│   │   └── month_summary.dart           # Holds all computed totals
│   │
│   ├── providers/
│   │   ├── selected_month_provider.dart # StateProvider<DateTime>
│   │   ├── entries_provider.dart        # FutureProvider, month-filtered
│   │   ├── categories_provider.dart     # FutureProvider by type
│   │   ├── summary_provider.dart        # Derived from entries, all calcs
│   │   └── settings_provider.dart       # All settings key-values
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
│   │   │   ├── bottom_nav_bar.dart      # 4-tab nav
│   │   │   ├── screen_header.dart       # Title + month nav + gear
│   │   │   ├── entry_form.dart          # Collapse/expand animated form
│   │   │   ├── entry_row.dart           # Swipeable row (delete + edit)
│   │   │   ├── category_chips.dart      # Horizontal scroll + fade + new
│   │   │   └── section_title.dart       # Reusable section heading
│   │   ├── dashboard/
│   │   │   ├── balance_card.dart        # All 3 zones of balance card
│   │   │   ├── targets_card.dart        # Save + Spend target rows
│   │   │   ├── donut_chart_card.dart    # fl_chart donut
│   │   │   ├── health_score_card.dart   # Health % bar
│   │   │   ├── expense_breakdown_card.dart # Horizontal bar chart
│   │   │   └── recent_activity_list.dart
│   │   └── save/
│   │       ├── goal_card.dart           # Single goal progress card
│   │       └── nudge_card.dart          # Savings nudge banner
│   │
│   └── services/
│       └── backup_service.dart          # exportToJson(), importFromJson()
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
- Flutter project created, pubspec.yaml complete
- All 3 custom fonts loaded and registered
- colors.dart: all hex tokens as const Color
- text_styles.dart: TextStyle definitions for all 3 fonts
- go_router: 4 tab routes + settings route + category route
- Bottom nav bar widget: correct colors, active/inactive states
- screen_header.dart: title + month arrows + gear icon
- Month arrows wired to selected_month_provider
- Gear icon on all tabs navigates to Settings shell
- sqflite: DB opens on launch, all tables created (onCreate)
- Default categories seeded if first launch
- Default settings seeded if first launch
- Each screen: correct header, "Coming soon" placeholder body
- **Deliverable:** Installable APK, navigation works, fonts render,
  colors correct, month arrows change displayed month

### M2 — Earn Tab (fully working)
- entry_form.dart: collapse/expand animation (AnimationController)
- category_chips.dart: scroll, fade gradient, [+ New] inline input
- Full CRUD: insertEntry, updateEntry, deleteEntry, getByMonth
- entry_row.dart: swipe left delete + undo snackbar
- entry_row.dart: swipe right inline edit
- Month navigation filters history list
- Recurring toggle + frequency chips + rule saved to DB
- Haptic on save and delete
- Empty state message
- **Deliverable:** Full earnings logging end to end

### M3 — Spend Tab (fully working)
- Reuse entry_form, category_chips, entry_row from M2
- budget_queries.dart: upsert and delete
- Long-press chip → inline budget input
- Budget progress bar on selected chip (3 color thresholds)
- Budget text below selected chip
- Haptic at 100% budget reached
- Empty state
- **Deliverable:** Full expense logging + budget tracking

### M4 — Save Tab (fully working)
- Reuse shared widgets
- goal_queries.dart: upsert and delete
- Long-press chip → inline goal input
- goal_card.dart: progress bar, % color thresholds, all-time total
- nudge_card.dart: conditional, dismiss stores date, resets daily
- Empty states for goals and history
- **Deliverable:** Full savings logging + goal tracking

### M5 — Dashboard (fully working)
- balance_card.dart: all 3 zones, segmented bar, badge logic
- targets_card.dart: bars, tick marks, status messages, hidden if no targets
- donut_chart_card.dart: correct formula, 3 segments, grey unallocated
- health_score_card.dart: color thresholds on bar
- expense_breakdown_card.dart: horizontal bars, budget markers
- recent_activity_list.dart: 5 entries, all types, date sorted
- summary_provider.dart: all computed values live
- Division by zero handled everywhere
- Number count-up animation on Dashboard load
- **Deliverable:** Dashboard fully accurate, all cards live

### M6 — Settings (fully working)
- All preference controls saved to settings table
- Currency bottom sheet (6 options)
- Theme toggle (saves preference, no visual change yet)
- Month start bottom sheet
- Haptic toggle
- Targets inputs: live FREE% summary, validation banner
- category_management_screen.dart: add, delete, reorder
- backup_service.dart: export JSON to Downloads
- backup_service.dart: import JSON with validation + dialog
- Backup reminder banner on Dashboard (7-day logic)
- Danger zone: clear all data with confirmation dialog
- **Deliverable:** App fully configurable, data protected

### M7 — Polish & Production
- Light theme: full color mapping, toggle works visually
- All animations tuned (timing, curves consistent)
- Haptic audit across all interactions
- All empty states present (no blank screens)
- BDT number formatting: 1,50,000 style confirmed everywhere
- Currency symbol renders in all amount displays
- Recurring engine: tested across month boundaries
- Release APK: signed, tested on physical device
- GitHub README: setup + flutter doctor + build + install guide
- **Deliverable:** Ship-quality, daily-use personal finance app

---

## 12. Setup & Build

### Laptop Setup (one time)
```bash
# 1. Install Flutter SDK
#    https://docs.flutter.dev/get-started/install

# 2. Install Android Studio (for SDK and build tools only)
#    Do not use Android Studio for coding — use VS Code

# 3. Install VS Code extensions:
#    Flutter (by Dart Code)
#    Dart (by Dart Code)

# 4. Verify setup
flutter doctor
# Fix any issues reported before proceeding

# 5. Clone and install packages
git clone https://github.com/yourname/3MT.git
cd 3MT
flutter pub get
```

### Phone Setup (one time)
```
Android Settings → Security → Install unknown apps → Allow
Enable USB Debugging: Settings → Developer Options → USB Debugging ON
```

### Daily Development
```bash
# Connect phone via USB cable
flutter run               # hot reload during development
```

### Build Release APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
# Transfer: USB cable, Google Drive, or Telegram/WhatsApp to self
# Install: tap APK in Files app → Install
# Reinstalling over existing app: data is preserved
```

---

## 13. Approved Prototype Screens

| Screen | File | Status |
|---|---|---|
| Dashboard | Dashboard.png | ✅ Approved with documented deviations |
| Earn | Earnings.png | ✅ Approved with documented deviations |
| Spend | Expenses.png | ✅ Approved with documented deviations |
| Save | Savings.png | ✅ Approved with documented deviations |
| Settings | Settings.png | ✅ Approved with documented deviations |
All prototype deviations are documented inline in Section 5.

---

## 14. Locked Implementation Decisions
*Do not ask about these during build. All decided.*

| Decision | Answer |
|---|---|
| Greeting text | Static "Hello there..." — never changes |
| Time-based greeting | No — always "Hello there..." |
| Month display | Dynamic — current month on launch, updates on arrow tap |
| Month format | "April 2026" — full name + 4-digit year |
| Month scope | Global across all 4 tabs simultaneously |
| Badge when no last month data | Hidden entirely — never show BDT 0 |
| Donut chart formula | Spent÷Earned, Saved÷Earned, remainder=Unallocated grey |
| Donut chart labels | Spent / Saved / Unallocated — no "Earned" label |
| Form default state | Collapsed on every screen load |
| Date picker | Native Android date picker — no custom calendar |
| Currency selector | 6-option bottom sheet — no free text |
| Light theme | M7 only — toggle saves but does nothing in M1–M6 |
| Goal progress scope | All-time total, not month-filtered |
| Savings in balance | Subtracted from Available to Spend, NOT from Net Balance |
| Net Balance label | "savings inside" shown below the value |
| Division by zero | Returns 0, shows "—" in UI, no crash |
| Code delivery | All .dart files generated per milestone, copy-paste ready |
| Milestone order | M1 → M7 strictly in sequence |
| IDE | VS Code (Android Studio for SDK only, never opened) |
| Target platform | Android APK only. Sideloaded. No Play Store. |
| Expense breakdown chart | Dashboard only. Horizontal bars. Budget markers. |
| Only confirmation dialog | Restore backup and Clear all data — these two only |
| Category delete with entries | Entries kept, category shows as "Deleted Category" |
| Nudge card dismiss | Hides for calendar day, reappears next day |
| Backup reminder dismiss | No dismiss — stays until user backs up |

---

*Document version: 1.0*
*Clear any further clarification you need before Start coding for Milestone 1*