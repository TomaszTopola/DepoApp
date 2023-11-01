import 'package:depo_app/services/depo_service.dart';
import 'package:depo_app/services/user_service.dart';
import 'package:depo_app/views/edit_depo.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DepoDialog extends StatefulWidget {
  const DepoDialog({Key? key, this.depo}) : super(key: key);

  final dynamic depo;

  @override
  State<DepoDialog> createState() => _DepoDialogState();
}

class _DepoDialogState extends State<DepoDialog> {
  
  String keeperName = "[pobieram dane...]";
  
  void getKeeperName() async {
    dynamic keeper = await UserService.getKeeperName(widget.depo['authorized_by']);
    setState(() {
      keeperName = '${keeper['first_name']} ${keeper['last_name']}';
    });
  }
  
  @override
  void initState() {
    super.initState();
    getKeeperName();
  }
  
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl');

    String depoDate = DateFormat.yMMMMd('pl')
        .format(DateFormat('yyyy-MM-ddTHH:mm:ssZ')
        .parse(widget.depo['depo_date'], false));
    String expiredDate = DateFormat.yMMMMd('pl')
        .format(DateFormat('yyyy-MM-ddTHH:mm:ssZ')
        .parse(widget.depo['valid_to'], false));

    // print(depo);
    return Dialog(
      // backgroundColor: Theme.of(context).colorScheme.background,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          // border: Border.all(
          //   color: Theme.of(context).colorScheme.primary,
          //   width: 1,
          //   style: BorderStyle.solid
          // )
        ),
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${widget.depo['_id']}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'SDM ${widget.depo['sdm']}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditDepo(depo: widget.depo,)
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Icon(Icons.edit,),
                    )
                  ],
                ),
                const SizedBox(height: 20,),

                Text(
                  'STATUS: ${DepoService.getStatusString(widget.depo['depo_status']).toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20,),

                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10,),
                    Text('${widget.depo['first_name']} ${widget.depo['last_name']}'),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Icon(Icons.email),
                    const SizedBox(width: 10,),
                    Text('${widget.depo['mail']}'),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 10,),
                    Text('${widget.depo['phone']}'),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Icon(Icons.badge),
                    const SizedBox(width: 10,),
                    Text('${widget.depo['album']}'),
                  ],
                ),

                const Divider(height: 20,),
                // const SizedBox(height: 10,),
                Text('Zdeponowano dnia $depoDate'),
                const SizedBox(height: 10,),
                Text('Deklarowana data odbioru do '
                    '$expiredDate'),
                const Divider(height: 20,),

                Row(
                  children: [
                    const Icon(Icons.inventory),
                    const SizedBox(width: 10,),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text(
                        '• ${widget.depo['content'].toString().replaceAll(', ', '\n• ')}',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),

                const Divider(height: 20,),
                Text('Depozyt przyjęty przez: $keeperName'),
              ],
            ),
          ),
        ),
      )
    );
  }
}
