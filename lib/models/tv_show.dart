class TvShow {
  final int id;
  final String name;
  final String? imageMedium;
  final String? imageOriginal;
  final double? rating;
  final List<String> genres;
  final String summary;
  final String? premiered;
  final String? status;
  final String? officialSite;

  TvShow({
    required this.id,
    required this.name,
    this.imageMedium,
    this.imageOriginal,
    this.rating,
    required this.genres,
    required this.summary,
    this.premiered,
    this.status,
    this.officialSite,
  });

  factory TvShow.fromJson(Map<dynamic, dynamic> json) {
    // Rating
    double? parsedRating;
    if (json['rating'] != null && json['rating'] is Map) {
      final avg = json['rating']['average'];
      if (avg != null) {
        parsedRating = (avg is num) ? avg.toDouble() : double.tryParse(avg.toString());
      }
    } else if (json['ratingValue'] != null) {
      // In case we saved it in Hive flat
      final val = json['ratingValue'];
      parsedRating = (val is num) ? val.toDouble() : double.tryParse(val.toString());
    }

    // Images
    String? medium;
    String? original;
    if (json['image'] != null && json['image'] is Map) {
      medium = json['image']['medium']?.toString();
      original = json['image']['original']?.toString();
    } else {
      medium = json['imageMedium']?.toString();
      original = json['imageOriginal']?.toString();
    }

    // Genres
    List<String> parsedGenres = [];
    if (json['genres'] != null && json['genres'] is List) {
      parsedGenres = (json['genres'] as List).map((e) => e.toString()).toList();
    }

    return TvShow(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? 'Unknown Show',
      imageMedium: medium,
      imageOriginal: original,
      rating: parsedRating,
      genres: parsedGenres,
      summary: json['summary']?.toString() ?? '',
      premiered: json['premiered']?.toString(),
      status: json['status']?.toString(),
      officialSite: json['officialSite']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageMedium': imageMedium,
      'imageOriginal': imageOriginal,
      'ratingValue': rating,
      'genres': genres,
      'summary': summary,
      'premiered': premiered,
      'status': status,
      'officialSite': officialSite,
      'image': {
        'medium': imageMedium,
        'original': imageOriginal,
      },
      'rating': {
        'average': rating,
      },
    };
  }

  /// Clean HTML tags such as `<p>`, `</p>`, `<b>`, `<i>`, etc.
  String get cleanSummary {
    if (summary.isEmpty) return 'No description available for this show.';
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    final cleaned = summary.replaceAll(exp, '').trim();
    return cleaned.isEmpty ? 'No description available for this show.' : cleaned;
  }

  String get displayRating {
    if (rating == null) return 'N/A';
    return rating!.toStringAsFixed(1);
  }

  String get displayGenres {
    if (genres.isEmpty) return 'General';
    return genres.join(', ');
  }

  String? get bestImage => imageOriginal ?? imageMedium;
}
