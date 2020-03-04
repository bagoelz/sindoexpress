import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sindoexpress/screen/home.dart';
import 'package:sindoexpress/screen/about_us.dart';
import 'package:sindoexpress/screen/news.dart';
import 'package:video_player/video_player.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying;
  bool _loadingInProgress=false;

  
  @override
  void initState() { 
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/intro.mp4',
    )..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if(!isPlaying){
          setState(() {
            _loadingInProgress = true;
          });
          startSplashScreen();
        }
      });
     
      
    _initializeVideoPlayerFuture = _controller.initialize();
     _controller.play();
   
  }

  @override
  void dispose(){
     _controller.dispose();
     super.dispose();
  }
startSplashScreen() async{
  
      var duration = const Duration(milliseconds: 1500);
      return Timer(duration, (){
        setState(() {
            _loadingInProgress = false;
          });
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_){
                return home();
                //return OurclientPage();
              })
          );
      });
  }

 
  Widget build(BuildContext context) {
    return ModalProgressHUD(child:SafeArea(
      child:Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the VideoPlayer.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      )
      //floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Wrap the play or pause in a call to `setState`. This ensures the
      //     // correct icon is shown.
      //     setState(() {
      //       // If the video is playing, pause it.
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         // If the video is paused, play it.
      //         _controller.play();
      //       }
      //     });
      //   },
      //   // Display the correct icon depending on the state of the player.
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
      
      
    ),color: Colors.black,
        progressIndicator: CircularProgressIndicator(backgroundColor: Colors.black12,),
        inAsyncCall: _loadingInProgress,);
    // return new Container(
    //     color: Colors.white,
    //     child: Image.asset("assets/splash_screen.png"),
    // );
  }
}