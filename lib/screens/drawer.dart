import 'package:digital_paca_test/providers/shows.dart';
import 'package:digital_paca_test/services/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isShowingFavorites = ref.watch(isShowingFavoritesProvider);

    return Drawer(
      backgroundColor: const Color(0xFF03A9F4),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Menu',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.roboto(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Image.asset(
                    'assets/icons/close.png',
                    color: Colors.white,
                    width: 28,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
              tileColor: isShowingFavorites ? null : const Color(0xFF143D52),
              contentPadding: const EdgeInsets.only(left: 48),
              leading: Image.asset(
                'assets/icons/home.png',
                height: 28,
                color: isShowingFavorites ? Colors.black : Colors.white,
              ),
              title: Text(
                'Home',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                ref.read(isShowingFavoritesProvider.notifier).change(false);
                Navigator.of(context).popUntil(ModalRoute.withName('/home'));
              }),
          ListTile(
            tileColor: isShowingFavorites ? const Color(0xFF143D52) : null,
            contentPadding: const EdgeInsets.only(left: 48),
            leading: Image.asset(
              'assets/icons/star-outline.png',
              height: 32,
              color: isShowingFavorites ? Colors.white : Colors.black,
            ),
            title: Text(
              'Favoris',
              style: GoogleFonts.roboto(
                fontSize: 24,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              ref.read(isShowingFavoritesProvider.notifier).change(true);
              Navigator.of(context).popUntil(ModalRoute.withName('/home'));
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 48),
            leading: Image.asset('assets/icons/mail-reply.png', height: 32),
            title: Text(
              'Déconnexion',
              style: GoogleFonts.roboto(
                fontSize: 24,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              apiService.logout();
              ref.read(isShowingFavoritesProvider.notifier).change(false);
              Navigator.of(context).popUntil(ModalRoute.withName('/home'));
            },
          )
        ],
      ),
    );
  }
}
