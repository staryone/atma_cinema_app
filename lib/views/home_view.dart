import 'package:atma_cinema/components/carousel_blur_component.dart';
import 'package:atma_cinema/components/carousel_component.dart';
import 'package:atma_cinema/components/input_component.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/auth/login_view.dart';
import 'package:atma_cinema/views/profile/profile_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final Map data;
  const HomeView({super.key, required this.data});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: colorPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                          color: colorPrimary.withOpacity(0.3), height: 1.45),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      suffixIcon: Icon(Icons.mic),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProfileView(data: widget.data),
                  ),
                ),
                icon: const Icon(Icons.account_circle),
                iconSize: 30,
                padding: EdgeInsets.only(left: 10),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Row(
              children: [],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17),
              child: Text(
                'Hello, ' + widget.data['fullname'],
                style: styleHeader,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 19),
              child: Text(
                'Now Showing ',
                style: styleBold2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarouselBlurWithIndicator(images: [
              "https://i.pinimg.com/564x/a4/9d/c8/a49dc85d98d25389f9d939bbd8663e43.jpg",
              "https://i.pinimg.com/736x/2a/02/14/2a021436434b66ad17e42a658ca3445b.jpg",
              "https://i.pinimg.com/564x/00/69/a9/0069a94894154027cf0c748537161b42.jpg",
            ]),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 19),
              child: Text(
                'Promo ',
                style: styleBold2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarouselWithIndicator(
              images: [
                "https://i.pinimg.com/564x/a4/9d/c8/a49dc85d98d25389f9d939bbd8663e43.jpg",
                "https://i.pinimg.com/736x/2a/02/14/2a021436434b66ad17e42a658ca3445b.jpg",
                "https://i.pinimg.com/564x/00/69/a9/0069a94894154027cf0c748537161b42.jpg",
                "https://i.pinimg.com/736x/41/92/ab/4192ab954554d613ee2be19e28fa1e36.jpg",
                "https://i.pinimg.com/564x/ce/84/7c/ce847c625deb6e90bf0e5d0f4687bd3a.jpg",
              ],
              heightCarousel: 120,
              enlargeCarousel: false,
              autoPlayCarousel: true,
              ratioCarousel: 16 / 9,
              enableInfiniteScrollCarousel: true,
              viewportFractionCarousel: 0.8,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 19),
              child: Text(
                'Upcoming ',
                style: styleBold2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarouselWithIndicator(
              images: [
                "https://i.pinimg.com/564x/a4/9d/c8/a49dc85d98d25389f9d939bbd8663e43.jpg",
                "https://i.pinimg.com/736x/2a/02/14/2a021436434b66ad17e42a658ca3445b.jpg",
                "https://i.pinimg.com/564x/00/69/a9/0069a94894154027cf0c748537161b42.jpg",
                "https://i.pinimg.com/736x/41/92/ab/4192ab954554d613ee2be19e28fa1e36.jpg",
                "https://i.pinimg.com/564x/ce/84/7c/ce847c625deb6e90bf0e5d0f4687bd3a.jpg",
              ],
              heightCarousel: 240,
              enlargeCarousel: false,
              autoPlayCarousel: false,
              ratioCarousel: 3 / 4,
              enableInfiniteScrollCarousel: true,
              viewportFractionCarousel: 0.47,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
