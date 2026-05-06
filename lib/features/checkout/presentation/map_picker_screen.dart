import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../domain/fulfillment_provider.dart';

const _kToken =
    'REMOVED';

const _kDefaultCenter = LatLng(14.5995, 120.9842); // Metro Manila

/// Full-screen map modal. User drags the map to position the crosshair pin.
/// Returns a [FulfillmentLocation] when confirmed, or null on cancel.
class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key, this.initial});

  /// Pre-center on a previously pinned location.
  final LatLng? initial;

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late final MapController _mapController;
  LatLng _center = _kDefaultCenter;
  String? _addressLabel;
  bool _loadingAddress = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _center = widget.initial ?? _kDefaultCenter;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMoveEnd || event is MapEventFlingAnimationEnd) {
      final newCenter = _mapController.camera.center;
      setState(() {
        _center = newCenter;
        _addressLabel = null;
      });
      _scheduleReverseGeocode(newCenter);
    }
  }

  void _scheduleReverseGeocode(LatLng latlng) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      _reverseGeocode(latlng);
    });
  }

  Future<void> _reverseGeocode(LatLng latlng) async {
    setState(() => _loadingAddress = true);
    try {
      final uri =
          'https://api.mapbox.com/geocoding/v5/mapbox.places/'
          '${latlng.longitude},${latlng.latitude}.json'
          '?access_token=$_kToken&limit=1&language=tl,en';
      final response = await Dio().get(uri);
      final features = response.data['features'] as List?;
      if (features != null && features.isNotEmpty) {
        final label = features.first['place_name'] as String?;
        if (mounted) setState(() => _addressLabel = label);
      }
    } catch (_) {
      // Silently fall back to coordinate display.
    } finally {
      if (mounted) setState(() => _loadingAddress = false);
    }
  }

  void _confirm() {
    Navigator.of(context).pop(
      FulfillmentLocation(
        latlng: _center,
        addressLabel:
            _addressLabel ??
            '${_center.latitude.toStringAsFixed(5)}, ${_center.longitude.toStringAsFixed(5)}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Stack(
        children: [
          // ── Map ──────────────────────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15.5,
              onMapEvent: _onMapEvent,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/streets-v12'
                    '/tiles/{z}/{x}/{y}@2x?access_token=$_kToken',
                tileSize: 512,
                zoomOffset: -1,
                userAgentPackageName: 'com.qappslock.grocery',
              ),
            ],
          ),

          // ── Crosshair pin (stays fixed at center) ────────────────────────
          const Center(
            child: _CrosshairPin(),
          ),

          // ── Top bar ──────────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    Material(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(8),
                      elevation: 2,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(Icons.arrow_back, color: cs.onSurface),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Material(
                        color: cs.surface,
                        borderRadius: BorderRadius.circular(8),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Text(
                            'I-pin ang iyong lokasyon',
                            style: tt.titleSmall?.copyWith(
                              color: cs.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Bottom confirm card ───────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Address preview
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: cs.error, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _loadingAddress
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: cs.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Hinahanap ang address…',
                                      style: tt.bodySmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _addressLabel ??
                                          'I-galaw ang mapa para i-pin ang lugar',
                                      style: tt.bodyMedium?.copyWith(
                                        color: cs.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${_center.latitude.toStringAsFixed(5)}, '
                                      '${_center.longitude.toStringAsFixed(5)}',
                                      style: tt.labelSmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Confirm button
                    _ConfirmButton(onTap: _confirm),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated crosshair drop-pin that stays fixed at map center.
class _CrosshairPin extends StatelessWidget {
  const _CrosshairPin();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pin icon
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: cs.error,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: cs.error.withValues(alpha: 0.40),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.location_pin, color: cs.onError, size: 22),
        ),
        // Drop shadow dot beneath pin
        const SizedBox(height: 2),
        Container(
          width: 8,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        // Offset upward so tip of pin aligns with map center
        const SizedBox(height: 18),
      ],
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Material(
      color: cs.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: cs.onPrimary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Kumpirmahin ang lokasyon',
                style: tt.labelLarge?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
