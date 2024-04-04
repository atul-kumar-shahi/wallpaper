import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key, required this.url});

  final String url;

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override

  Future<void>setWallPaper()async{
    int location=WallpaperManager.HOME_SCREEN;
    var file=await DefaultCacheManager().getSingleFile(widget.url);
    String result=await WallpaperManager.setWallpaperFromFile(file.path, location).toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Image.network(
                widget.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                setWallPaper();
              },
              child: Center(child: const Text('set to Wallpaper')),
            ),
          ),
        ],
      ),
    );
  }
}
