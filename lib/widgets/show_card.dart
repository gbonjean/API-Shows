import 'package:digital_paca_test/models/show.dart';
import 'package:digital_paca_test/screens/details.dart';
import 'package:digital_paca_test/widgets/favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowCard extends ConsumerWidget {
  const ShowCard({super.key, required this.show});

  final Show show;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ShowDetails(show))),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(children: [
          Row(
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: show.thumbUrl,
                height: 150,
                width: 100,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        show.title,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        show.year,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: const Color(0xFFBDBDBD),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        show.description,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: FavoriteIcon(show: show),
          ),
        ]),
      ),
    );
  }
}