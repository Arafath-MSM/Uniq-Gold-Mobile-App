class Env {
  Env._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://uniqgold.store',
  );
}
