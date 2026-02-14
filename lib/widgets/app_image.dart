import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
  });

  final String path;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  bool get _isNetwork =>
      path.startsWith('http://') || path.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final fallback =
        placeholder ??
        const ColoredBox(
          color: Color(0xFFE8F5E9),
          child: Icon(Icons.image_outlined, color: Color(0xFF8FBFA0)),
        );

    Widget image;
    if (_isNetwork) {
      if (const bool.fromEnvironment('FLUTTER_TEST')) {
        image = fallback;
      } else {
        image = Image.network(
          path,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => fallback,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return fallback;
          },
        );
      }
    } else {
      image = Image.asset(
        path,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    }

    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
