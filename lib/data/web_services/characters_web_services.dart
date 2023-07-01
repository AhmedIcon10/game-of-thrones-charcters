import 'package:breaking_bad/constants/string.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(
        seconds: 20,
      ),
      connectTimeout: const Duration(
        seconds: 20,
      ),
    );
    dio = Dio(options);
  }

   Future getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data.toString());
      dynamic data = response.data;
      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
