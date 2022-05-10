import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider_test/api/api_controller.dart';
import 'package:provider_test/entities/api_login_response.dart';
import 'package:provider_test/entities/api_response.dart';
import 'package:provider_test/entities/api_response_power.dart';

class ApiService {
  Future<ApiLoginResponse?> sendLoginRequest(
      String username, String password) async {
    var request =
        http.Request('POST', Uri.parse(ApiController.BASE_URL + 'login'));
    request.bodyFields = {'username': username, 'password': password};
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var bytesToString = await response.stream.bytesToString();
      var apiResponse = ApiLoginResponse.fromJson(jsonDecode(bytesToString));
      return apiResponse;
    } else {
      return null;
    }
  }

  Future<ApiResponse?> getPowerTypes() async {
    var headers = {'Authorization': 'Bearer ' + ApiController.jwt};
    var request = http.Request(
        'GET',
        Uri.parse(ApiController.BASE_URL +
            'rest/loggers/' +
            ApiController.SELECTED_LOGGER +
            "/powerTypes"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var bytesToString = await response.stream.bytesToString();
      var apiResponse = ApiResponse.fromJson(jsonDecode(bytesToString));
      return apiResponse;
    } else {
      return null;
    }
  }

  Future<ApiResponsePower?> getPowerList(
      String startDate, String endDate, int currentPage, int perPage) async {
    var headers = {'Authorization': 'Bearer ' + ApiController.jwt};
    var request = http.Request(
        'GET',
        Uri.parse(ApiController.BASE_URL +
            'rest/loggers/' +
            ApiController.SELECTED_LOGGER +
            "/powers?startDate=" +
            startDate +
            "&endDate=" +
            endDate +
            "&currentPage=" +
            currentPage.toString() +
            "&perPage=" +
            perPage.toString()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var bytesToString = await response.stream.bytesToString();
      var apiResponse = ApiResponsePower.fromJson(jsonDecode(bytesToString));
      return apiResponse;
    } else {
      return null;
    }
  }
}
