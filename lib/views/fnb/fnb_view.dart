import 'package:atma_cinema/components/carousel_promo_component.dart';
import 'package:atma_cinema/models/fnb_model.dart';
import 'package:atma_cinema/providers/fnb_provider.dart';
import 'package:atma_cinema/providers/promo_provider.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FnbView extends ConsumerStatefulWidget {
  const FnbView({super.key});

  @override
  ConsumerState<FnbView> createState() => _FnbViewState();
}

class _FnbViewState extends ConsumerState<FnbView> {
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
          CarouselPromo(
            provider: promosFetchFnbProvider,
            heightCarousel: 160,
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
                _buildCategoryButton('Combo'),
                _buildCategoryButton('Popcorn'),
                _buildCategoryButton('Drinks'),
                _buildCategoryButton('Light Meal'),
              ],
            ),
          ),
          SingleChildScrollView(
            child: ref.watch(fnbsFetchFnbProvider).when(
                  data: (fnbs) => Column(
                    children: fnbs.map((fnb) => _buildFnbCard(fnb)).toList(),
                  ),
                  loading: () => _buildSkeletonPlaceholder(),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        onPressed: () {
          ref.read(selectedCategoryProvider.notifier).state = category;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedCategory == category ? colorGold : colorPrimary,
          foregroundColor:
              selectedCategory == category ? colorPrimary : Colors.white,
          minimumSize: Size(86, 34),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: styleBold,
        ),
        child: Text(
          category,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildFnbCard(FnbModel fnb) {
    return Column(
      children: [
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
                        fnb.name,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        fnb.description ?? ' ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Rp. ${fnb.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          fnb.pathImage ?? 'https://via.placeholder.com/120'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey[100],
          thickness: 6,
          height: 0,
        ),
      ],
    );
  }

  Widget _buildSkeletonPlaceholder() {
    return Skeletonizer(
      ignoreContainers: true,
      enabled: true,
      child: Column(
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: 200,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: 100.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
