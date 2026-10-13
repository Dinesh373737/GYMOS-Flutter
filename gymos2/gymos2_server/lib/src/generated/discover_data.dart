/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gymos2_server/src/generated/protocol.dart' as _ib35fuo1;
import 'package:serverpod/serverpod.dart' as _is;
import 'community_event.dart' as _inypuiwd;
import 'external_event_cache.dart' as _imhmmzbr;

abstract class DiscoverData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoverData._({
    required this.community,
    required this.externalEvents,
    required this.joinedEventIds,
    required this.providerStatus,
    String? providerState,
    this.supportedCities,
    this.participantCounts,
  }) : providerState = providerState ?? 'unconfigured';

  factory DiscoverData({
    required List<_inypuiwd.CommunityEvent> community,
    required List<_imhmmzbr.ExternalEventCache> externalEvents,
    required List<int> joinedEventIds,
    required String providerStatus,
    String? providerState,
    List<String>? supportedCities,
    Map<int, int>? participantCounts,
  }) = _DiscoverDataImpl;

  factory DiscoverData.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverData(
      community: _ib35fuo1.Protocol()
          .deserialize<List<_inypuiwd.CommunityEvent>>(
            jsonSerialization['community'],
          ),
      externalEvents: _ib35fuo1.Protocol()
          .deserialize<List<_imhmmzbr.ExternalEventCache>>(
            jsonSerialization['externalEvents'],
          ),
      joinedEventIds: _ib35fuo1.Protocol().deserialize<List<int>>(
        jsonSerialization['joinedEventIds'],
      ),
      providerStatus: jsonSerialization['providerStatus'] as String,
      providerState: jsonSerialization['providerState'] as String?,
      supportedCities: jsonSerialization['supportedCities'] == null
          ? null
          : _ib35fuo1.Protocol().deserialize<List<String>>(
              jsonSerialization['supportedCities'],
            ),
      participantCounts: jsonSerialization['participantCounts'] == null
          ? null
          : _ib35fuo1.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['participantCounts'],
            ),
    );
  }

  List<_inypuiwd.CommunityEvent> community;

  List<_imhmmzbr.ExternalEventCache> externalEvents;

  List<int> joinedEventIds;

  String providerStatus;

  String providerState;

  List<String>? supportedCities;

  Map<int, int>? participantCounts;

  /// Returns a shallow copy of this [DiscoverData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoverData copyWith({
    List<_inypuiwd.CommunityEvent>? community,
    List<_imhmmzbr.ExternalEventCache>? externalEvents,
    List<int>? joinedEventIds,
    String? providerStatus,
    String? providerState,
    List<String>? supportedCities,
    Map<int, int>? participantCounts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverData',
      'community': community.toJson(valueToJson: (v) => v.toJson()),
      'externalEvents': externalEvents.toJson(valueToJson: (v) => v.toJson()),
      'joinedEventIds': joinedEventIds.toJson(),
      'providerStatus': providerStatus,
      'providerState': providerState,
      if (supportedCities != null) 'supportedCities': supportedCities?.toJson(),
      if (participantCounts != null)
        'participantCounts': participantCounts?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverData',
      'community': community.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'externalEvents': externalEvents.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'joinedEventIds': joinedEventIds.toJson(),
      'providerStatus': providerStatus,
      'providerState': providerState,
      if (supportedCities != null) 'supportedCities': supportedCities?.toJson(),
      if (participantCounts != null)
        'participantCounts': participantCounts?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverDataImpl extends DiscoverData {
  _DiscoverDataImpl({
    required List<_inypuiwd.CommunityEvent> community,
    required List<_imhmmzbr.ExternalEventCache> externalEvents,
    required List<int> joinedEventIds,
    required String providerStatus,
    String? providerState,
    List<String>? supportedCities,
    Map<int, int>? participantCounts,
  }) : super._(
         community: community,
         externalEvents: externalEvents,
         joinedEventIds: joinedEventIds,
         providerStatus: providerStatus,
         providerState: providerState,
         supportedCities: supportedCities,
         participantCounts: participantCounts,
       );

  /// Returns a shallow copy of this [DiscoverData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoverData copyWith({
    List<_inypuiwd.CommunityEvent>? community,
    List<_imhmmzbr.ExternalEventCache>? externalEvents,
    List<int>? joinedEventIds,
    String? providerStatus,
    String? providerState,
    Object? supportedCities = _Undefined,
    Object? participantCounts = _Undefined,
  }) {
    return DiscoverData(
      community:
          community ?? this.community.map((e0) => e0.copyWith()).toList(),
      externalEvents:
          externalEvents ??
          this.externalEvents.map((e0) => e0.copyWith()).toList(),
      joinedEventIds:
          joinedEventIds ?? this.joinedEventIds.map((e0) => e0).toList(),
      providerStatus: providerStatus ?? this.providerStatus,
      providerState: providerState ?? this.providerState,
      supportedCities: supportedCities is List<String>?
          ? supportedCities
          : this.supportedCities?.map((e0) => e0).toList(),
      participantCounts: participantCounts is Map<int, int>?
          ? participantCounts
          : this.participantCounts?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
    );
  }
}
