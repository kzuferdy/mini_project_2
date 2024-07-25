import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as httpClient;

class ProfileService {
  final http.Client client;
  final String profileUrl = 'https://fakestoreapi.com/users/1';

  ProfileService(this.client);

  Future<String> fetchProfile() async {
    try {
      final response = await client.get(Uri.parse(profileUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}

void main() {
  group('ProfileService', () {
    test('fetchProfile returns profile data when the http call completes successfully', () async {
      // Arrange
      final client = MockClient((request) async {
        return http.Response('{"name": "John Doe"}', 200);
      });
      final profileService = ProfileService(client);

      // Act
      final result = await profileService.fetchProfile();

      // Assert
      expect(result, '{"name": "John Doe"}');
    });

    test('fetchProfile throws an exception when the http call completes with an error', () async {
      // Arrange
      final client = MockClient((request) async {
        return http.Response('Not Found', 404);
      });
      final profileService = ProfileService(client);

      // Act & Assert
      expect(() => profileService.fetchProfile(), throwsException);
    });
  });
}
