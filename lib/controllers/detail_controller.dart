import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tv_show.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class DetailController extends GetxController {
  final Rx<TvShow?> show = Rx<TvShow?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isFav = false.obs;

  int? showId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is int) {
      showId = args;
      fetchDetail(args);
    } else if (args is TvShow) {
      show.value = args;
      showId = args.id;
      isFav.value = StorageService.isFavorite(args.id);
      fetchDetail(args.id);
    }
  }

  Future<void> fetchDetail(int id) async {
    isLoading.value = show.value == null;
    errorMessage.value = '';
    try {
      final detail = await ApiService.fetchShowDetail(id);
      show.value = detail;
      isFav.value = StorageService.isFavorite(id);
    } catch (e) {
      if (show.value == null) {
        errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    final currentShow = show.value;
    if (currentShow == null) return;

    final newState = await StorageService.toggleFavorite(currentShow);
    isFav.value = newState;

    Get.snackbar(
      newState ? 'Ditambahkan ke Favorit' : 'Dihapus dari Favorit',
      newState
          ? '${currentShow.name} berhasil disimpan di daftar favorit.'
          : '${currentShow.name} telah dihapus dari daftar favorit.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: newState ? Colors.green.shade800 : Colors.grey.shade900,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      icon: Icon(
        newState ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        color: newState ? Colors.redAccent : Colors.white70,
      ),
    );
  }
}
