import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'image.dart';
import 'round_image.dart';

class UserAvatar extends StatelessWidget {
  final double? borderRadius;
  final double? size;
  final String? profilePicture;
  final PlatformFile? file;

  const UserAvatar({
    this.profilePicture,
    this.borderRadius,
    this.size,
    this.file,
  });

  @override
  Widget build(final BuildContext context) {
    return profilePicture != null || file != null
        ? RoundImage(
            imageUrl: profilePicture,
            imageFile: file,
            borderRadius: borderRadius ?? 10,
            width: size ?? 30,
            height: size ?? 30,
            fit: BoxFit.cover,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            child: WCImage(
              image: 'user_avatar.png',
              width: size ?? 30,
              height: size ?? 30,
            ),
          );
  }
}

class OrganizationAvatar extends StatelessWidget {
  final double? borderRadius;
  final double? size;
  final String? logoUrl;
  final PlatformFile? file;

  const OrganizationAvatar({
    this.logoUrl,
    this.borderRadius,
    this.size,
    this.file,
  });

  @override
  Widget build(final BuildContext context) {
    return logoUrl != null || file != null
        ? RoundImage(
            imageUrl: logoUrl,
            imageFile: file,
            borderRadius: borderRadius ?? 10,
            width: size ?? 30,
            height: size ?? 30,
            fit: BoxFit.cover,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            child: WCImage(
              image: 'organization_avatar.png',
              width: size ?? 30,
              height: size ?? 30,
            ),
          );
  }
}
