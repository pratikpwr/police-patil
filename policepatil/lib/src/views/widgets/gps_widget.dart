import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

class GPSWidget extends StatefulWidget {
  const GPSWidget(this.longitude, this.latitude, {Key? key}) : super(key: key);

  final String longitude;
  final String latitude;

  @override
  _GPSWidgetState createState() => _GPSWidgetState();
}

class _GPSWidgetState extends State<GPSWidget> {
  Position? _position;

  @override
  Widget build(BuildContext context) {
    String _long = widget.longitude;
    String _lat = widget.latitude;
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.37,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey)),
          child: Text(
            _long,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.37,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey)),
          child: Text(
            _lat,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                  10,
                ))),
            onPressed: () async {
              _position = await determinePosition();
              setState(() {
                _long = _position!.longitude.toString();
                _lat = _position!.latitude.toString();
              });
            },
            child: const Icon(
              Icons.location_on_rounded,
              size: 28,
            ))
      ],
    );
  }
}

Widget gpsWidget(BuildContext context, String _long, String _lat) {
  Position? _position;
  return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.37,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Text(
          _long,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.37,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Text(
          _lat,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                10,
              ))),
          onPressed: () async {
            _position = await determinePosition();
            _long = _position!.longitude.toString();
            _lat = _position!.latitude.toString();
          },
          child: const Icon(
            Icons.location_on_rounded,
            size: 28,
          ))
    ],
  );
}
