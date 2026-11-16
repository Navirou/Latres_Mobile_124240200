import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tv_show.dart';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com';

  /// Fetch all shows from TVMaze
  static Future<List<TvShow>> fetchShows() async {
    try {
      final uri = Uri.parse('$baseUrl/shows');
      final response = await http.get(uri).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((item) => TvShow.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load shows (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error while fetching shows: $e');
    }
  }

  /// Fetch single show detail by ID
  static Future<TvShow> fetchShowDetail(int id) async {
    try {
      final uri = Uri.parse('$baseUrl/shows/$id');
      final response = await http.get(uri).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return TvShow.fromJson(jsonData);
      } else {
        throw Exception('Failed to load show detail (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error while fetching show detail: $e');
    }
  }
}
