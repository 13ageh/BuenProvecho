import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/screens/theme/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  String _mapStyle = '';
  String selectedFilter = "Todos";

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _loadMarkers();
  }

  // 🎨 Cargar JSON del estilo
  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString('assets/map_style.json');
    _mapStyle = style;
  }

  // 📍 Marcadores de ejemplo
  void _loadMarkers() {
    _markers.addAll([
      const Marker(
        markerId: MarkerId("mercado"),
        position: LatLng(19.4326, -99.1332),
        infoWindow: InfoWindow(title: "Mercado"),
      ),
      const Marker(
        markerId: MarkerId("comedor"),
        position: LatLng(19.434, -99.135),
        infoWindow: InfoWindow(title: "Comedor"),
      ),
      const Marker(
        markerId: MarkerId("tienda"),
        position: LatLng(19.431, -99.131),
        infoWindow: InfoWindow(title: "Tienda"),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 🗺️ MAPA
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(19.4326, -99.1332),
              zoom: 14,
            ),
            onMapCreated: (controller) {
              _mapController = controller;

              // 🔥 aplicar estilo aquí
              if (_mapStyle.isNotEmpty) {
                _mapController!.setMapStyle(_mapStyle);
              }
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // 🔝 HEADER
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Mapa de Lugares",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text("Encuentra opciones económicas cerca de ti"),
              ],
            ),
          ),

          // 🔘 FILTROS
          Positioned(
            top: 110,
            left: 20,
            child: Row(
              children: [
                _buildFilter("Todos"),
                _buildFilter("Mercado"),
                _buildFilter("Comedor"),
              ],
            ),
          ),

          // 📍 BOTÓN UBICACIÓN
          Positioned(
            right: 20,
            bottom: 100,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(Icons.navigation, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 Widget filtro
  Widget _buildFilter(String text) {
    final isSelected = selectedFilter == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5)
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}