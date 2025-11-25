import 'package:flutter_test/flutter_test.dart';
import 'package:estudazz_main_code/utils/validators/TextFieldValidator.dart';

void main() {
  group('TextFieldValidator', () {
    const String requiredMessage = 'Campo obrigatório';

    test('deve retornar a mensagem de obrigatório para valor nulo', () {
      expect(textFieldValidator(null, requiredMessage), requiredMessage);
    });

    test('deve retornar a mensagem de obrigatório para valor vazio', () {
      expect(textFieldValidator('', requiredMessage), requiredMessage);
    });

    test('deve retornar a mensagem de obrigatório para valor com apenas espaços', () {
      expect(textFieldValidator('   ', requiredMessage), requiredMessage);
    });

    test('deve retornar a mensagem de mínimo de 3 caracteres', () {
      expect(textFieldValidator('ab', requiredMessage), 'O campo deve ter pelo menos 3 caracteres');
    });

    test('deve retornar nulo para um valor válido com 3 caracteres', () {
      expect(textFieldValidator('abc', requiredMessage), null);
    });

    test('deve retornar nulo para um valor válido e maior que 3 caracteres', () {
      expect(textFieldValidator('valor válido', requiredMessage), null);
    });
  });
}
