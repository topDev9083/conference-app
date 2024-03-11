import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/flutter_flow/flutter_flow_theme.dart';
import '../image.dart';
import '../static_grid.dart';
import '../user_container.dart';
import './iconValue.dart';

class SponsorGoldItem extends StatelessWidget {
  final String organization;
  final String? boothNumber;
  final int? columNumber;
  const SponsorGoldItem(
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
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 148.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/cisco_sponsor_2.png',
                                ).image,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 72.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 120.0,
                                    height: 90.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.none,
                                        image: Image.asset(
                                          'assets/images/logo_cisco.png',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                        color: Color(0xFFDDDCE0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 226.0, 0.0, 0.0),
                            child: Container(
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF6E2),
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: Color(0xFFFFE9B9),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 18.0,
                                      height: 18.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: Image.asset(
                                            'assets/images/ic_gold_sponsor.png',
                                          ).image,
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFE5AC),
                                            Color(0xFFFFE5AC)
                                          ],
                                          stops: [0.0, 1.0],
                                          begin: AlignmentDirectional(1.0, 0.0),
                                          end: AlignmentDirectional(-1.0, 0),
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      'GOLD ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Color(0xFF5B4005),
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600,
                                            lineHeight: 1.54,
                                          ),
                                    ),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 178.0, 0.0, 0.0),
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cisco',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF1A1A1A),
                                          fontSize: 16.0,
                                          letterSpacing: 0.02,
                                          fontWeight: FontWeight.w600,
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                  Text(
                                    'mobilesentrix.com',
                                    style: FlutterFlowTheme.of(context)
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
                                8.0, 258.0, 0.0, 0.0),
                            child: IconValue(
                              icon: 'ic_pin',
                              name: ' ',
                              value: "Manchester, Kentucky , United States",
                            ),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 306.0, 0.0, 0.0),
                              child: IconValue(
                                icon: 'ic_phone',
                                name: ' ',
                                value: "(831) 522-5847",
                                // onTap: organization.phoneNumber == null
                                //     ? null
                                //     : () => launchUrl(
                                //         'tel:${organization.phoneNumber}'),
                              )),
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 336.0, 0.0, 0.0),
                              child: IconValue(
                                icon: 'ic_globe',
                                name: ' ',
                                value: "15",
                                // onTap: organization.website == null
                                //     ? null
                                //     : () => launchUrl(organization.website!),
                              )),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 373.0, 0.0, 16.0),
                            child: Container(
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
                                            lineHeight: 1.0,
                                          ),
                                    ),
                                    Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                            'assets/images/ic_mobile_sponsor.png',
                                          ).image,
                                        ),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: WCImage(
                        image: 'cisco_sponsor_1.png',
                        width: double.infinity,
                        height: 120,
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
                                  "Cisco",
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
                                      color: Color.fromARGB(255, 255, 253, 232),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 242, 235, 161),
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
                                                  'assets/images/ic_gold_sponsor.png',
                                                ).image,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Gold SPONSOR  ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Color.fromARGB(
                                                              255, 89, 82, 0),
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
                              "mobilesentrix.com",
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
                                      "Mobilesentrix is a trusted wholesale suppliers for Apple product Parts and Replacement Parts.",
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
                  height: 80,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.none,
                      image: Image.asset(
                        'assets/images/logo_cisco.png',
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
