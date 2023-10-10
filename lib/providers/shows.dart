import 'package:digital_paca_test/services/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digital_paca_test/models/show.dart';

final showsProvider =
    AsyncNotifierProvider<ShowsNotifier, List<Show>>(() => ShowsNotifier());

class ShowsNotifier extends AsyncNotifier<List<Show>> {
  @override
  Future<List<Show>> build() async {
    return await apiService.getShows();
  }

  void toggleFavorite(Show show) {
    final temp = state.value;
    if (temp == null) return;
    final index = temp.indexOf(show);
    if (index == -1) return;
    temp[index].isFavorite = !temp[index].isFavorite;
    state = AsyncData(temp);
  }
}

final showFavoritesProvider = StateProvider<bool>((ref) => false);

final searchProvider = StateProvider<String>((ref) => '');

final filteredShowsProvider = Provider<List<Show>>((ref) {
  final search = ref.watch(searchProvider);
  final isShowingFavorites = ref.watch(showFavoritesProvider);
  final shows = ref.watch(showsProvider);
  if (shows is AsyncData<List<Show>>) {
    return shows.value
        .where((show) =>
            show.title.toLowerCase().contains(search.toLowerCase()) &&
            (!isShowingFavorites || show.isFavorite))
        .toList();
  }
  return [];
});
