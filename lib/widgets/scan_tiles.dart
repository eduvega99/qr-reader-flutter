import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({
    Key? key, 
    required this.type
  });

  @override
  Widget build(BuildContext context) {

    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) => {
          Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[index].id!)
        },
        child: ListTile(
          leading: Icon(
            this.type == 'http' ? Icons.http : Icons.room,
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[index].value),
          subtitle: Text(scans[index].id!.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[index])
        ),
      )
    );
  }
}