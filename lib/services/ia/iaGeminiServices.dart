/* 
  Toda a parte do serviço da API do Gemini está aqui a baixo

  Caso queira rodar localmente, você precisa de uma chave de API e a URL do Gemini.

  Você consegue pegar esses dados aqui: https://aistudio.google.com/apikey
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:estudazz_main_code/env.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';

class AiGeminiServices {
  final Dio _dio = Dio();
  final String _geminiApiKey = Env.geminiApiKey;
  final String _geminiApiUrl = Env.geminiApiUrl;

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
        _geminiApiUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': _geminiApiKey,
        }),
        data: {
          "model": "gemini-3.6-flash",
          "input": prompt,
        },
      );

      final data = response.data;
      String responseContent = '';
      
      if (data['steps'] != null) {
        final steps = data['steps'] as List;
        for (var step in steps) {
          if (step['type'] == 'model_output' && step['content'] != null) {
            responseContent = step['content'][0]['text'] ?? '';
            break;
          }
        }
      }

      if (responseContent.isEmpty) {
        responseContent = 'A IA processou a requisição, mas não retornou um texto legível.';
      }

      return responseContent;
    } on DioException catch (e) {
      String erroDetalhado = 'Erro na API';
      if (e.response != null && e.response?.data != null) {
        erroDetalhado = e.response?.data.toString() ?? 'Erro desconhecido';
      }
      return 'Erro na requisição: ${e.message}\nDetalhes da Google: $erroDetalhado';
    } catch (e) {
      print(e);
      return 'Erro inesperado: $e';
    }
  }
}
