import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tv_show.dart';
import '../services/storage_service.dart';

class FavoriteController extends GetxController {
  final RxList<TvShow> favorites = <TvShow>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    isLoading.value = true;
    try {
      final list = StorageService.getFavorites();
      favorites.assignAll(list);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavorite(TvShow show) async {
    await StorageService.removeFavorite(show.id);
    favorites.removeWhere((item) => item.id == show.id);

    Get.snackbar(
      'Dihapus',
      '${show.name} dihapus dari daftar favorit.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey.shade900,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      mainButton: TextButton(
        onPressed: () async {
          await StorageService.addFavorite(show);
          loadFavorites();
          if (Get.isSnackbarOpen) Get.back();
        },
        child: const Text('BATALKAN', style: TextStyle(color: Colors.amber)),
      ),
    );
  }
}
