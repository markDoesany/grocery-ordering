# Grocery App Architecture

This app is a Flutter mock grocery ordering experience. It uses a feature-first
folder structure, Riverpod for state, and GoRouter for navigation.

The goal of the structure is simple:

- Keep app-wide infrastructure in `core/`.
- Keep reusable UI and mock data in `shared/`.
- Keep each product area in `features/<feature>/`.
- Avoid abstractions until there is repeated behavior worth naming.

## Flutter In One Minute

Flutter screens are built from widgets. A widget is just a small piece of UI.
Widgets compose into trees:

- `Scaffold` is the common page shell.
- `AppBar` is the top bar.
- `Column`, `Row`, `Stack`, `Padding`, and `Container` are layout widgets.
- `ConsumerWidget` and `ConsumerStatefulWidget` are Riverpod-aware widgets.
- `StatelessWidget` has no local mutable state.
- `StatefulWidget` has local state, such as a selected carousel page.

Most files in this app are widgets.

## Folder Map

```text
lib/
  app.dart
  main.dart
  core/
    config/
    constants/
    navigation/
    network/
    theme/
    utils/
  features/
    auth/
    branding/
    cart/
    checkout/
    home/
    inventory/
    order_details/
    order_summary/
    rewards/
    search/
    splash/
  shared/
    data/
    models/
    providers/
    utils/
    widgets/
```

## App Entry Flow

1. `main.dart` starts Flutter and wraps the app in Riverpod `ProviderScope`.
2. `app.dart` reads the active theme and router providers.
3. `router.dart` defines the pages and transition animation.
4. `splash_screen.dart` loads branding and routes to login.
5. `login_screen.dart` routes to the catalog/home screen.

## Core Layer

`core/` is for app infrastructure that features depend on.

- `core/config/router.dart` owns route definitions.
- `core/constants/app_constants.dart` owns route strings and global constants.
- `core/navigation/app_navigation.dart` maps bottom tabs to routes and provides
  safe navigation helpers.
- `core/theme/app_theme.dart` creates a `ThemeData` from tenant branding.
- `core/theme/theme_provider.dart` exposes the branded theme through Riverpod.
- `core/network/api_client.dart` is reserved for future API integration.

Rule of thumb: if many features need it and it is not UI-specific, it probably
belongs in `core/`.

## Shared Layer

`shared/` contains reusable pieces that are intentionally generic.

- `shared/widgets/app_surface.dart`: standard card/surface treatment.
- `shared/widgets/app_action_button.dart`: standard CTA button.
- `shared/widgets/app_scroll_view.dart`: standard vertical scroll page body.
- `shared/widgets/mobile_scaffold.dart`: standard tabbed page shell.
- `shared/widgets/bottom_nav_bar.dart`: bottom navigation UI.
- `shared/widgets/section_header.dart`: section labels.
- `shared/data/mock_catalog.dart`: mock products and promotions.
- `shared/models/product_model.dart`: simple product model.
- `shared/utils/mock_actions.dart`: demo bottom sheets/snackbars.

Rule of thumb: put something in `shared/` only after at least two features need
the same concept. That keeps the app DRY without over-abstracting too early.

## Feature Layer

Each feature owns its UI and feature-specific state.

```text
features/<feature>/
  domain/        Business state or providers for that feature.
  data/          API/repository work for that feature.
  presentation/  Screens and widgets.
```

Not every feature needs all three folders. Keep the folder small until there is
a real reason to split it further.

Examples:

- `features/cart/domain/cart_provider.dart` owns cart state and derived totals.
- `features/cart/presentation/cart_screen.dart` displays the cart.
- `features/home/presentation/widgets/product_card.dart` displays a product,
  but delegates quantity state to the cart provider.

## State Management

The app uses Riverpod.

Important providers:

- `brandingProvider`: loads tenant branding.
- `themeProvider`: builds the theme from branding.
- `routerProvider`: owns GoRouter.
- `cartProvider`: mutable cart quantities.
- `cartItemsProvider`: derived cart line items.
- `cartSummaryProvider`: derived subtotal/tax/total/badge count.

Guidelines:

- Local UI-only state can stay in a `StatefulWidget`.
  Example: carousel current page.
- State shared across screens should use Riverpod.
  Example: cart quantities.
- Derived values should be providers, not recalculated by each screen.
  Example: cart totals.

## Navigation

Use `context.go(route)` for primary route changes and helpers from
`core/navigation/app_navigation.dart` where possible.

Bottom-tab navigation is centralized:

- Add a new tab to `AppTab`.
- Add its route in the `AppTabRoute` extension.
- Add the tab UI item in `bottom_nav_bar.dart`.

Back/close buttons that may be opened directly should use `popOrGo(context,
fallbackRoute)`. This avoids broken back buttons when there is no stack to pop.

## UI Principles

The app should feel like a compact B2B grocery tool:

- Use `AppSurface` for cards and framed panels.
- Use `AppActionButton` for main actions.
- Use `AppScrollView` for vertical page bodies.
- Keep pages dense but readable.
- Let tenant branding color provide the accent.
- Avoid large decorative sections unless they support the workflow.

## Adding A New Screen

1. Create `features/<feature>/presentation/<feature>_screen.dart`.
2. Add a route constant in `app_constants.dart`.
3. Add a `GoRoute` in `router.dart`.
4. Use `MobileScaffold` if it belongs to the bottom-tab experience.
5. Put reusable widgets under `features/<feature>/presentation/widgets/`.
6. Add a focused widget test if the screen has layout/state behavior.

## Adding API Data Later

Current product and promotion data live in `shared/data/mock_catalog.dart`.

When a real backend is ready:

1. Create a repository in the relevant feature or shared data area.
2. Keep the existing `ProductModel` shape if possible.
3. Replace direct mock reads with Riverpod providers.
4. Keep widgets dependent on models/providers, not HTTP clients.

This preserves separation of concerns:

- Widgets display data.
- Providers expose state.
- Repositories fetch or save data.
- `api_client.dart` handles HTTP details.

## Testing

Current tests:

- `cart_provider_test.dart`: verifies cart state transitions.
- `cart_screen_test.dart`: verifies cart layout does not regress.
- `widget_test.dart`: smoke test for app bootstrap.

Recommended test growth:

- Add one smoke/layout test per major screen.
- Add provider tests for new shared state.
- Add navigation tests only when route behavior becomes complex.

## Practical Rules

- KISS: prefer a simple widget over a generic abstraction.
- DRY: extract repeated behavior after it appears in multiple places.
- YAGNI: do not add service layers or interfaces until there is a real second
  implementation.
- SOLID: keep state, navigation, data, and UI responsibilities separate.
- Small files are good, but only split when the split names a real concept.
