import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../../utils/async_value_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  AsyncValue<List<Song>> _songs = AsyncValue.loading(); // init state is loading by default

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  List<Song> get songs => _songs.data ?? []; // if data is null, return an empty list
  AsyncValue<List<Song>> get songsAsync => _songs; // expose the async value to the UI
  
  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    try {
      // if the fetch is successful, update the state to success with the fetched songs
      _songs = AsyncValue.success(await songRepository.fetchSongs()); 
    } catch (e) {
      // if there is an error during fetch, update the state to error with the error message
      _songs = AsyncValue.error(e);
    }
      // 2 - notify listeners
      notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
