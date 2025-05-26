/* 
  Toda a parte do serviço da API do Gemini está aqui a baixo

  Caso queira rodar localmente, você precisa de uma chave de API e a URL do Gemini.

  Você consegue pegar esses dados aqui: https://aistudio.google.com/apikey

*/

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiGeminiServices {
  final Dio _dio = Dio();
  final String _geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  final String _geminiApiUrl = dotenv.env['GEMINI_API_URL'] ?? '';

  Future<String> generateText(String userPrompt) async {
    try {
        final response = await _dio.post(
        '$_geminiApiUrl?key=$_geminiApiKey',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "contents": [
            {
              "parts": [
                {"text": userPrompt}
              ]
            }
          ]
        },
      );

      final data = response.data;
      final responseContent = data['candidates'][0]['content']['parts'][0]['text'];
      return responseContent; 

    } catch (e) {
      print(e); 
      return 'Erro ao gerar texto: $e';
    }
  }
}