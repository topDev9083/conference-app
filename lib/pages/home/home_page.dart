import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/home_drawer_bloc.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/state/event_state.dart';
import '../../bloc/state/home_drawer_state.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../models/data/announcement_data.dart';
import '../../models/data/feed_comment_data.dart';
import '../../models/data/feed_data.dart';
import '../../models/data/meeting_data.dart';
import '../../models/data/message_data.dart';
import '../../models/data/socket_notification_data.dart';
import '../../models/data/user_data.dart';
import '../../models/enums/message_type.dart';
import '../../services/fcm_service.dart';
import '../../services/notification_overlay_service.dart';
import '../../services/socket_service.dart';
import '../../utils/dio.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/avatar.dart';
import '../../widgets/image.dart';
import '../../widgets/ink_well.dart';
import '../announcement_detail/announcement_detail_dialog.dart';
import '../announcements/announcements_button.dart';
import '../announcements/bloc/announcements_bloc.dart';
import '../change_password/change_password_dialog.dart';
import '../notification_overlay/bloc/notification_popup_item.dart';
import 'drawer_container.dart';
import 'messages/router/messages_route_config.dart';
import 'router/home_route_bloc.dart';
import 'router/home_route_config.dart';
import 'schedule_meetings/router/schedule_meetings_route_config.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (final _) => HomeDrawerBloc(
            profileBloc: ProfileBloc.of(context),
          ),
        ),
        BlocProvider(
          create: (final _) => AnnouncementsBloc(),
        ),
      ],
      child: const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatefulWidget {
  const _HomeScaffold();

  @override
  __HomeScaffoldState createState() => __HomeScaffoldState();
}

class __HomeScaffoldState extends State<_HomeScaffold> with AfterLayoutMixin {
  LogoutInterceptor? logoutInterceptor;
  StreamSubscription? _onMessageSub;
  StreamSubscription? _onScheduleMeetingSub;
  StreamSubscription? _onMeetingReminderSub;
  StreamSubscription? _onAnnouncementSub;
  StreamSubscription? _onFeedSub;
  StreamSubscription? _onFeedCommentSub;
  StreamSubscription? _onTapMessageNotificationSub;
  StreamSubscription? _onTapMeetingNotificationSub;
  StreamSubscription? _onTapAnnouncementNotificationSub;
  StreamSubscription? _onTapFeedNotificationSub;
  StreamSubscription? _onSocketErrorSub;

  @override
  void afterFirstLayout(final BuildContext context) {
    final profileBloc = ProfileBloc.of(context);
    socketService.connect();
    _onSocketErrorSub = socketService.onError
        .where((final metaData) => metaData.status == 401)
        .listen((final _) => ProfileBloc.of(context).logout());
    logoutInterceptor = LogoutInterceptor(ProfileBloc.of(context));
    dio.interceptors.add(logoutInterceptor!);
    profileBloc.updateFcmToken();
    fcmService.initialize();
    notificationOverlayService.initialize(context);
    _onMessageSub = socketService.onMessage.listen(_onMessageReceived);
    _onScheduleMeetingSub =
        socketService.onScheduleMeeting.listen(_onScheduleMeetingReceived);
    _onMeetingReminderSub =
        socketService.onMeetingReminder.listen(_onMeetingReminderReceived);
    _onAnnouncementSub =
        socketService.onAnnouncement.listen(_onAnnouncementReceived);
    _onFeedSub = socketService.onFeed.listen(_onFeedReceived);
    _onFeedCommentSub =
        socketService.onFeedComment.listen(_onFeedCommentReceived);
    _onTapMessageNotificationSub =
        fcmService.onTapMessageNotification.listen(_onTapMessageNotification);
    _onTapMeetingNotificationSub =
        fcmService.onTapMeetingNotification.listen(_onTapMeetingNotification);
    _onTapAnnouncementNotificationSub = fcmService.onTapAnnouncementNotification
        .listen(_onTapAnnouncementNotification);
    _onTapFeedNotificationSub = fcmService.onTapFeedNotification.listen(
      (final _) => _onTapFeedNotification(),
    );
    if (profileBloc.state?.isByTemporaryPassword == true) {
      Future.delayed(const Duration()).then((final _) {
        ChangePasswordDialog.show(context);
      });
    }
  }

  @override
  void dispose() {
    dio.interceptors.remove(logoutInterceptor);
    _onMessageSub?.cancel();
    _onScheduleMeetingSub?.cancel();
    _onMeetingReminderSub?.cancel();
    _onAnnouncementSub?.cancel();
    _onFeedSub?.cancel();
    _onFeedCommentSub?.cancel();
    _onTapMessageNotificationSub?.cancel();
    _onTapMeetingNotificationSub?.cancel();
    _onTapAnnouncementNotificationSub?.cancel();
    _onTapFeedNotificationSub?.cancel();
    _onSocketErrorSub?.cancel();
    socketService.dispose();
    notificationOverlayService.dispose();
    super.dispose();
  }

  void _onMessageReceived(final MessageData message) {
    if (message.fromUserId == ProfileBloc.of(context).state?.id) {
      return;
    }
    if (message.fromUserId == socketService.selectedMessageUserId) {
      return;
    }
    if (message.type == MessageType.meeting) {
      return;
    }
    notificationOverlayService.showNotification(
      NotificationPopupItem.create(
        id: 'message_${message.id}',
        title: message.fromUserFullName,
        subtitle: message.message ?? '',
        onTap: () => _onTapMessageNotification(message),
      ),
    );
  }

  void _onTapMessageNotification(final MessageData message) {
    HomeRouteBloc.of(context).updateRouteConfig(
      HomeRouteConfig.messages(
        messagesRouteConfig: MessagesRouteConfig(
          selectedUserId: message.fromUserId,
        ),
      ),
    );
  }

  void _onScheduleMeetingReceived(
    final SocketNotificationData<MeetingData> data,
  ) {
    final meeting = data.body;
    final notification = data.notification;
    notificationOverlayService.showNotification(
      NotificationPopupItem.create(
        id: 'meeting_${meeting.id}',
        title: notification.title,
        subtitle: notification.body,
        onTap: () => _onTapMeetingNotification(meeting),
      ),
    );
  }

  void _onMeetingReminderReceived(
    final SocketNotificationData<MeetingData> data,
  ) {
    final meeting = data.body;
    final notification = data.notification;
    notificationOverlayService.showNotification(
      NotificationPopupItem.create(
        id: 'meeting_reminder_${meeting.id}',
        title: notification.title,
        subtitle: notification.body,
        onTap: () => _onTapMeetingNotification(meeting),
      ),
    );
  }

  void _onTapMeetingNotification(final MeetingData meeting) {
    final userId = meeting.getUserId(ProfileBloc.of(context).state?.id ?? -1);
    HomeRouteBloc.of(context).updateRouteConfig(
      HomeRouteConfig.scheduleMeetings(
        scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
          selectedUserId: userId,
        ),
      ),
    );
  }

  void _onAnnouncementReceived(
    final AnnouncementData announcement,
  ) {
    notificationOverlayService.showNotification(
      NotificationPopupItem.create(
        id: 'announcement_${announcement.id}',
        title: announcement.subject,
        subtitle: announcement.message,
        onTap: () => _onTapAnnouncementNotification(announcement),
      ),
    );
  }

  Future<void> _onTapAnnouncementNotification(
    final AnnouncementData announcement,
  ) async {
    final announcementsBloc = AnnouncementsBloc.of(context);
    await AnnouncementDetailDialog.show(
      context,
      announcement: announcement,
    );
    announcementsBloc.markAnnouncementAsRead(announcement.id);
  }

  void _onFeedReceived(
    final FeedData feed,
  ) {
    notificationOverlayService.showNotification(
      NotificationPopupItem.create(
        id: 'feed_${feed.id}',
        title: '${feed.createdByUser?.fullName ?? 'Admin'} has posted Feed',
        subtitle: feed.text ?? feed.imageUrl ?? '',
        onTap: () => _onTapFeedNotification(),
      ),
    );
  }

  void _onFeedCommentReceived(
    final FeedCommentData comment,
  ) {
    notificationOverlayService.showNotification(
      NotificationPopupItem.create(
        id: 'feedComment_${comment.id}',
        title:
            '${comment.createdByUser?.fullName ?? 'Admin'} has posted Comment on Feed',
        subtitle: comment.text ?? '',
        onTap: () => _onTapFeedNotification(),
      ),
    );
  }

  void _onTapFeedNotification() async {
    HomeRouteBloc.of(context).updateRouteConfig(
      const HomeRouteConfig.feeds(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final endDrawer = BlocBuilder<HomeDrawerBloc, HomeDrawerState>(
      buildWhen: (final prev, final next) => prev.endDrawer != next.endDrawer,
      builder: (final _, final state) => state.endDrawer ?? const SizedBox(),
    );
    // ignore: avoid_positional_boolean_parameters
    void onEndDrawerChanged(final bool isOpened) {
      if (!isOpened) {
        HomeDrawerBloc.of(context).updateEndDrawerWidget(null);
      }
    }

    const body = _HomeBody();
    return Builder(
      builder: (final context) {
        final addDrawer = ScreenType.of(context).isMobileOrTablet;
        return Scaffold(
          drawer: !addDrawer
              ? null
              : const Drawer(
                  child: DrawerContainer(),
                ),
          onDrawerChanged: !addDrawer
              ? null
              : (final isOpen) =>
                  isOpen ? FocusManager.instance.primaryFocus?.unfocus() : null,
          body: body,
          endDrawer: endDrawer,
          endDrawerEnableOpenDragGesture: false,
          onEndDrawerChanged: onEndDrawerChanged,
        );
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          if (ScreenType.of(context).isDesktop) ...[
            BlocBuilder<HomeDrawerBloc, HomeDrawerState>(
              buildWhen: (final prev, final next) =>
                  prev.isDesktopDrawerCollapsed !=
                  next.isDesktopDrawerCollapsed,
              builder: (final _, final state) => AnimatedContainer(
                duration: const Duration(
                  milliseconds: ANIMATION_DURATION_IN_MILLISECONDS,
                ),
                width: state.isDesktopDrawerCollapsed
                    ? 0
                    : DrawerContainer.DRAWER_WIDTH,
                child: Stack(
                  children: [
                    AnimatedPositionedDirectional(
                      duration: const Duration(
                        milliseconds: ANIMATION_DURATION_IN_MILLISECONDS,
                      ),
                      start: state.isDesktopDrawerCollapsed
                          ? -DrawerContainer.DRAWER_WIDTH
                          : 0,
                      end: 0,
                      top: 0,
                      bottom: 0,
                      child: const DrawerContainer(),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const Expanded(
            child: _RightContainer(),
          ),
        ],
      ),
    );
  }
}

class _Hamburger extends StatelessWidget {
  const _Hamburger();

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: WCColors.grey_f2,
      ),
      child: WCInkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _toggleDrawer(context),
        child: const Icon(Icons.menu_rounded),
      ),
    );
  }

  void _toggleDrawer(final BuildContext context) {
    final scaffold = Scaffold.of(context);
    if (scaffold.hasDrawer) {
      if (scaffold.isDrawerOpen) {
        Navigator.pop(context);
      } else {
        scaffold.openDrawer();
      }
    } else {
      HomeDrawerBloc.of(context).toggleIsDesktopCollapsed();
    }
  }
}

class _ProfileContainer extends StatelessWidget {
  const _ProfileContainer();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ProfileBloc, UserData?>(
      builder: (final _, final profile) => Row(
        children: [
          Stack(
            children: [
              UserAvatar(
                profilePicture: profile?.profilePicture,
                size: 36,
              ),
              Positioned.fill(
                child: WCInkWell(
                  isDark: profile?.profilePicture != null,
                  borderRadius: BorderRadius.circular(7),
                  onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
                    const HomeRouteConfig.profile(),
                  ),
                ),
              ),
            ],
          ),
          if (ScreenType.of(context).isDesktop) ...[
            Row(
              children: [
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile?.fullName ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    if (profile?.jobAtOrganization != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        profile!.jobAtOrganization!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, String?>(
      selector: (final state) => state.getEventApi.data?.appConfig.sponsorLogo,
      builder: (final _, final sponsorLogo) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              const SizedBox(width: 11),
              const _Hamburger(),
              const SizedBox(width: 27),
              if (sponsorLogo != null) ...[
                if (ScreenType.of(context).isTabletOrGreater) ...[
                  Row(
                    children: [
                      Text(
                        translate(
                          context,
                          TranslationKeys.Home_Toolbar_Event_Sponsored_By,
                        )!,
                        style: TextStyle(
                          color: WCColors.black_09.withOpacity(0.93),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
                WCImage(
                  image: sponsorLogo,
                  height: 28,
                ),
              ],
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ProfileContainer(),
                    SizedBox(width: 20),
                    AnnouncementsButton(),
                    SizedBox(width: 11),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RightContainer extends StatelessWidget {
  const _RightContainer();

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Toolbar(),
        Expanded(
          child: Router(
            routerDelegate: HomeRouteBloc.of(context).state.routerDelegate,
          ),
        ),
      ],
    );
  }
}
