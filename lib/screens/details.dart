import 'package:digital_paca_test/models/show.dart';
import 'package:digital_paca_test/screens/drawer.dart';
import 'package:digital_paca_test/widgets/show_infos.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails(this.show, {super.key});

  final Show show;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Column(
        children: [
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: show.bannerUrl,
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: -2,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF143D52)],
                  // stops: [0.5, 0.9],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Image.asset(
                  'assets/icons/menu.png',
                  color: Colors.white,
                  height: 28,
                ),
              );
            }),
          ),
        ],
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF143D52),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ShowInfos(show: show),
          ),
        ),
      ),
        ],
      ),
    );
  }
}


