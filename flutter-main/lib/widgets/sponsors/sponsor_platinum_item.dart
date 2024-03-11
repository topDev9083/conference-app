import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/flutter_flow/flutter_flow_theme.dart';
import '../image.dart';
import '../static_grid.dart';
import '../user_container.dart';
import './iconValue.dart';

class SponsorPlatinumItem extends StatelessWidget {
  final String organization;
  final String? boothNumber;
  final int? columNumber;
  const SponsorPlatinumItem(
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
                    height: 194.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: 120.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            fit: BoxFit.none,
                                            image: Image.asset(
                                              'assets/images/bank_sponsor_2.png',
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          border: Border.all(
                                            color: Color(0xFFDDDCE0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 90.0, 0.0, 0.0),
                                      child: Container(
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
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.02,
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
                                                          lineHeight: 1.0,
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
                                          height: 22.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE2E9FF),
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
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: Image.asset(
                                                        'assets/images/ic_platinum_sponsor.png',
                                                      ).image,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  ' PLATINUM  ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            Color(0xFF162965),
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 0.0, 0.0),
                                        child: IconValue(
                                          icon: 'ic_pin',
                                          name: ' ',
                                          value:
                                              "Manchester, Kentucky , United States",
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 12.0, 0.0, 0.0),
                                          child: IconValue(
                                            icon: 'ic_phone',
                                            name: ' ',
                                            value: "(831) 522-5847",
                                            // onTap: organization.phoneNumber == null
                                            //     ? null
                                            //     : () => launchUrl(
                                            //         'tel:${organization.phoneNumber}'),
                                          )),
                                      const SizedBox(height: 3),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 12.0, 0.0, 0.0),
                                          child: IconValue(
                                            icon: 'ic_globe',
                                            name: ' ',
                                            value: "15",
                                            // onTap: organization.website == null
                                            //     ? null
                                            //     : () => launchUrl(organization.website!),
                                          )),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: WCImage(
                        image: 'bank_sponsor_1.png',
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 10,
                          top: 30,
                          bottom: 20,
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
                                  "Bank of America",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 12, 12, 12),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    height: 22,
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
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: Image.asset(
                                                  'assets/images/ic_platinum_sponsor.png',
                                                ).image,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'PLATNIUM SPONSOR  ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF21446A),
                                                      fontSize: 11.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              )),
                                        ]),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              // "mobilesentrix.com" + columNumber.toString(),
                              "bankofamerica.com",
                              style: TextStyle(
                                color: Color.fromARGB(255, 95, 95, 95),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            StaticGrid(
                              spacing: 20,
                              runSpacing: 20,
                              columns: 1,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Empowering financial dreams with trusted banking solutions and innovative services.",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(220, 65, 64, 64)),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconValue(
                                      icon: 'ic_pin',
                                      name: 'Location: ',
                                      value:
                                          "Manchester, Kentucky , United States",
                                    ),
                                    const SizedBox(height: 10),
                                    IconValue(
                                      icon: 'ic_phone',
                                      name: 'Phone number: ',
                                      value: "(831) 522-5847",
                                      // onTap: organization.phoneNumber == null
                                      //     ? null
                                      //     : () => launchUrl(
                                      //         'tel:${organization.phoneNumber}'),
                                    ),
                                    const SizedBox(height: 10),
                                    IconValue(
                                      icon: 'ic_globe',
                                      name: 'Booth number: ',
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
                                            fontSize: 15.0,
                                            letterSpacing: 0.12,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                    Padding(
                                      padding: getValueForScreenType(
                                        context: context,
                                        mobile: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 3.0, 0.0, 0.0),
                                      ),
                                      child: Container(
                                        width: 20,
                                        height: 20,
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
                top: 60,
                child: Container(
                  height: 120,
                  width: 160,
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
