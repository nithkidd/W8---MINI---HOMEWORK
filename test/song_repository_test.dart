import 'package:advanced_flutter/W8HW/W8---MINI---HOMEWORK/data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  final repo = SongRepositoryMock();
  // Test both the success and the failure of the post request
  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  repo.fetchSongs()
      .then((songs) {
        print("Success: $songs");
      })
      .catchError((error) {
        print("Error: $error");
      });

  // - Using async/await with try/catch.
  try {
    final songs = await repo.fetchSongs();
    print("Success: $songs");
  } catch (e) {
    print("Error: $e");
  }
}
