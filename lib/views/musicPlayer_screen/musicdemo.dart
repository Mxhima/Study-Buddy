import 'dart:convert';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:audio_service/audio_service.dart';
import 'package:study_buddy/constants/image_strings.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlaying = false;
  double value = 0;
  double volume = 1.0;
  bool isVolumeSliderShown = false;
  List<String> trackList = [];
  int selectedIndex = -1;

  //Creating an instance of the Music player
  final player = AudioPlayer();
  Duration? duration = Duration(seconds: 0);

  //List of music tracks
  // List<String> trackNames = ['alapagee.mp3'];
  // List<String> trackPaths = ['assets/tracks/alapagee.mp3'];

  void fetchTrackList() {
    trackList = [
      'alapagee.mp3',
      'track2.mp3',
      'track3.mp3',
    ]; // Update with your actual track names
  }

  //Create a function to initiate the music into the player
  void initPlayer() async {
    //await player.setSource(AssetSource("alapagee.mp3"));
    duration = await player.getDuration();
    // final manifestContent =
    //     await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    // final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // final trackPaths = manifestMap.keys
    //     .where((String key) => key.startsWith('assets/tracks/'))
    //     .toList();
    // setState(() {
    //   this.trackNames = trackPaths
    //       .map((String path) => path.replaceAll('assets/tracks/', ''))
    //       .toList();
    //   this.trackPaths = trackPaths;
    // });

    // await player.setSourceDeviceFile(
    //     trackPaths[0]); // Initialize player with the first track

    fetchTrackList();
  }

  void playTrack(int index) async {
    setState(() {
      selectedIndex = index;
    });

    String trackName = trackList[index];
    String trackPath =
        'assets/tracks/$trackName'; // Update with your actual assets path
    await player.setSourceAsset(trackPath);
    await player.resume();

    // Tracking the position value
    player.onPositionChanged.listen((position) {
      setState(() {
        value = position.inSeconds.toDouble();
      });
    });
  }

  void pauseTrack() async {
    await player.pause();
    setState(() {
      selectedIndex = -1;
    });
  }

  void resumeTrack() async {
    await player.resume();
    setState(() {
      selectedIndex = 0; // Assuming the first track is resumed
    });
  }

  void seekToPosition(double newValue) async {
    setState(() {
      value = newValue;
    });

    await player.pause();
    await player.seek(Duration(seconds: newValue.toInt()));
    await player.resume();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  void showTrackListModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: trackList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(trackList[index]),
              onTap: () {
                Navigator.pop(context);
                playTrack(index);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/musicBG.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black26,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "images/musicBG.jpg",
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Aalapa Gee",
                style: TextStyle(
                    color: tWhiteColor, fontSize: 36.0, letterSpacing: 3),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor()}:${(value % 60).floor()}",
                    style: const TextStyle(
                      color: tWhiteColor,
                    ),
                  ),
                  Slider.adaptive(
                    onChanged: (v) {
                      value = v;
                    },
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    onChangeEnd: (newValue) async {
                      setState(() {
                        value = newValue;
                      });
                      player.pause();
                      await player.seek(Duration(seconds: newValue.toInt()));
                      await player.resume();
                    },
                    activeColor: tPrimaryColor,
                  ),
                  Text(
                    "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                    style: const TextStyle(
                      color: tWhiteColor,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: tPrimaryColor),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (isPlaying) {
                          await player.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        } else {
                          await player.resume();
                          setState(() {
                            isPlaying = true;
                          });

                          //tracking the position value
                          player.onPositionChanged.listen((position) {
                            setState(() {
                              value = position.inSeconds.toDouble();
                            });
                          });
                        }
                      },
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: tWhiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: tPrimaryColor),
                    ),
                    child: InkWell(
                      onTap: () {
                        showTrackListModal(context);
                      },
                      child: Icon(
                        Icons.library_music,
                        color: tWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
