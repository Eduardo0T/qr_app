import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8DEF','cancel',false,ScanMode.QR);
        //final barcodeScanRes = 'https://www.google.com/?hl=es';

        if(barcodeScanRes == '-1'){
          return;
        }
        final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
       // scanListProvider.nuevoScan('geo:51.49728723295458,-115.92650051875054');

      },
      child: const Icon(Icons.qr_code_scanner),
    );
  }
}