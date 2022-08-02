import 'package:flutter/material.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchingUrl(BuildContext context, ScanModel scan) async {

  if(scan.type == 'http') {
    final Uri _url = Uri.parse(scan.value);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }else {
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }
}