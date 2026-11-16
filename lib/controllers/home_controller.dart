import 'package:get/get.dart';
import '../models/tv_show.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final RxList<TvShow> shows = <TvShow>[].obs;
  final RxList<TvShow> filteredShows = <TvShow>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  Future<void> fetchShows() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await ApiService.fetchShows();
      shows.assignAll(result);
      filterShows(searchQuery.value);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void filterShows(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      filteredShows.assignAll(shows);
    } else {
      final q = query.toLowerCase();
      filteredShows.assignAll(
        shows.where((show) {
          final nameMatch = show.name.toLowerCase().contains(q);
          final genreMatch = show.genres.any((g) => g.toLowerCase().contains(q));
          return nameMatch || genreMatch;
        }).toList(),
      );
    }
  }
}
