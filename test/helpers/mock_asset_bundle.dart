import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MockAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (key == 'AssetManifest.json') {
      return '{"assets/images/headphone.png":["assets/images/headphone.png"]}';
    }
    return "";
  }

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.json') {
      return ByteData.view(
        Uint8List.fromList(
          utf8.encode(
            '{"assets/images/headphone.png":["assets/images/headphone.png"]}',
          ),
        ).buffer,
      );
    }

    if (key == 'AssetManifest.bin') {
      // Return null or error to force JSON fallback?
      // Or simpler, just return empty data which hopefully fails gracefully?
      // Actually, easiest is to just only support what's asked.
      // If flutter tries bin, it expects StandardMessageCodec.
      throw FlutterError('Use JSON manifest');
    }

    // Return a 1x1 transparent pixel
    final Uint8List transparentPixel = Uint8List.fromList(<int>[
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // Header
      0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, // IHDR
      0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // Size
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
      0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, // IDAT
      0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
      0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
      0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
      0x42, 0x60, 0x82,
    ]);
    return ByteData.view(transparentPixel.buffer);
  }
}
