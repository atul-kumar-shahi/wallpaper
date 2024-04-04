import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/fullscreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  @override
  List images = [];

  void initState() {
    super.initState();
    fetchApi();
  }

  Future<void> fetchApi() async {
    try {
      final res = await http.get(
          Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
          headers: {
            'Authorization':
                'your Api',
          });
      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        setState(() {
          images = result['photos'];
        });
      }
    } catch (e) {
      ScaffoldMessenger(
          child: SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  Future<void>loadMore()async{
    try {
      final res = await http.get(
          Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
          headers: {
            'Authorization':
            'Your Api',
          });
      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        setState(() {
          images.addAll(result['photos']);
        });
      }
    } catch (e) {
      ScaffoldMessenger(
          child: SnackBar(
            content: Text(e.toString()),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                        url: images[index]['src']['large2x']
                                            .toString(),
                                      )));
                        },
                        child: Container(
                          color: Colors.white70,
                          child: Image.network(
                            images[index]['src']['tiny'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    })),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  loadMore();
                },
                child: const Text('load more'),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
