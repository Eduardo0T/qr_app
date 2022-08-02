import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/utils/utils.dart';

class DirectoriosScreen extends StatelessWidget {
  const DirectoriosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_,i) => Dismissible(
          key: UniqueKey(),
          onDismissed: (direction){
            Provider.of<ScanListProvider>(context,listen: false).borrarScansPorId(scans[i]!.id);
          },
          child: ListTile(
            leading: Icon(Icons.map,color: Theme.of(context).primaryColor,),
            title: Text(scans[i]!.value),
            subtitle: Text(scans[i]!.id.toString()),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              launchingUrl(context,scans[i]!);
            },
          ),
        ));
  }
}
