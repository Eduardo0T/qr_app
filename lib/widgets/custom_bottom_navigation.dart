import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/ui_provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UIProvider>(context);

    final cureentIndex = uiProvider.selectedIndex;
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedIndex = i,
      currentIndex: cureentIndex,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.map),label: 'Mapa'),
      BottomNavigationBarItem(icon: Icon(Icons.compass_calibration_rounded),label: 'Direcciones')
    ],);
  }
}