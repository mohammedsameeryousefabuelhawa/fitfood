// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class MapsScreen extends StatefulWidget {
//   const MapsScreen({super.key});
//
//   @override
//   State<MapsScreen> createState() => _MapsScreenState();
// }
//
// class _MapsScreenState extends State<MapsScreen> {
//   List<Marker> list = [
//     Marker(
//       markerId: MarkerId("1"),
//       position: LatLng(31.986114522800694, 35.89673658597352),
//     ),
//     Marker(
//       markerId: MarkerId("2"),
//       position: LatLng(31.98644439526448, 35.89798113087176),
//     ),
//     Marker(
//       markerId: MarkerId("3"),
//       position: LatLng(31.985199973629562, 35.89666684854388),
//     )
//   ];
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: GoogleMap(
//         onTap: (argument) {
//           print("argument.latitude + ${argument.latitude}");
//         },
//         mapType: MapType.hybrid,
//         markers: list.toSet(),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         initialCameraPosition: CameraPosition(
//             target: LatLng(31.985463874326182, 35.897965087898484), zoom: 14),
//       ),
//     );
//   }
// }
