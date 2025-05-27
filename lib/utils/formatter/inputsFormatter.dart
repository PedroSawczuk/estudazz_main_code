/* 
  Junto com a lib 'mask_text_input_formatter', criei um formatador para a data de nascimento e para data prevista para conclusão do curso que o usuário adicionar
  para ter uma padronização nos dados! 
*/

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final birthDateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

final graduationDateFormatter = MaskTextInputFormatter(
  mask: '##/####',
  filter: {"#": RegExp(r'[0-9]')},
);

final usernameFormatter = MaskTextInputFormatter(
  mask: '@@@@@@@@@@@@',
  filter: {"@": RegExp(r'[a-z0-9_.]')},
);

final nameFormatter = MaskTextInputFormatter(
  mask: '##############################',
  filter: {"#": RegExp(r'[a-zA-ZÀ-ÿ ]')},
);
