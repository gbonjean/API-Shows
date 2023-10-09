import 'package:digital_paca_test/models/show.dart';
import 'package:digital_paca_test/providers/shows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class FavoriteIcon extends ConsumerStatefulWidget {
  const FavoriteIcon({
    super.key,
    required this.show,
  });

  final Show show;

    @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends ConsumerState<FavoriteIcon> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ref.read(showsProvider.notifier).toggleFavorite(widget.show);
        setState(() {});
      },
      icon: Image.asset(
        widget.show.isFavorite
            ? 'assets/icons/star.png'
            : 'assets/icons/star-outline.png',
        color: widget.show.isFavorite
            ? const Color(0xFFF2C94C)
            : const Color(0xFFBDBDBD),
        width: 28,
      ),
    );
  }
}