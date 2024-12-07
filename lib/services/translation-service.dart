import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class TranslationService {
  static const String baseUrl = 'https://libretranslate.com/translate';
  final String defaultLocale = Platform.localeName;

  Future<String> translate({
    required String text,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'source': "auto",
          'target': defaultLocale,
          'form': "text",
          'alternatives': 0,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['translatedText'];
      } else {
        throw Exception('Failed to translate text');
      }
    } catch (e) {
      throw Exception('Error connecting to translation service: $e');
    }
  }
}
