import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/flutter_flow/flutter_flow_theme.dart';
import '../../../pages/home/sponsors/bloc/sponsors_bloc.dart';
import '../image.dart';
import '../static_grid.dart';
import '../user_container.dart';
import './iconValue.dart';

class SponsorDetailItem extends StatelessWidget {
  final String organization;
  final String? boothNumber;
  final int? columNumber;
  const SponsorDetailItem(
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
      child: Stack(
        alignment: Alignment.center, // Center children in the Stack
        children: [
          UserContainer(
            child: Column(
              children: [
                WCImage(
                  image: 'ronald_sponsor.png',
                  width: double.infinity,
                  height: getValueForScreenType(
                    context: context,
                    mobile: 300 / 2,
                    tablet: 300,
                  ),
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 20,
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
                        Text(
                          // "mobilesentrix.com" + columNumber.toString(),
                          "Ronald Richards",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: getValueForScreenType(
                              context: context,
                              mobile: 25,
                              desktop: 35,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        getValueForScreenType(
                          context: context,
                          mobile: const SizedBox(height: 10),
                          desktop: const SizedBox(height: 20),
                        ),
                        Text(
                          // "mobilesentrix.com" + columNumber.toString(),
                          "Founder",
                          style: TextStyle(
                            color: Color.fromARGB(255, 93, 92, 92),
                            fontSize: getValueForScreenType(
                              context: context,
                              mobile: 15,
                              desktop: 20,
                            ),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        getValueForScreenType(
                          context: context,
                          mobile: const SizedBox(height: 15),
                          desktop: const SizedBox(height: 25),
                        ),
                        Row(
                          children: [
                            WCImage(
                              image: 'ic_calendar_sponsor.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 10),
                            WCImage(
                              image: 'ic_notice_sponsor.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
