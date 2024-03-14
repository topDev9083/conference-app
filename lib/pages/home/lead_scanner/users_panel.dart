import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/user_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/list_paginator.dart';
import '../../../widgets/progress_indicator.dart';
import '../../../widgets/trn_text.dart';
import '../../../widgets/user_item.dart';
import '../../qr_scanner/qr_scanner_dialog.dart';
import 'bloc/lead_scanner_bloc.dart';
import 'bloc/lead_scanner_state.dart';
import 'router/lead_scanner_route_bloc.dart';

class UsersPanel extends StatelessWidget {
  const UsersPanel({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final bloc = LeadScannerBloc.of(context);
    return BlocBuilder<LeadScannerBloc, LeadScannerState>(
      builder: (final _, final state) => Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const _LeadScanPanel(),
            const SizedBox(height: 8),
            const Divider(),
            Expanded(
              child: state.getUsersApi.data == null
                  ? Center(
                      child: ConnectionInformation(
                        error: state.getUsersApi.error,
                        onRetry: bloc.getUsers,
                      ),
                    )
                  : state.getUsersApi.data!.isEmpty
                      ? const Center(
                          child: _EmptyUsers(),
                        )
                      : Scrollbar(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (final _, final index) {
                              final list = state.getUsersApi.data!;
                              if (index >= list.length) {
                                return ListPaginator(
                                  error: state.getUsersApi.error,
                                  onLoad: () => bloc.getUsers(list.length),
                                );
                              } else {
                                final user = list[index];
                                return UserItem(
                                  user,
                                  deleteIconState:
                                      (state.deleteUserApi[user.id] ??
                                                  ApiState<void>())
                                              .isApiInProgress
                                          ? UserItemDeleteState.loading
                                          : UserItemDeleteState.visible,
                                  onDelete: () => _onDelete(context, user),
                                  onTap: () => _onUserSelected(
                                    context,
                                    user,
                                  ),
                                );
                              }
                            },
                            itemCount: state.getUsersApi.data!.length +
                                (state.getUsersApi.isApiPaginationEnabled
                                    ? 1
                                    : 0),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDelete(final BuildContext context, final UserData user) {
    LeadScannerBloc.of(context).deleteUser(user.id);
  }

  void _onUserSelected(final BuildContext context, final UserData user) {
    LeadScannerRouteBloc.of(context).updateSelectedUserid(user.id);
  }
}

class _LeadScanPanel extends StatelessWidget {
  const _LeadScanPanel();

  @override
  Widget build(final BuildContext context) {
    final bloc = LeadScannerBloc.of(context);
    return BlocBuilder<LeadScannerBloc, LeadScannerState>(
      builder: (final _, final state) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const TrnText(
                    TranslationKeys.Lead_Scanner_Scanned_Leads,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  state.getUsersCsvApi.isApiInProgress
                      ? Padding(
                          padding: const EdgeInsets.all(9.5),
                          child: WCProgressIndicator.small(),
                        )
                      : WCInkWell(
                          onTap: bloc.getUsersCSV,
                          padding: const EdgeInsets.all(8),
                          child: Tooltip(
                            message: translate(
                              context,
                              kIsWeb
                                  ? TranslationKeys.Lead_Scanner_Download_Csv
                                  : TranslationKeys.Lead_Scanner_Share_Csv,
                            ),
                            child: const Icon(
                              kIsWeb ? Icons.download : Icons.share,
                              size: 18,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            if (state.addUserApi.isApiInProgress) ...[
              WCProgressIndicator.small(),
            ] else ...[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: WCInkWell(
                  isDark: true,
                  onTap: () => _onScanQRCode(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: const Row(
                    children: [
                      WCImage(
                        image: 'ic_lead_scanner.png',
                        width: 12,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      TrnText(
                        TranslationKeys.Lead_Scanner_Scan_Qr_Code,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _onScanQRCode(final BuildContext context) async {
    final bloc = LeadScannerBloc.of(context);
    final qrCode = await QrScannerDialog.show(context);
    if (qrCode == null) {
      return;
    }
    await bloc.addUser(qrCode);
  }
}

class _EmptyUsers extends StatelessWidget {
  const _EmptyUsers();

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: WCColors.grey_ec,
            shape: BoxShape.circle,
            border: Border.all(
              color: WCColors.grey_f2,
              width: 7,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: WCImage(
            image: 'avatar_2.png',
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 14),
        TrnText(
          TranslationKeys.Lead_Scanner_No_Leads_Found,
          style: TextStyle(
            color: WCColors.black_09.withOpacity(0.7),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        TrnText(
          TranslationKeys.Lead_Scanner_Click_Scan,
          style: TextStyle(
            color: WCColors.black_09.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
