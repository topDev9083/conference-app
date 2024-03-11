import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../widgets/image.dart';
import '../../../widgets/sponsors/iconValue.dart';
import '../../../widgets/sponsors/sponsor_detail_item.dart';
import '../../../utils/flutter_flow/flutter_flow_theme.dart';
import '../../../widgets/static_grid.dart';
import 'bloc/sponsors_bloc.dart';

class SponsorDetail extends StatelessWidget {
  final String organization;
  final String? boothNumber;
  final int? columNumber;
  const SponsorDetail(
    this.organization,
    String s, {
    this.boothNumber,
    this.columNumber,
  });

  @override
  Widget build(final BuildContext context) {
    final Map<String, dynamic> items = {
      'id': 1,
      'name': 'Mobile Sentrix',
      'list': ["1", "2", "3", "4", "5", "6"]
    };
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: getValueForScreenType(
            context: context,
            mobile: 0,
            tablet: 180,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center, // Center children in the Stack
            children: [
              Container(
                child: Column(
                  children: [
                    WCImage(
                      image: 'blancco_sponsor_1.png',
                      width: double.infinity,
                      height: getValueForScreenType(
                        context: context,
                        mobile: 300 / 2,
                        tablet: 300,
                      ),
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: getValueForScreenType(
                            context: context,
                            mobile: 10,
                            tablet: 250,
                          ),
                          top: getValueForScreenType(
                            context: context,
                            mobile: 100,
                            tablet: 20,
                          ),
                          bottom: 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Mobile Sentrix",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 12, 12, 12),
                                    fontSize: getValueForScreenType(
                                      context: context,
                                      mobile: 18,
                                      desktop: 25,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                getValueForScreenType(
                                    context: context,
                                    mobile: Container(child: null),
                                    desktop: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        height: getValueForScreenType(
                                          context: context,
                                          mobile: 20,
                                          desktop: 28,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE8F3FF),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          border: Border.all(
                                            color: Color(0xFFA1D2F2),
                                          ),
                                        ),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: getValueForScreenType(
                                                  context: context,
                                                  mobile: 18,
                                                  desktop: 24.0,
                                                ),
                                                height: getValueForScreenType(
                                                  context: context,
                                                  mobile: 18,
                                                  desktop: 24.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: Image.asset(
                                                      'assets/images/ic_diamond_sponsor.png',
                                                    ).image,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'DIAMOND SPONSOR  ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color:
                                                              Color(0xFF21446A),
                                                          fontSize:
                                                              getValueForScreenType(
                                                            context: context,
                                                            mobile: 10,
                                                            desktop: 12.0,
                                                          ),
                                                          fontWeight:
                                                              getValueForScreenType(
                                                            context: context,
                                                            mobile:
                                                                FontWeight.w400,
                                                            desktop:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                  )),
                                            ]),
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              // "mobilesentrix.com" + columNumber.toString(),
                              "mobilesentrix.com",
                              style: TextStyle(
                                color: Color.fromARGB(255, 95, 95, 95),
                                fontSize: getValueForScreenType(
                                  context: context,
                                  mobile: 12,
                                  desktop: 15,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            getValueForScreenType(
                              context: context,
                              mobile: const SizedBox(height: 15),
                              desktop: const SizedBox(height: 20),
                            ),
                            Text(
                              "Mobilesentrix is a trusted wholesale suppliers for Apple product Parts and Replacement Parts.",
                              style: TextStyle(
                                  fontSize: getValueForScreenType(
                                    context: context,
                                    mobile: 12,
                                    desktop: 15,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(220, 65, 64, 64)),
                            ),
                            getValueForScreenType(
                              context: context,
                              mobile: const SizedBox(height: 15),
                              desktop: const SizedBox(height: 20),
                            ),
                            getValueForScreenType(
                                context: context,
                                mobile: const Column(
                                  children: [
                                    IconValue(
                                      icon: 'ic_pin',
                                      name: ' ',
                                      value:
                                          "Manchester, Kentucky , United States",
                                    ),
                                    const SizedBox(height: 10),
                                    IconValue(
                                      icon: 'ic_phone',
                                      name: ' ',
                                      value: "(831) 522-5847",
                                      // onTap: organization.phoneNumber == null
                                      //     ? null
                                      //     : () => launchUrl(
                                      //         'tel:${organization.phoneNumber}'),
                                    ),
                                    const SizedBox(height: 10),
                                    IconValue(
                                      icon: 'ic_globe',
                                      name: ' ',
                                      value: "15",
                                      // onTap: organization.website == null
                                      //     ? null
                                      //     : () => launchUrl(organization.website!),
                                    ),
                                  ],
                                ),
                                desktop: Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: IconValue(
                                              icon: 'ic_pin',
                                              name: 'Location: ',
                                              value:
                                                  "Manchester, Kentucky , United States",
                                            )),
                                        Expanded(
                                            flex: 4,
                                            child: IconValue(
                                              icon: 'ic_phone',
                                              name: 'Phone number: ',
                                              value: "(831) 522-5847",
                                              // onTap: organization.phoneNumber == null
                                              //     ? null
                                              //     : () => launchUrl(
                                              //         'tel:${organization.phoneNumber}'),
                                            )),
                                        Expanded(
                                            flex: 4,
                                            child: IconValue(
                                              icon: 'ic_globe',
                                              name: 'Booth number: ',
                                              value: "15",
                                            ))
                                      ]),
                                )),
                            SizedBox(
                              height: getValueForScreenType(
                                context: context,
                                mobile: 0,
                                desktop: 20.0,
                              ),
                            ),
                            getValueForScreenType(
                              context: context,
                              mobile: Container(
                                child: null,
                              ),
                              desktop: Container(
                                width: double.infinity,
                                height: 1.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                            ),
                            Padding(
                                padding: getValueForScreenType(
                                  context: context,
                                  mobile: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 20.0),
                                  desktop: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 30.0),
                                ),
                                child: Text(
                                  "Colleagues (8)",
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: getValueForScreenType(
                                          context: context,
                                          mobile: 16,
                                          desktop: 20.0,
                                        ),
                                        fontWeight: getValueForScreenType(
                                          context: context,
                                          mobile: FontWeight.w400,
                                          desktop: FontWeight.w600,
                                        ),
                                      ),
                                )),
                            Container(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 10.0),
                                child: StaticGrid(
                                  spacing: 10,
                                  runSpacing: 10,
                                  columns: getValueForScreenType(
                                    context: context,
                                    mobile: 2,
                                    tablet: 4,
                                  ),
                                  children: List<Widget>.from(items['list']
                                      .map((sponsor) => SponsorDetailItem(
                                            'test',
                                            'test',
                                            columNumber: 1,
                                          ))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // The second child positions the container at the very bottom
              // of the parent Stack.
              Positioned(
                left: getValueForScreenType(
                  context: context,
                  mobile: 10,
                  desktop: 30,
                ),
                top: getValueForScreenType(
                  context: context,
                  mobile: 160,
                  tablet: 320,
                ),
                child: Container(
                  height: getValueForScreenType(
                    context: context,
                    mobile: 75,
                    tablet: 150,
                  ),
                  width: getValueForScreenType(
                    context: context,
                    mobile: 100,
                    tablet: 200,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.none,
                      image: Image.asset(
                        'assets/images/logo_mobile_sentrix.png',
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Color(0xFFDDDCE0),
                    ),
                  ),
                  // color: Color.fromARGB(255, 136, 136, 136),
                  // child: Text(
                  //   "S sentrix",
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.headline5!.copyWith(
                  //         color: Color.fromARGB(255, 240, 6, 6),
                  //       ),
                  // ),
                ),
              ),
              Positioned(
                right: getValueForScreenType(
                  context: context,
                  mobile: 10,
                  desktop: 20,
                ),
                top: getValueForScreenType(
                  context: context,
                  mobile: 160,
                  tablet: 320,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Visit Website',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: getValueForScreenType(
                              context: context,
                              mobile: 10,
                              desktop: 12.0,
                            ),
                            fontWeight: getValueForScreenType(
                              context: context,
                              mobile: FontWeight.w400,
                              desktop: FontWeight.w600,
                            ),
                          )),
                ),
              ),
              getValueForScreenType(
                context: context,
                mobile: Positioned(
                    left: 10,
                    top: 10,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      child: Container(
                        height: getValueForScreenType(
                          context: context,
                          mobile: 20,
                          desktop: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F3FF),
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(
                            color: Color(0xFFA1D2F2),
                          ),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: getValueForScreenType(
                              context: context,
                              mobile: 18,
                              desktop: 24.0,
                            ),
                            height: getValueForScreenType(
                              context: context,
                              mobile: 18,
                              desktop: 24.0,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.asset(
                                  'assets/images/ic_diamond_sponsor.png',
                                ).image,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'DIAMOND  ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF21446A),
                                      fontSize: getValueForScreenType(
                                        context: context,
                                        mobile: 10,
                                        desktop: 12.0,
                                      ),
                                      fontWeight: getValueForScreenType(
                                        context: context,
                                        mobile: FontWeight.w400,
                                        desktop: FontWeight.w600,
                                      ),
                                    ),
                              )),
                        ]),
                      ),
                    )),
                desktop: Container(child: null),
              ),
            ],
          ),
        ));
  }
}
