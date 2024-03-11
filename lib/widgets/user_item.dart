import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../models/data/user_data.dart';
import 'avatar.dart';
import 'image.dart';
import 'ink_well.dart';
import 'progress_indicator.dart';
import 'user_online_dot.dart';

class UserItem extends StatelessWidget {
  final UserData user;
  final bool showOnlineStatus;
  final UserItemDeleteState deleteIconState;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const UserItem(
    this.user, {
    this.showOnlineStatus = false,
    this.deleteIconState = UserItemDeleteState.hidden,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      onTap: onTap,
      child: Stack(
        children: [
          if (deleteIconState == UserItemDeleteState.visible) ...[
            PositionedDirectional(
              top: 2,
              end: 4,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: WCInkWell(
                  isCircle: true,
                  onTap: onDelete,
                  padding: const EdgeInsets.all(8),
                  child: const WCImage(
                    image: 'ic_delete.png',
                    width: 14,
                    color: WCColors.red_ff,
                  ),
                ),
              ),
            ),
          ] else if (deleteIconState == UserItemDeleteState.loading) ...[
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10,
                end: 12,
              ),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: WCProgressIndicator.small(),
              ),
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 12),
                  Stack(
                    children: [
                      UserAvatar(
                        profilePicture: user.profilePicture,
                        size: 48,
                      ),
                      if (showOnlineStatus) ...[
                        PositionedDirectional(
                          top: 0,
                          end: 0,
                          child: UserOnlineDot(
                            isOnline: user.isOnline == true,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (user.jobTitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            user.jobTitle!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: WCColors.grey_7a,
                            ),
                          ),
                        ],
                        if (user.organizationId != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            user.organization!.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: WCColors.grey_7a,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}

enum UserItemDeleteState {
  visible,
  hidden,
  loading,
}
