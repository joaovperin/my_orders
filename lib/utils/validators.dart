///
/// Texto obrigatório
///
String textNotEmpty(String value, {message = 'O campo é obrigatório'}) {
  return value.isEmpty ? message : null;
}

///
/// Texto com tamanho mínimo
///
String textMinSize(String value, {size: 5, message}) {
  message ??= 'Informe pelo menos $size carácteres';
  return textNotEmpty(
        value,
        message: message,
      ) ??
      (value.length < size ? message : null);
}
