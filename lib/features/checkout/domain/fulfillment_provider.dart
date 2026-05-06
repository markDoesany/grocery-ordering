import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

enum FulfillmentType { pickup, delivery }

class FulfillmentLocation {
  const FulfillmentLocation({
    required this.latlng,
    required this.addressLabel,
  });

  final LatLng latlng;
  final String addressLabel;
}

class FulfillmentState {
  const FulfillmentState({
    this.type = FulfillmentType.pickup,
    this.location,
  });

  final FulfillmentType type;
  final FulfillmentLocation? location;

  bool get isDelivery => type == FulfillmentType.delivery;
  bool get hasLocation => location != null;

  FulfillmentState copyWith({
    FulfillmentType? type,
    FulfillmentLocation? location,
    bool clearLocation = false,
  }) {
    return FulfillmentState(
      type: type ?? this.type,
      location: clearLocation ? null : (location ?? this.location),
    );
  }
}

class FulfillmentNotifier extends StateNotifier<FulfillmentState> {
  FulfillmentNotifier() : super(const FulfillmentState());

  void setType(FulfillmentType type) {
    state = state.copyWith(type: type);
  }

  void setLocation(FulfillmentLocation location) {
    state = state.copyWith(location: location);
  }

  void clearLocation() {
    state = state.copyWith(clearLocation: true);
  }
}

final fulfillmentProvider =
    StateNotifierProvider<FulfillmentNotifier, FulfillmentState>(
  (_) => FulfillmentNotifier(),
);
