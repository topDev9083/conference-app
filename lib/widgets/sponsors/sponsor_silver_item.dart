import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/flutter_flow/flutter_flow_theme.dart';
import '../image.dart';
import '../static_grid.dart';
import '../user_container.dart';
import './iconValue.dart';

class SponsorSilverItem extends StatelessWidget {
  final String organization;
  final String? boothNumber;
  final int? columNumber;
  const SponsorSilverItem(
    this.organization,
    String s, {
    this.boothNumber,
    this.columNumber,
  });

  @override
  Widget build(final BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: getValueForScreenType(
            context: context,
            mobile: 0,
            tablet: 180,
          ),
        ),
        child: getValueForScreenType(
          context: context,
          mobile: Expanded(
            child: Container(
              width: 343.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 12.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 120.0,
                                      height: 90.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.none,
                                          image: Image.asset(
                                            'assets/images/logo_mobile_sentrix.png',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                          color: Color(0xFFDDDCE0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Bank of America',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF1A1A1A),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.01,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          lineHeight: 1.5,
                                                        ),
                                              ),
                                              Text(
                                                'mobilesentrix.com',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 12.0,
                                                          lineHeight: 1.33,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 0.0, 0.0),
                                        child: Container(
                                          height: 28.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF0F2F3),
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            border: Border.all(
                                              color: Color(0xFFC0CFFE),
                                            ),
                                          ),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 24.0,
                                                  height: 24.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: Image.asset(
                                                        'assets/images/ic_silver_sponsor.png',
                                                      ).image,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  'SILVER  ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF636B70),
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 12.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 18.0,
                                            height: 18.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/ic_pin.png',
                                                ).image,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Manchester, Kentucky, United States',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.12,
                                                  lineHeight: 1.33,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 18.0,
                                              height: 18.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/ic_globe.png',
                                                  ).image,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '15',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.01,
                                                        lineHeight: 1.33,
                                                      ),
                                            ),
                                          ]),
                                    ),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 18.0,
                                      height: 18.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                            'assets/images/ic_phone.png',
                                          ).image,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '(747) 772-9102',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 12.0,
                                            letterSpacing: 0.12,
                                            lineHeight: 1.33,
                                          ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          tablet: Stack(
            alignment: Alignment.center, // Center children in the Stack
            children: [
              UserContainer(
                // onTap: () => OrganizationDetailDrawer.open(
                //   context,
                //   organization: organization,
                //   boothNumber: boothNumber,
                // ),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 10,
                          top: 90,
                          bottom: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mobile Sentrix",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 12, 12, 12),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              // "mobilesentrix.com" + columNumber.toString(),
                              "mobilesentrix.com",
                              style: TextStyle(
                                color: Color.fromARGB(255, 95, 95, 95),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 248, 248, 244),
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 222, 222, 221)),
                                      ),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: Image.asset(
                                                    'assets/images/ic_silver_sponsor.png',
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
                                                  'SILVER SPONSOR  ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Color.fromARGB(
                                                            255, 87, 87, 82),
                                                        fontSize: 11.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                )),
                                          ]),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            StaticGrid(
                              spacing: 20,
                              runSpacing: 20,
                              columns: 1,
                              children: [
                                Column(
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
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Sponsor details',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF057CC9),
                                            fontSize: 12.0,
                                            letterSpacing: 0.12,
                                            fontWeight: FontWeight.w400,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 3.0, 0.0, 0.0),
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/ic_mobile_sponsor.png',
                                            ).image,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
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
                left: 20,
                top: 10,
                child: Container(
                  height: 80,
                  width: 120,
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
                ),
              )
            ],
          ),
        ));
  }
}
