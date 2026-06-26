import 'dart:convert';
import 'package:flutter/material.dart';

class ImagemPet extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImagemPet({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('data:image')) {
      try {
        final base64String = imageUrl.split(',')[1];
        return Image.memory(
          base64Decode(base64String),
          height: height,
          width: width,
          fit: fit,
        );
      } catch (e) {
        return _buildWidgetErro();
      }
    } else if (imageUrl.isNotEmpty &&
        (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'))) {
      return Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: height,
            width: width,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildWidgetErro(),
      );
    } else {
      return _buildWidgetPadrao();
    }
  }

  Widget _buildWidgetErro() {
    return SizedBox(
      height: height,
      width: width,
      child: const Center(
        child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildWidgetPadrao() {
    return SizedBox(
      height: height,
      width: width,
      child: const Center(
        child: Icon(Icons.pets, size: 40, color: Colors.grey),
      ),
    );
  }
}
