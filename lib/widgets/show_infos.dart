import 'package:digital_paca_test/models/show.dart';
import 'package:digital_paca_test/widgets/Favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShowInfos extends StatelessWidget {
  const ShowInfos({
    super.key,
    required this.show,
  });

  final Show show;

  @override
  Widget build(BuildContext context) {
    TextStyle infosStyle = GoogleFonts.roboto(
      color: const Color(0xFFBDBDBD),
      fontSize: 14,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                show.title,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FavoriteIcon(show: show),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Ratings(rate: show.rate),
            const SizedBox(width: 24),
            Container(
              height: 110,
              width: 2,
              color: Colors.white,
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(show.director, style: infosStyle),
                const SizedBox(height: 8),
                Text(show.year, style: infosStyle),
                const SizedBox(height: 8),
                Text(show.type, style: infosStyle),
                const SizedBox(height: 8),
                Text('${show.duration} min', style: infosStyle),
              ],
            )
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Synopsis :',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              show.description,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Ratings extends StatelessWidget {
  const Ratings({super.key, required this.rate});

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 35,
          lineWidth: 6,
          percent: rate / 100,
          backgroundColor: Colors.white.withOpacity(0.1),
          progressColor: const Color(0xFF3FC25C),
          center: Text(
            '$rate%',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Note du public',
          style: GoogleFonts.roboto(
            color: const Color(0xFFBDBDBD),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
