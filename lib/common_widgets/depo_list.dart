import 'package:depo_app/services/depo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DepoList extends StatefulWidget {
  const DepoList({Key? key}) : super(key: key);

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
    List<dynamic> depos = await DepoService.getAllNoGdpr();

    setState(() {
      if(depos.isEmpty){
        displayWidget = ListView(
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
        );
        return;
      }

      displayWidget = ListView.builder(
          itemCount: depos.length,
          prototypeItem: ListTile(
            title: Text(depos.first['_id']),
            subtitle: Text(depos.first['depo_status']),
          ),
          itemBuilder: (context, index){
            return ListTile(
              title: Text(depos[index]['_id']),
              subtitle: Text(depos[index]['depo_status']),
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Depozyt numer ${depos[index]['_id']}'),
                          const SizedBox(height: 5,),
                          Text('SDM ${depos[index]['sdm']}'),
                          const SizedBox(height: 5,),
                          Text('Status: ${depos[index]['depo_status']}'),
                          const SizedBox(height: 5,),
                          Text('Ważny do: ${depos[index]['valid_to']}'),
                        ],
                      ),
                    ),
                  )
                )
              )
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
