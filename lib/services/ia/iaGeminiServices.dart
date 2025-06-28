/* 
  Toda a parte do serviço da API do Gemini está aqui a baixo

  Caso queira rodar localmente, você precisa de uma chave de API e a URL do Gemini.

  Você consegue pegar esses dados aqui: https://aistudio.google.com/apikey

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiGeminiServices {
  final Dio _dio = Dio();
  final String _geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  final String _geminiApiUrl = dotenv.env['GEMINI_API_URL'] ?? '';

  Future<String> generateText(String userPrompt) async {
    try {
      final uid = await GetUserData.getUserUid();

      if (uid == null) return 'Usuário não está autenticado';

      String userData = '';

      final snapshot =
          await FirebaseFirestore.instance.collection('ia-data').doc(uid).get();

      if (snapshot.exists && snapshot.data()?['data'] != null) {
        userData = snapshot.data()?['data'];
      }

      final prompt = '''
        Olá, você é um assistente de IA especializado em ajudar alunos com dúvidas e tarefas da escola/universidade.
        Você deve responder de forma clara, objetiva e amigável. Sempre que possível, forneça exemplos práticos e explique os conceitos de maneira simples.

        ${userData.isNotEmpty ? "Informações adicionais do usuário: $userData\n" : ""}

        Aqui está a dúvida do usuário: $userPrompt
      ''';

      final response = await _dio.post(
        '$_geminiApiUrl?key=$_geminiApiKey',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        },
      );

      final data = response.data;
      final responseContent =
          data['candidates'][0]['content']['parts'][0]['text'];
      return responseContent;
    } catch (e) {
      print(e);
      return 'Erro ao gerar texto: $e';
    }
  }
}
