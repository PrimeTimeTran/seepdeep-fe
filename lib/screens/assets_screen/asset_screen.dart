import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_downloader_web/image_downloader_web.dart';

class AssetScreen extends StatefulWidget {
  final String img;
  const AssetScreen({super.key, required this.img});

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    String url =
        'https://storage.googleapis.com/turboship-dev-alpha/feelings/${widget.img}';
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Column(
        children: [
          Image.network(url),
          Text(
            widget.img.split('.')[0],
            style: Style.of(
              context,
              'headlineL',
            ),
          ),
          if (downloading)
            const CircularProgressIndicator()
          else
            MaterialButton(
              onPressed: _downloadImage,
              color: Colors.blue,
              child: const Text(
                "Download",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }

  Future<void> _downloadImage() async {
    setState(() {
      downloading = true;
    });
    String url =
        'https://storage.googleapis.com/turboship-dev-alpha/feelings/${widget.img}';
    await WebImageDownloader.downloadImageFromWeb(
      url,
      name: widget.img.split('.')[0],
      imageType: ImageType.png,
    );
    setState(() {
      downloading = false;
    });
  }
}
