import 'dart:math';

String randomString([int seed]) {
  final rng = Random(128 * (32 + seed ?? DateTime.now().microsecond * 250));
  final size = 5 + rng.nextInt(13);
  String text = String.fromCharCode(65 + rng.nextInt(25));
  for (var i = 1; i < size; i++) {
    text += String.fromCharCode(97 + rng.nextInt(25));
  }
  return text;
}
