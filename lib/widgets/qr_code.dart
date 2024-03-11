import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../bloc/profile_bloc.dart';
import '../models/data/user_data.dart';

class QrCode extends StatelessWidget {
  final double? size;

  const QrCode({
    this.size,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<ProfileBloc, UserData?, String?>(
      selector: (final state) => state?.qrCode,
      builder: (final _, final qrCode) => QrImageView(
        data: qrCode ?? '',
        size: size,
      ),
    );
  }
}
