import 'package:atma_cinema/components/list_search_component.dart';
import 'package:atma_cinema/providers/movie_provider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchView extends ConsumerStatefulWidget {
  final bool? isClickVoice;
  const SearchView({super.key, this.isClickVoice = false});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  late AnimationController _dotsAnimationController;
  double _soundLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _dotsAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat();
    if (widget.isClickVoice!) {
      _isListening = true;
      _startListening();
    }
  }

  @override
  void dispose() {
    _dotsAnimationController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    ref.read(querySearchProvider.notifier).state = query;
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print('onStatus: $status');
        if (status == 'notListening') {
          _stopListening();
        }
      },
      onError: (error) => print('onError: $error'),
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _searchController.text = result.recognizedWords;
          });

          if (result.finalResult) {
            _stopListening();
          }
        },
        onSoundLevelChange: (level) {
          setState(() {
            _soundLevel = level.clamp(1.0, 5.0);
          });
        },
        localeId: "id_ID",
        listenFor: Duration(minutes: 1),
        pauseFor: Duration(seconds: 3),
      );
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _searchController,
                      maxLines: 1,
                      scrollPhysics: BouncingScrollPhysics(),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      scrollPadding: EdgeInsets.all(8.0),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: colorPrimary.withOpacity(0.3),
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        suffixIcon: GestureDetector(
                          onTap:
                              _isListening ? _stopListening : _startListening,
                          child: Icon(
                            _isListening ? Icons.mic_off : Icons.mic,
                            color: Colors.grey,
                          ),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onChanged: (query) {
                        _performSearch(query);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 4.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Recent searches",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListItemSearch(),
              ],
            ),
          ),
        ),
        if (_isListening)
          AnimatedOpacity(
            opacity: _isListening ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              color: Colors.white.withOpacity(0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Listening',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _dotsAnimationController,
                        builder: (context, child) {
                          int dotCount =
                              (_dotsAnimationController.value * 3).floor() + 1;
                          return Text(
                            '.' * dotCount,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: 80 +
                        (_soundLevel * 10), // Ukuran berubah sesuai level suara
                    height: 80 + (_soundLevel * 10),
                    decoration: BoxDecoration(
                      color: Color(0xff001F3F),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      _isListening ? Icons.graphic_eq : Icons.mic,
                      color: const Color.fromARGB(255, 237, 218, 161),
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
