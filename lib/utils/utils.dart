import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_models.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
    final url = scan.value;
    if (scan.type == 'http') {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    } else {
      Navigator.pushNamed(context, 'map', arguments: scan);
    }
}