import 'package:flutter/material.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel?> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async{
    final nuevoScan = ScanModel(value: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    nuevoScan.id = id;

    if(this.tipoSeleccionado == nuevoScan.type){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }
  cargarTodosScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }
  CargarScansPorTipo(String tipo) async{
    final scans = await DBProvider.db.getScansByType(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }
  BorrarScans() async{
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }
  borrarScansPorId(int? id) async{
    await DBProvider.db.deleteScans(id);
    CargarScansPorTipo(tipoSeleccionado);
    notifyListeners();
  }
}