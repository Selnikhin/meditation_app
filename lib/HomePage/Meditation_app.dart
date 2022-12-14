import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Meditation_screen extends StatefulWidget {
  const Meditation_screen({super.key});

  @override
  State<Meditation_screen> createState() => _Meditation_screenState();
}

class _Meditation_screenState extends State<Meditation_screen> {
  final List<Item> items = [
    Item(
        audioPath: 'assets/audios/sunset.mp3',
        imagePath: 'assets/images/beautiful-sunset-1920.jpg',
        name: 'Перед расветом'),
    Item(
        audioPath: 'assets/audios/for_sleep.mp3',
        imagePath: 'assets/images/dream-1920.jpg',
        name: 'Для сна'),
    Item(
        audioPath: 'assets/audios/flame.mp3',
        imagePath: 'assets/images/flame-1920.jpg',
        name: 'Тело огня'),
    Item(
        audioPath: 'assets/audios/forest.mp3',
        imagePath: 'assets/images/forest-1920.jpg',
        name: 'Лесная Симфония'),
    Item(
        audioPath: 'assets/audios/meditation.mp3',
        imagePath: 'assets/images/meditation-gb98aca8b0_1920.jpg',
        name: 'Для медитации'),
    Item(
        audioPath: 'assets/audios/night.mp3',
        imagePath: 'assets/images/Night-1920.jpg',
        name: 'Ночьная сиринада'),
    Item(
        audioPath: 'assets/audios/river.mp3',
        imagePath: 'assets/images/river2.jpeg',
        name: 'У реки'),
    Item(
        audioPath: 'assets/audios/little_river.mp3',
        imagePath: 'assets/images/river-1920.jpg',
        name: 'Журчание ручья'),
  ];
  final AudioPlayer audioPlayer = AudioPlayer();
  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 500,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(items[index].imagePath),
                        ),
                      ),
                      height: 150,
                      child: ListTile(
                        title: Text(
                          items[index].name,
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        leading: IconButton(
                          icon: playingIndex == index
                              ? FaIcon(FontAwesomeIcons.stop)
                              : FaIcon(FontAwesomeIcons.play),
                          onPressed: ()async {
                            if (playingIndex == index) {
                              setState(() {
                                playingIndex = null;
                              });
                              audioPlayer.stop();
                            } else {
                              try {
                                 await audioPlayer
                                    .setAsset(items[index].audioPath)
                                    .catchError((onError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.deepOrange.withOpacity(1.0),
                                      content: Text('Oops'),
                                    ),
                                  );
                                });
                                audioPlayer.play();
                                setState(() {
                                  playingIndex == index;
                                });
                              } catch (error) {
                                print(error);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
