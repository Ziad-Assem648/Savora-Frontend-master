// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:location/location.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:miss_chef/Registration/Sign%20In.dart';

// class MapScreenchefs extends StatefulWidget {
//   const MapScreenchefs({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreenchefs> {
//   final MapController mapController = MapController();
//   LocationData? currentLocation;
//   List<Marker> markers = [];

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     var location = Location();

//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//     }

//     PermissionStatus permission = await location.hasPermission();
//     if (permission == PermissionStatus.denied) {
//       permission = await location.requestPermission();
//     }

//     if (permission != PermissionStatus.granted) return;

//     var userLocation = await location.getLocation();

//     setState(() {
//       currentLocation = userLocation;
//       markers.add(
//         Marker(
//           width: 80.0,
//           height: 80.0,
//           point: LatLng(userLocation.latitude!, userLocation.longitude!),
//           child: const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
//         ),
//       );
//     });

//     // اطبع العنوان مباشرة
//     _printAddress(userLocation.latitude!, userLocation.longitude!);

//     location.onLocationChanged.listen((newLocation) {
//       setState(() {
//         currentLocation = newLocation;
//       });
//     });
//   }

//   Future<void> _printAddress(double lat, double lng) async {
//     final url = Uri.parse(
//       "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lng",
//     );
//     final response = await http.get(
//       url,
//       headers: {
//         'User-Agent': 'miss_chef_app_1.0', // لازم تكتب User-Agent
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final displayName = data['display_name'];
//       print("Current Address: $displayName");
//     } else {
//       print("Failed to get address: ${response.statusCode}");
//     }
//   }

//   void _addDestinationMarker(LatLng point) {
//     setState(() {
//       markers.add(
//         Marker(
//           width: 80.0,
//           height: 80.0,
//           point: point,
//           child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
//         ),
//       );
//     });

//     // اطبع العنوان عند الضغط على الخريطة
//     _printAddress(point.latitude, point.longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentLocation == null
//           ? const Center(child: CircularProgressIndicator())
//           : FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//                 initialCenter: LatLng(
//                   currentLocation!.latitude!,
//                   currentLocation!.longitude!,
//                 ),
//                 initialZoom: 15.0,
//                 onTap: (tapPosition, point) => _addDestinationMarker(point),
//                 interactionOptions: const InteractionOptions(
//                   flags: InteractiveFlag.all,
//                 ),
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       "https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
//                 ),
//                 MarkerLayer(markers: markers),
//               ],
//             ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(right: 15),
//         child: Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SignIn()),
//                 );
//               },
//               backgroundColor: const Color.fromARGB(255, 84, 159, 240),
//               foregroundColor: Colors.white,
//               elevation: 6,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(Icons.arrow_back),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
