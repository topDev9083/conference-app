import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/flutter_flow/flutter_flow_theme.dart';
import '../../../pages/home/sponsors/bloc/sponsors_bloc.dart';
import '../image.dart';
import '../static_grid.dart';
import '../user_container.dart';
import './iconValue.dart';

class SponsorDiamondItem extends StatelessWidget {
  final String organization;
  final String? boothNumber;
  final int? columNumber;
  const SponsorDiamondItem(
    this.organization,
    String s, {
    this.boothNumber,
    this.columNumber,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
        create: (final _) => SponsorsBloc(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: 180,
            ),
          ),
          child: Stack(
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
                        image: 'blancco_sponsor_1.png',
                        width: double.infinity,
                        height: getValueForScreenType(
                          context: context,
                          mobile: 300 / 2,
                          tablet: 300,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: getValueForScreenType(
                            context: context,
                            mobile: 10,
                            tablet: 230,
                          ),
                          top: getValueForScreenType(
                            context: context,
                            mobile: 20,
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
                                      mobile: 15,
                                      desktop: 25,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Padding(
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
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'DIAMOND SPONSOR  ',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF21446A),
                                                      fontSize:
                                                          getValueForScreenType(
                                                        context: context,
                                                        mobile: 10,
                                                        desktop: 12.0,
                                                      ),
                                                      fontWeight:
                                                          getValueForScreenType(
                                                        context: context,
                                                        mobile: FontWeight.w400,
                                                        desktop:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                              )),
                                        ]),
                                  ),
                                )
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
                                  mobile: 10,
                                  desktop: 15,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            getValueForScreenType(
                              context: context,
                              mobile: const SizedBox(height: 0),
                              desktop: const SizedBox(height: 20),
                            ),
                            StaticGrid(
                              spacing: 20,
                              runSpacing: 20,
                              columns: getValueForScreenType(
                                context: context,
                                mobile: 1,
                                tablet: 2,
                              ),
                              children: [
                                getValueForScreenType(
                                  context: context,
                                  mobile: const SizedBox(height: 0),
                                  desktop: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Mobilesentrix is a trusted wholesale suppliers for Apple product Parts and Replacement Parts.",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                220, 65, 64, 64)),
                                      ),
                                      getValueForScreenType(
                                        context: context,
                                        mobile: const SizedBox(height: 0),
                                        desktop: const SizedBox(height: 20),
                                      ),
                                    ],
                                  ),
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
                            const SizedBox(height: 20),
                            Builder(
                                builder: (final context) => GestureDetector(
                                    onTap: () {
                                      // Event handler code here
                                      SponsorsBloc.of(context).funSponsor("2");
                                    },
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
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFF057CC9),
                                                    fontSize:
                                                        getValueForScreenType(
                                                      context: context,
                                                      mobile: 14.0,
                                                      desktop: 16.0,
                                                    ),
                                                    letterSpacing: 0.12,
                                                    fontWeight:
                                                        getValueForScreenType(
                                                      context: context,
                                                      mobile: FontWeight.w400,
                                                      desktop: FontWeight.w500,
                                                    ),
                                                    lineHeight: 1.5,
                                                  ),
                                            ),
                                            Padding(
                                              padding: getValueForScreenType(
                                                context: context,
                                                mobile: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 3.0, 0.0, 0.0),
                                                desktop: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 3.0, 0.0, 0.0),
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
                                                      'assets/images/ic_mobile_sponsor.png',
                                                    ).image,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                    )))
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
                  mobile: 20,
                  desktop: 30,
                ),
                top: getValueForScreenType(
                  context: context,
                  mobile: 80,
                  tablet: 280,
                ),
                child: Container(
                  height: getValueForScreenType(
                    context: context,
                    mobile: 100,
                    tablet: 150,
                  ),
                  width: getValueForScreenType(
                    context: context,
                    mobile: 150,
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
              )
            ],
          ),
        ));
  }
}
