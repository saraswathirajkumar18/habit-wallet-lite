class ApiClient {
  Future<void> post(String endpoint, Map<String, dynamic> body) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<Map<String, dynamic>>> get(String endpoint) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }
}
