import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../bloc/event_bloc.dart';
import '../../core/constants.dart';
import '../../extensions/date_time.dart';
import '../../extensions/time_of_day.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../models/data/user_occupancy_data.dart';
import '../../widgets/close_icon.dart';
import '../../widgets/cursor_pointer.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/static_grid.dart';
import '../../widgets/time_zone_bloc_builder.dart';
import 'bloc/add_user_occupancy_bloc.dart';
import 'bloc/add_user_occupancy_state.dart';

class AddUserOccupancyDialog extends StatefulWidget {
  final DateTime? date;

  const AddUserOccupancyDialog._({
    this.date,
  });

  static Future<UserOccupancyData?> show(
    final BuildContext context, {
    final DateTime? date,
  }) {
    final timeZone = TimeZoneBlocBuilder.of(context);
    return showDialog<UserOccupancyData>(
      context: context,
      builder: (final _) => Dialog(
        child: AddUserOccupancyDialog._(
          date: date?.toTZWithoutChange(
            timeZone.zone,
            readTime: false,
          ),
        ),
      ),
    );
  }

  @override
  _AddUserOccupancyDialogState createState() => _AddUserOccupancyDialogState();
}

class _AddUserOccupancyDialogState extends State<AddUserOccupancyDialog> {
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  @override
  void initState() {
    if (widget.date != null) {
      _dateController.text = widget.date!.format(
        format: DATE_FORMAT,
        timeZone: TimeZoneBlocBuilder.of(context),
      );
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext _) {
    return Form(
      child: BlocProvider(
        create: (final _) => AddUserOccupancyBloc(date: widget.date),
        child: BlocConsumer<AddUserOccupancyBloc, AddUserOccupancyState>(
          listenWhen: (final prev, final next) =>
              prev.addUserOccupancyApi.data == null &&
              next.addUserOccupancyApi.data != null,
          listener: (final context, final state) =>
              Navigator.pop(context, state.addUserOccupancyApi.data),
          builder: (final context, final state) => WillPopScope(
            onWillPop: () async {
              return !state.addUserOccupancyApi.isApiInProgress;
            },
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 514,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CloseIcon(
                        onTap: Navigator.of(context).pop,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          translate(
                            context,
                            TranslationKeys.Add_User_Occupancy_Title,
                          )!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 28),
                        CursorPointer(
                          child: GestureDetector(
                            onTap: () => _pickDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _dateController,
                                decoration: InputDecoration(
                                  labelText: translate(
                                    context,
                                    TranslationKeys.Add_User_Occupancy_Date,
                                  ),
                                  suffixIcon:
                                      const Icon(Icons.calendar_today_rounded),
                                  errorText: state.addUserOccupancyApi.error,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: Validators.required(
                                  translate(
                                    context,
                                    TranslationKeys
                                        .Add_User_Occupancy_Error_Date_Required,
                                  )!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        StaticGrid(
                          columns: getValueForScreenType(
                            context: context,
                            mobile: 1,
                            tablet: 2,
                          ),
                          spacing: 14,
                          runSpacing: 14,
                          children: [
                            CursorPointer(
                              child: GestureDetector(
                                onTap: state.addUserOccupancyApi.isApiInProgress
                                    ? null
                                    : () => _pickStartTime(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _startTimeController,
                                    decoration: InputDecoration(
                                      labelText: translate(
                                        context,
                                        TranslationKeys
                                            .Add_User_Occupancy_Start_Time,
                                      ),
                                      suffixIcon:
                                          const Icon(Icons.access_time_rounded),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: Validators.required(
                                      translate(
                                        context,
                                        TranslationKeys
                                            .Add_User_Occupancy_Error_Start_Time_Required,
                                      )!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CursorPointer(
                              child: GestureDetector(
                                onTap: state.addUserOccupancyApi.isApiInProgress
                                    ? null
                                    : () => _pickEndTime(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _endTimeController,
                                    decoration: InputDecoration(
                                      labelText: translate(
                                        context,
                                        TranslationKeys
                                            .Add_User_Occupancy_End_Time,
                                      ),
                                      suffixIcon:
                                          const Icon(Icons.access_time_rounded),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: Validators.compose([
                                      Validators.required(
                                        translate(
                                          context,
                                          TranslationKeys
                                              .Add_User_Occupancy_Error_End_Time_Required,
                                        )!,
                                      ),
                                      (final _) => (state.startTime
                                                      ?.toDate()
                                                      .millisecondsSinceEpoch ??
                                                  0) >=
                                              state.endTime!
                                                  .toDate()
                                                  .millisecondsSinceEpoch
                                          ? translate(
                                              context,
                                              TranslationKeys
                                                  .Add_User_Occupancy_Error_End_Time_Invalid,
                                            )!
                                          : null,
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: translate(
                              context,
                              TranslationKeys.Add_User_Occupancy_Reason,
                            ),
                            suffixIcon: const Icon(Icons.description_outlined),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          onSaved:
                              AddUserOccupancyBloc.of(context).updateReason,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: WCElevatedButton(
                            translate(
                              context,
                              TranslationKeys.Add_User_Occupancy_Add,
                            )!,
                            onTap: state.addUserOccupancyApi.isApiInProgress
                                ? () {}
                                : () => _addCustomAgenda(context),
                            showLoader:
                                state.addUserOccupancyApi.isApiInProgress,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(final BuildContext context) async {
    FocusScope.of(context).unfocus();
    final timeZone = TimeZoneBlocBuilder.of(context);
    final event = EventBloc.of(context).state.getEventApi.data!;
    final bloc = AddUserOccupancyBloc.of(context);
    final initialDate = bloc.state.date ?? event.startDate;

    var date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.fromMillisecondsSinceEpoch(
        math.min(
          event.startDate.millisecondsSinceEpoch,
          initialDate.millisecondsSinceEpoch,
        ),
      ).toUtc(),
      lastDate: DateTime.fromMillisecondsSinceEpoch(
        math.max(
          event.endDate.millisecondsSinceEpoch,
          initialDate.millisecondsSinceEpoch,
        ),
      ).toUtc(),
    );
    if (date == null) {
      return;
    }
    date = date.toTZWithoutChange(timeZone.zone);
    bloc.updateDate(date);
    _dateController.text = date.format(
      format: DATE_FORMAT,
      timeZone: timeZone,
    );
  }

  Future<void> _pickStartTime(final BuildContext context) async {
    FocusScope.of(context).unfocus();
    final bloc = AddUserOccupancyBloc.of(context);
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: bloc.state.startTime?.hour ?? 0,
        minute: bloc.state.startTime?.minute ?? 0,
      ),
    );
    if (time == null) {
      return;
    }
    bloc.updateStartTime(time);
    if (mounted) {
      _startTimeController.text = time.format(context);
    }
  }

  Future<void> _pickEndTime(final BuildContext context) async {
    FocusScope.of(context).unfocus();
    final bloc = AddUserOccupancyBloc.of(context);
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: bloc.state.endTime?.hour ?? 0,
        minute: bloc.state.endTime?.minute ?? 0,
      ),
    );
    if (time == null) {
      return;
    }
    bloc.updateEndTime(time);
    if (mounted) {
      _endTimeController.text = time.format(context);
    }
  }

  void _addCustomAgenda(final BuildContext context) {
    final form = Form.of(context);
    if (!form.validate()) {
      return;
    }
    form.save();
    AddUserOccupancyBloc.of(context).addCustomAgenda();
  }
}
