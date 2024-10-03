import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:atma_cinema/utils/constants.dart';


class FnbView extends StatefulWidget {
  const FnbView({super.key});

  @override
  State<FnbView> createState() => _FnbViewState();
}

class _FnbViewState extends State<FnbView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
            child: Text(
              "Promo Hari Ini",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
              textAlign: TextAlign.left,
            ),
          ),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("images/fnb/FnB_Promo1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //2nd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("images/fnb/FnB_Promo2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //3rd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("images/fnb/FnB_Promo3.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //4th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("images/fnb/FnB_Promo1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //5th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("images/fnb/FnB_Promo2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: false,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
          ),

          //Category
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0), // Padding for each button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(100, 48.9),
                      side: BorderSide(color: colorBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text('Combo'),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0), // Padding for each button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(100, 48.9),
                      side: BorderSide(color: colorBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text('Popcorn'),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0), // Padding for each button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(100, 48.9),
                      side: BorderSide(color: colorBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text('Drinks'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0), // Padding for each button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(100, 48.9),
                      side: BorderSide(color: colorBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      textStyle: styleBold,
                    ),
                    child: Text('Light Meal'),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              ],
            ),
          ),

          Card(
            elevation: 4.0,
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

          Card(
            elevation: 4.0,
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