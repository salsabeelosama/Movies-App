# movies_app

A Flutter movie-browsing UI with a dark theme: Home, Search, Movie Details,
Saved, and Profile tabs, built with `flutter_screenutil` for responsive
sizing and `easy_localization` for strings.

## Structure

```
lib/
  main.dart                  # entrypoint — sets up EasyLocalization + ScreenUtil
  theme/app_theme.dart        # colors + ThemeData
  models/movie.dart           # Movie data model
  data/sample_movies.dart     # in-memory sample data (swap for your API)
  widgets/
    app_bottom_nav.dart       # shared bottom nav bar
    movie_poster_card.dart    # poster card used in grids
  pages/
    root_shell.dart           # IndexedStack of the 4 tabs + shared nav bar
    home_page.dart
    search_page.dart
    movie_details_page.dart
    placeholder_pages.dart    # Saved + Profile stubs

assets/
  Images/                     # movie poster art
  icons/                      # ic_play.png, ic_empty_state.png
  translation/en.json         # easy_localization strings
```

## Running it

```
flutter pub get
flutter run
```

## Known gaps / TODOs

- **Font**: `pubspec.yaml`'s custom Roboto font block is commented out
  because no `Roboto.ttf` file was provided. Add one to `assets/fonts/`
  and uncomment the block (and the `fontFamily: 'Roboto'` line in
  `app_theme.dart`) to use it — Material's default font is very close
  to Roboto in the meantime.
- **Data**: `sample_movies.dart` is static/in-memory. Wire `SearchPage`'s
  `onSearch` callback and `HomePage`'s movie list to your real API/DB.
- **Localization**: strings are still hardcoded in the page widgets
  rather than pulled from `assets/translation/en.json` via `.tr()` —
  the JSON file and `EasyLocalization` setup are wired up, so this is a
  drop-in change per string.
- **Bookmark persistence**: `MovieDetailsPage`'s bookmark toggle is
  local widget state only — it doesn't persist or feed the Saved tab.
- **`doctor_strange_hero.png`**: a larger cropped hero image is included
  in `assets/Images/` but not used by default (see prior note about it
  containing baked-in UI). Swap it into `movie_details_page.dart`'s
  `_posterImage` call if you'd rather use it as the Details hero.
