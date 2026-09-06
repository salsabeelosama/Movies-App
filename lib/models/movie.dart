/// Simple data model for a movie. Swap for your real model (e.g. one
/// generated from an API response) — just keep the field names, or
/// update the widgets in lib/pages and lib/widgets that reference them.
class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final int year;
  final double rating; // e.g. 7.6
  final int likes; // heart count
  final int durationMinutes;
  final List<String> screenshotUrls;

  /// Optional larger/cleaner poster used specifically for the Details
  /// hero. Falls back to [posterUrl] (the grid card art) when null —
  /// set this when your grid card art has a baked-in badge/caption that
  /// you don't want blown up full-bleed on the Details screen.
  final String? detailsPosterUrl;

  /// Optional gradient/scrim image (same dimensions as the hero poster)
  /// layered on top of it in the Details screen to fade it to black
  /// toward the bottom. Leave null to skip the effect.
  final String? posterGradientUrl;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.year,
    required this.rating,
    this.likes = 0,
    this.durationMinutes = 0,
    this.screenshotUrls = const [],
    this.detailsPosterUrl,
    this.posterGradientUrl,
  });
}
