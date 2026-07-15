import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final shape = Theme.of(context).cardTheme.shape;
    final borderRadius = shape is RoundedRectangleBorder
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(12); // repli si le thème change de forme

    return Card(
      margin: margin,       // null = margin par défaut de AppTheme.cardTheme
      color: color,         // null = couleur par défaut de AppTheme.cardTheme
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,        // null = largeur naturelle (cas normal)
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius, // splash aligné sur la forme du thème
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}