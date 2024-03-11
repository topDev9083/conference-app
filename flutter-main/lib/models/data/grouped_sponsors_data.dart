import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'sponsor_data.dart';
import 'sponsorship_level_data.dart';

part 'grouped_sponsors_data.g.dart';

abstract class GroupedSponsorsData
    implements Built<GroupedSponsorsData, GroupedSponsorsDataBuilder> {
  factory GroupedSponsorsData([
    final void Function(GroupedSponsorsDataBuilder) updates,
  ]) = _$GroupedSponsorsData;

  GroupedSponsorsData._();

  static void _initializeBuilder(final GroupedSponsorsDataBuilder b) => b;

  SponsorshipLevelData? get sponsorshipLevel;

  BuiltList<SponsorData> get sponsors;

  static BuiltList<GroupedSponsorsData> fromSponsors(
    final BuiltList<SponsorData> sponsors,
  ) {
    final groupedSponsors = <GroupedSponsorsDataBuilder>[];
    for (final sponsor in sponsors) {
      GroupedSponsorsDataBuilder bGS;
      if (groupedSponsors.isEmpty ||
          groupedSponsors.last.sponsorshipLevel.id !=
              sponsor.sponsorshipLevelId) {
        bGS = GroupedSponsorsDataBuilder();
        bGS.sponsorshipLevel = sponsor.sponsorshipLevel!.toBuilder();
        groupedSponsors.add(bGS);
      } else {
        bGS = groupedSponsors.last;
      }
      bGS.sponsors.add(sponsor);
    }

    return BuiltList<GroupedSponsorsData>(
      groupedSponsors.map((final b) => b.build()),
    );
  }
}
