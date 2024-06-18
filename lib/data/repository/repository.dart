
import 'package:flutter_assignment/data/models/location_response.dart';

import '../api/api_service.dart';

class Repository {

  final ApiService apiService;

  Repository({required this.apiService});

  Future<LocationResponse> getData() async {
    final response = await apiService.getData();
    return LocationResponse.fromJson(response);
  }
}
