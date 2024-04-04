import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: InkWell(
              onTap: () {},
              child: Center(child: const Text('set to Wallpaper')),
            ),
          ),
        ],
      ),
    );
  }
}
