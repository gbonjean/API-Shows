import 'package:digital_paca_test/providers/shows.dart';
import 'package:digital_paca_test/screens/drawer.dart';
import 'package:digital_paca_test/widgets/hamburger.dart';
import 'package:digital_paca_test/widgets/show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allShows = ref.watch(showsProvider);
    return Scaffold(
        drawer: const AppDrawer(),
        body: allShows.when(
          data: (_) {
            final shows = ref.watch(filteredShowsProvider);
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 8),
                const Row(children: [Hamburger()]),
                const SizedBox(height: 12),
                const Search(),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: shows.length,
                    itemBuilder: (context, index) {
                      final show = shows[index];
                      return ShowCard(
                        show: show,
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, _) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF03A9F4)
            ),
          ),
        ));
  }
}

class Search extends ConsumerWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: (value) {
          ref.read(searchProvider.notifier).update((state) => state = value);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Rechercher',
          hintStyle: GoogleFonts.roboto(
            color: const Color(0xFFBDBDBD),
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
