import 'package:dio/dio.dart';
import 'package:dog_dashboard/contants.dart';
import 'package:dog_dashboard/models/dog_breed.dart';
import 'package:dog_dashboard/models/view_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final breedsProvider = FutureProvider<List<DogBreed>>(
  (ref) async {
    final dio = Dio();

    try {
      // Make a GET request to your REST API
      final response = await dio.get('$apiUrl/breeds/list/all');
      if (response.statusCode == 200) {
        return DogBreed.parseJson(response.data);
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      throw Exception('Failed to load data from the API: $error');
    }
  },
);

class FetchImageData {
  final String? breed;
  final String? subBreed;
  final ViewMode? viewMode;

  FetchImageData({this.breed, this.subBreed, this.viewMode = ViewMode.single});
}

final fetchImageDataProvider = StateProvider<FetchImageData>(
  (ref) => FetchImageData(),
);

final randomBreedImageProvider = FutureProvider<List<String>?>(
  (ref) async {
    final imageData = ref.watch(fetchImageDataProvider);

    if (imageData.viewMode == null || imageData.breed == null) {
      return null;
    }

    final dio = Dio();

    if (imageData.viewMode == ViewMode.single) {
      try {
        String url = '$apiUrl/breed/${imageData.breed}/';
        if (imageData.subBreed != null) {
          url += '${imageData.subBreed}/';
        }
        url += 'images/random';
        final response = await dio.get(url);
        if (response.statusCode == 200) {
          return List<String>.from([response.data['message']]);
        } else {
          throw Exception('Failed to load data from the API');
        }
      } catch (error) {
        rethrow;
      }
    }

    try {
      String url = '$apiUrl/breed/${imageData.breed}/';
      if (imageData.subBreed != null) {
        url += '${imageData.subBreed}/';
      }
      url += 'images';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final List<String> images = List<String>.from(response.data['message']);
        return images;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      rethrow;
    }
  },
);
