import 'package:atma_cinema/components/carousel_component.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/services.dart';

class FnbView extends StatefulWidget {
  const FnbView({super.key});

  @override
  State<FnbView> createState() => _FnbViewState();
}

class _FnbViewState extends State<FnbView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(top: 45, bottom: 20),
          child: Text(
            'Today\'s Offers',
            style: styleHeade2,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          CarouselWithIndicator(
            images: [
              "images/fnb/FnB_Promo1.jpg",
              "images/fnb/FnB_Promo2.jpg",
              "images/fnb/FnB_Promo3.jpg",
            ],
            heightCarousel: 180,
            viewportFractionCarousel: 0.8,
            ratioCarousel: 16 / 9,
            autoPlayCarousel: true,
            enableInfiniteScrollCarousel: true,
            enlargeCarousel: false,
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(86, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text(
                      'Combo',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(86, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text(
                      'Popcorn',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(86, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text(
                      'Drinks',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(86, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text(
                      'Light Meal',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.transparent,
            elevation: 0,
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Popcorn',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Krenyes krenyes enak mantul',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Rp. 25.000',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Image.asset(
                    'images/fnb/FnB_Food1.jpg',
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: colorBorder,
            thickness: 1,
          ),
          Card(
            color: Colors.transparent,
            elevation: 0,
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Burger',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Rotinya keras tapi pattynya lembut',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Rp. 40.000',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Image.asset(
                    'images/fnb/FnB_Food2.jpg',
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
