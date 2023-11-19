import 'package:depo_app/common_widgets/depo/depo_dialog.dart';
import 'package:depo_app/services/server/depo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DepoList extends StatefulWidget {
  const DepoList({Key? key, required this.sdm}) : super(key: key);

  final String sdm;

  @override
  State<DepoList> createState() => _DepoListState();
}

class _DepoListState extends State<DepoList> {

  late Color primary;
  late Color onPrimary;

  late Widget spinner = SpinKitWave(
      color: primary,
      size: 50
  );

  late Widget displayWidget = spinner;

  List<String> items = List<String>.generate(200, (index) => '$index/2023');


  void setupListView() async{
    List<dynamic> allDepos = await DepoService.getAllDepos(widget.sdm);
    List<dynamic> depos = [];

    for(dynamic depo in allDepos){
      if(depo['depo_status'] == 'ARCHIVED') continue;
      if(depo['depo_status'] == 'ARCHIVED_DISPOSED') continue;
      depos.add(depo);
    }

    setState(() {
      if(depos.isEmpty){
        displayWidget = Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              const Text(
                'Brak dostępnych depozytów.',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                    setState((){
                      displayWidget = spinner;
                      setupListView();
                    });
                  },
                  child: const Icon(Icons.refresh),
              ),
            ],
          ),
        );
        return;
      }

      displayWidget = ListView.builder(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        itemCount: depos.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(5.0),
              child: ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: DepoService.getDepoStatusIcon(depos[index]),
                ),
                title: Text('#${depos[index]['_id']} - ${depos[index]['first_name']} ${depos[index]['last_name']}', style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(DepoService.getStatusString(depos[index]['depo_status']).toUpperCase()),
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => DepoDialog(depo: depos[index])
                ),
                trailing: const SizedBox(
                  height: double.infinity,
                  child: Icon(Icons.info_outline),
                ),
              ),
            ),
          );
        }
      );
    });
  }

  @override
  void initState() {
    super.initState();
    setupListView();
  }

  @override
  Widget build(BuildContext context) {
    primary = Theme.of(context).colorScheme.primary;
    onPrimary = Theme.of(context).colorScheme.onPrimary;
    return displayWidget;
  }
}
