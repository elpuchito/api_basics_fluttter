// import 'package:test/test.dart';
// import 'package:http/http.dart' as http;

// import 'package:api_basics/main.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'fetchAlbum_test.mocks.dart';

// // Generate a MockClient using the Mockito package.
// // Create new instances of this class in each test.
// @GenerateMocks([http.Client])
// void main() {
//   group('fetchAlbum', () {
//     test('returns a jsonMap if the response is succesful', () async {
//       final client = new MockClient();

//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async =>
//               http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
//       expect(await fetchAlbum(client), isA<dynamic>());
//     });
//     test('throws an exception if the http call completes with an error', () {
//       final client = MockClient();

//       // Use Mockito to return an unsuccessful response when it calls the
//       // provided http.Client.
//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));

//       expect(fetchAlbum(client), throwsException);
//     });
//   });
// }
