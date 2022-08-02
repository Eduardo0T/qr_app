import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/db_provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/screens/screens.dart';
import 'package:qr_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR App'),
        actions: [IconButton(onPressed: (){
          final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
          scanListProvider.BorrarScans();
        }, icon: const Icon(Icons.delete_forever))],
      ),
      body: _HomeBody(),
      bottomNavigationBar: const CustomBottomNavigation(),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UIProvider>(context);


    final currentIndex = uiProvider.selectedIndex;

    //final tempScan = ScanModel(value: 'https://google.com');
    //DBProvider.db.getScanById(2).then((value) => print(value!.value));
    
    //DBProvider.db.deleteAllScans().then(print);

    final scanlistprovider = Provider.of<ScanListProvider>(context,listen: false);
    
    switch( currentIndex ){
      case 0:
        scanlistprovider.CargarScansPorTipo('geo');
        return const MapasScreen();
      case 1:
        scanlistprovider.CargarScansPorTipo('http');
        return const DirectoriosScreen();
      default:
        return const MapasScreen();
    }
  }
}




