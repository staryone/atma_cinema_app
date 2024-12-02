import 'package:atma_cinema/components/carousel_now_showing_movies__component.dart';
import 'package:atma_cinema/components/carousel_component.dart';
import 'package:atma_cinema/components/carousel_upcoming_movie_component.dart';
import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/providers/movie_provider.dart';
import 'package:atma_cinema/providers/user_provider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/detail_promo_view.dart';
import 'package:atma_cinema/views/nowshowing_view.dart';
import 'package:atma_cinema/views/profile/profile_view.dart';
import 'package:atma_cinema/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  Future<void> _refreshData() async {
    ref.invalidate(moviesFetchNowShowingProvider);
    ref.invalidate(moviesFetchUpcomingProvider);
    ref.invalidate(userFetchDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userFetchDataProvider);
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SearchView(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              'Search...',
                              style: TextStyle(
                                fontSize: 15,
                                color: colorPrimary.withOpacity(0.3),
                                height: 1.45,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SearchView(isClickVoice: true),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  transitionDuration:
                                      Duration(milliseconds: 300),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.mic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              userAsyncValue.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfileView(),
                      ),
                    ),
                    icon: const Icon(Icons.account_circle),
                    iconSize: 30,
                    padding: EdgeInsets.only(left: 10),
                  ),
                ),
                data: (user) => IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProfileView(),
                    ),
                  ),
                  icon: (user.profilePicture != null)
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(user.profilePicture!),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        )
                      : const Icon(Icons.account_circle),
                  iconSize: 30,
                  padding: EdgeInsets.only(left: 10),
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
              Row(
                children: [],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 17),
                child: userAsyncValue.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Text(
                      'Failed to load fullName',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  data: (user) => Text(
                    'Hello, ' + user.fullName,
                    style: styleHeader,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 19),
                    child: Text(
                      'Now Showing ',
                      style: styleBold2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onSeeAllTap(context),
                    child: Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text(
                        'See All ',
                        style: styleBold3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CarouselNowShowingMovies(),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPromoView(
                        promoImageUrl:
                            "https://i.pinimg.com/564x/a4/9d/c8/a49dc85d98d25389f9d939bbd8663e43.jpg",
                      ),
                    ),
                  );
                },
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
              CarouselUpcomingMovies(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSeeAllTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NowShowingView(),
      ),
    );
  }
}
