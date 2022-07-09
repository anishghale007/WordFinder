import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordfinder/model/Definition.dart';

final definitionProvider =
    StateNotifierProvider<DefinitionProvider, List<Definition>>(
        (ref) => DefinitionProvider([]));

class DefinitionProvider extends StateNotifier<List<Definition>> {
  DefinitionProvider(List<Definition> state) : super(state);

  Future<void> searchWord({required String query}) async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://owlbot.info/api/v4/dictionary/$query',
          options: Options(headers: {
            'Authorization': 'Token 91e661e4361c79c945ae14ba343f6df0b8c7d22c'
          }));
      final data = (response.data['definitions'] as List)
          .map((e) => Definition.fromJson(e))
          .toList();
      state = data;
    } on DioError catch (err) {
      print(err.response);
    }
  }
}
