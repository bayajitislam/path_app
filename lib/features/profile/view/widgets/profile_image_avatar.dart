import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';

class ProfileImageAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileImageAvatar({
    super.key,
    this.imageUrl =
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=300',
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: const AssetImage(AppImages.defaultAvatar),
        foregroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        onForegroundImageError: (_, _) {},
      ),
    );
  }
}
