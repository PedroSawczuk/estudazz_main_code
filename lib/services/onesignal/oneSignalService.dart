import 'package:dio/dio.dart';
import 'package:estudazz_main_code/env.dart';

class OneSignalService {
  final Dio _dio = Dio();

  Future<void> sendPushNotification({
    required String destinatarioUid,
    required String titulo,
    required String mensagem,
  }) async {
    try {
      final String restApiKey = Env.oneSignalRestApiKey; 
      
      if (restApiKey.isEmpty || restApiKey == 'SuaChaveAqui') {
        print("Erro: A chave REST API do OneSignal não foi configurada no .env");
        return;
      }

      final response = await _dio.post(
        'https://onesignal.com/api/v1/notifications',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Basic $restApiKey',
          },
        ),
        data: {
          'app_id': Env.appIdOnesignalKey,
          'include_aliases': {
            'external_id': [destinatarioUid]
          },
          'target_channel': 'push',
          'headings': {'en': titulo, 'pt': titulo},
          'contents': {'en': mensagem, 'pt': mensagem},
        },
      );
      print('Notificação enviada via OneSignal REST: ${response.statusCode}');
    } catch (e) {
      print('Erro ao enviar push via OneSignal: $e');
    }
  }
}
