import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ColorUtils {
  static Future<Color> getPaletteColor(String imageUrl) async {
    try {
      final imageProvider = CachedNetworkImageProvider(imageUrl);
      final paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
      return paletteGenerator.dominantColor?.color ?? Colors.white.withOpacity(0.5);
    } catch (e) {
      print('Error fetching palette: $e');
      return Colors.black
      // .withOpacity(0.5)
      ;
    }
  }
}