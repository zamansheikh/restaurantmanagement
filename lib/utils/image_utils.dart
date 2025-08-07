import 'package:flutter/material.dart';

class ImageUtils {
  /// Determines the type of image source and returns appropriate widget
  static Widget getImageWidget(
    String imageSource, {
    double? width,
    double? height,
    BoxFit? fit,
    double? fontSize,
  }) {
    // Check if it's an emoji (single character that's not alphanumeric)
    if (_isEmoji(imageSource)) {
      return Center(
        child: Text(
          imageSource,
          style: TextStyle(fontSize: fontSize ?? 32),
          textAlign: TextAlign.center,
        ),
      );
    }

    // Check if it's a network URL
    if (_isNetworkUrl(imageSource)) {
      return Image.network(
        imageSource,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    // Check if it's an asset image
    if (_isAssetImage(imageSource)) {
      return Image.asset(
        imageSource,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          );
        },
      );
    }

    // Default fallback - treat as emoji or show placeholder
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          imageSource.isNotEmpty ? imageSource : '🍽️',
          style: TextStyle(fontSize: fontSize ?? 32),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Check if the string is an emoji
  static bool _isEmoji(String text) {
    if (text.isEmpty || text.length > 4) return false;

    // Check if it contains common emoji patterns
    final emojiRegex = RegExp(
      r'[\u{1f300}-\u{1f5ff}]|[\u{1f600}-\u{1f64f}]|[\u{1f680}-\u{1f6ff}]|[\u{1f700}-\u{1f77f}]|[\u{1f780}-\u{1f7ff}]|[\u{1f800}-\u{1f8ff}]|[\u{2600}-\u{26ff}]|[\u{2700}-\u{27bf}]',
      unicode: true,
    );

    return emojiRegex.hasMatch(text) || text.runes.any((rune) => rune > 127);
  }

  /// Check if the string is a network URL
  static bool _isNetworkUrl(String text) {
    return text.startsWith('http://') ||
        text.startsWith('https://') ||
        text.startsWith('www.');
  }

  /// Check if the string is an asset image path
  static bool _isAssetImage(String text) {
    return text.startsWith('assets/') &&
        (text.endsWith('.jpg') ||
            text.endsWith('.jpeg') ||
            text.endsWith('.png') ||
            text.endsWith('.gif') ||
            text.endsWith('.webp'));
  }

  /// Get a circular image widget with border
  static Widget getCircularImage(
    String imageSource, {
    double radius = 40,
    Color? borderColor,
    double borderWidth = 2,
  }) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: getImageWidget(
          imageSource,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }

  /// Get a rounded rectangle image widget
  static Widget getRoundedImage(
    String imageSource, {
    double width = 80,
    double height = 80,
    double borderRadius = 12,
    Color? backgroundColor,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2C1810).withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: getImageWidget(
          imageSource,
          width: width,
          height: height,
          fit: BoxFit.cover,
          fontSize: width * 0.4,
        ),
      ),
    );
  }
}
