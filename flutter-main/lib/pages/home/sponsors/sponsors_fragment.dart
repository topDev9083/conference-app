import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../../../widgets/connection_information.dart';
import 'bloc/sponsors_bloc.dart';
import 'bloc/sponsors_state.dart';
import 'sponsors_list.dart';
import 'sponsors_detail.dart';
import '../../../widgets/static_grid.dart';
import '../../../utils/flutter_flow/flutter_flow_theme.dart';

List<String> list = <String>[
  'All Sponsors',
  'Diamond',
  'Platinum',
  'Gold',
  'Silver'
];

class SponsorsFragment extends StatelessWidget {
  const SponsorsFragment();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
        create: (final _) => SponsorsBloc(),
        child: BlocBuilder<SponsorsBloc, SponsorsState>(
            builder: (final context, final state) =>
                state.getSponsorsApi.data == null
                    ? Center(
                        child: ConnectionInformation(
                          error: state.getSponsorsApi.error,
                          onRetry: SponsorsBloc.of(context).getSponsors,
                        ),
                      )
                    : state.moveTosponsor == "1"
                        ? _HeaderSponsors()
                        : _HeaderSponsorsDetail()));
  }
}

class _HeaderSponsors extends StatelessWidget {
  const _HeaderSponsors();
  @override
  Widget build(final BuildContext context) {
    return (Column(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            width: double.infinity,
            height: 1.0,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
            ),
          ),
          BlocProvider(
              create: (final _) => SponsorsBloc(),
              child: BlocBuilder<SponsorsBloc, SponsorsState>(
                  builder: (final context, final state) =>
                      Text(state.moveTosponsor + "aaa"))),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: getValueForScreenType(
                context: context,
                mobile: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 5.0, 0.0, 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text('Sponsors',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                )),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 5.0, 0.0, 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                child: TextFormField(
                                  // controller:
                                  //     _model.textController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFA0A5B1),
                                          fontWeight: FontWeight.w500,
                                          lineHeight: 1.43,
                                        ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(0xFFA0A5B1),
                                      size: 18.0,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        lineHeight: 1.43,
                                      ),
                                  cursorColor: Color(0xFF1A1A1A),
                                  // validator: _model
                                  //     .textControllerValidator
                                  //     .asValidator(context),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 5.0, 0.0, 5.0),
                                child: Container(
                                    width: double.infinity,
                                    child: DropdownMenuExample()))),
                      ]),
                    ),
                  ],
                ),
                tablet: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 5.0, 0.0, 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text('Sponsors',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF1A1A1A),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 5.0, 0.0, 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(
                                      color: Color(0xFFE0E0E0),
                                    ),
                                  ),
                                  child: TextFormField(
                                    // controller:
                                    //     _model.textController,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFFA0A5B1),
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.43,
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Color(0xFFA0A5B1),
                                        size: 18.0,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          lineHeight: 1.43,
                                        ),
                                    cursorColor: Color(0xFF1A1A1A),
                                    // validator: _model
                                    //     .textControllerValidator
                                    //     .asValidator(context),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 5.0, 0.0, 5.0),
                                  child: Container(
                                      width: double.infinity,
                                      child: DropdownMenuExample()))),
                        ]),
                      ),
                    ),
                    // Container(
                    //   // width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color: FlutterFlowTheme.of(context).secondaryBackground,
                    //   ),
                    //   alignment: AlignmentDirectional(-1.0, 0.0),
                    //   child: Text(
                    //     'Sponsors',
                    //     style: FlutterFlowTheme.of(context).bodyMedium.override(
                    //           fontFamily: 'Inter',
                    //           color: Color(0xFF1A1A1A),
                    //           fontSize: 25.0,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //   ),
                    // ),
                  ],
                )),
          ),
        ]),
        const SizedBox(height: 20),
        Expanded(
          child: SponsorsList(),
        ),
      ],
    ));
  }
}

class _HeaderSponsorsDetail extends StatelessWidget {
  const _HeaderSponsorsDetail();
  @override
  Widget build(final BuildContext context) {
    return (BlocProvider(
        create: (final _) => SponsorsBloc(),
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(
                width: double.infinity,
                height: 1.0,
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Builder(
                    builder: (final context) => GestureDetector(
                          onTap: () {
                            // Event handler code here
                            SponsorsBloc.of(context).funSponsor("1");
                          },
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding: getValueForScreenType(
                                context: context,
                                mobile: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 10.0),
                                desktop: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 20.0, 20.0, 20.0),
                              ),
                              child: Container(
                                width: getValueForScreenType(
                                  context: context,
                                  mobile: 15.0,
                                  desktop: 20.0,
                                ),
                                height: getValueForScreenType(
                                  context: context,
                                  mobile: 15.0,
                                  desktop: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/ic_left_arrow.png',
                                    ).image,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Mobile Sentrix',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Color.fromARGB(255, 10, 15, 19),
                                    fontSize: getValueForScreenType(
                                      context: context,
                                      mobile: 14.0,
                                      desktop: 16.0,
                                    ),
                                    letterSpacing: 0.12,
                                    fontWeight: getValueForScreenType(
                                      context: context,
                                      mobile: FontWeight.w600,
                                      desktop: FontWeight.w700,
                                    ),
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ]),
                        )),
              ),
            ]),
            Expanded(
              child: SponsorDetail(
                'test',
                'test',
                columNumber: 1,
              ),
            )
          ],
        )));
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: getValueForScreenType(
        context: context,
        mobile: MediaQuery.of(context).size.width * 4 / 9,
        tablet: MediaQuery.of(context).size.width / 7,
      ),
      // menuHeight: 20,
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return value == "All Sponsors"
            ? DropdownMenuEntry<String>(
                value: value,
                label: value,
                leadingIcon: dropdownValue == value
                    ? Image.asset("assets/images/ic_check_sponsor.png")
                    : Image.asset("assets/images/ic_nocheck_sponsor.png"))
            : DropdownMenuEntry<String>(
                value: value,
                label: value,
                leadingIcon: dropdownValue == value
                    ? Image.asset("assets/images/ic_check_sponsor.png")
                    : Image.asset("assets/images/ic_nocheck_sponsor.png"),
                trailingIcon: value == "Diamond"
                    ? Image.asset("assets/images/ic_diamond_sponsor.png")
                    : value == "Platinum"
                        ? Image.asset("assets/images/ic_platinum_sponsor.png")
                        : value == "Gold"
                            ? Image.asset("assets/images/ic_gold_sponsor.png")
                            : Image.asset(
                                "assets/images/ic_silver_sponsor.png"));
      }).toList(),
    );
  }
}
