import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageView extends StatelessWidget {
  const NetworkImageView({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return const Icon(Icons.broken_image_outlined);
      },
    );
  }
}
