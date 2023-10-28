import 'package:dio/dio.dart';
import 'package:dog_dashboard/contants.dart';
import 'package:dog_dashboard/models/dog_breed.dart';
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
