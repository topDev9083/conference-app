import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/colors.dart';
import '../../../models/data/grouped_sponsors_data.dart';
import '../../../utils/flutter_flow/flutter_flow_drop_down.dart';
import '../../../widgets/organization_item.dart';
import '../../../widgets/sponsors/sponsor_diamond_item.dart';
import '../../../widgets/sponsors/sponsor_platinum_item.dart';
import '../../../widgets/sponsors/sponsor_Gold_item.dart';
import '../../../widgets/sponsors/sponsor_Silver_item.dart';
import '../../../utils/flutter_flow/flutter_flow_theme.dart';
import '../../../widgets/static_grid.dart';
import 'bloc/sponsors_bloc.dart';
import 'bloc/sponsors_state.dart';

List<String> list = <String>['All Sponsors', 'Diamond', 'Platinum', 'Gold'];

class SponsorsList extends StatelessWidget {
  const SponsorsList();

  @override
  Widget build(final BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        'id': 1,
        'name': 'Diamond',
        'list': [
          "1",
        ]
      },
      {
        'id': 2,
        'name': 'Platinum',
        'list': ["1", "2", "3"]
      },
      {
        'id': 3,
        'name': 'Gold',
        'list': ["1", "2", "3"]
      },
      {
        'id': 4,
        'name': 'Silver',
        'list': ["1", "2", "3", "4"]
      },
    ];

    // return _HeaderSponsors();
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _GroupedSponsorsItem(items[index]);
      },
    );
  }
}

class _GroupedSponsorsItem extends StatelessWidget {
  final Map<String, dynamic> group;

  const _GroupedSponsorsItem(this.group);

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (group != null) ...[
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: (Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          group['name'].toString().toUpperCase() +
                              ' SPONSOR ' +
                              " (" +
                              group['id'].toString() +
                              ")",
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF677085),
                                    fontSize: getValueForScreenType(
                                      context: context,
                                      mobile: 10.0,
                                      tablet: 17.0,
                                    ),
                                    letterSpacing: 0.26,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.54,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
        ],
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StaticGrid(
            spacing: 20,
            runSpacing: 20,
            columns: getValueForScreenType(
              context: context,
              mobile: group['id'] == 3 ? 2 : 1,
              tablet: group['id'],
            ),
            children: List<Widget>.from(group['id'] == 1
                ? group['list'].map((sponsor) => SponsorDiamondItem(
                      'test',
                      'test',
                      columNumber: group['id'],
                    ))
                : group['id'] == 2
                    ? group['list'].map((sponsor) => SponsorPlatinumItem(
                          'test',
                          'test',
                          columNumber: group['id'],
                        ))
                    : group['id'] == 3
                        ? group['list'].map((sponsor) => SponsorGoldItem(
                              'test',
                              'test',
                              columNumber: group['id'],
                            ))
                        : group['list'].map((sponsor) => SponsorSilverItem(
                              'test',
                              'test',
                              columNumber: group['id'],
                            ))),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _HeaderSponsors extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        child: getValueForScreenType(
            context: context,
            mobile: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 5.0, 0.0, 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text('Sponsors',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                )
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
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Text('Sponsors',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
    ]);
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
        mobile: MediaQuery.of(context).size.width * 2 / 5,
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
              )
            : DropdownMenuEntry<String>(
                value: value,
                label: value,
                trailingIcon:
                    Image.asset("assets/images/ic_diamond_sponsor.png"));
      }).toList(),
    );
  }
}
