import 'package:flutter/material.dart';

class MeetingRequest extends StatefulWidget {
  const MeetingRequest({Key? key}) : super(key: key);

  @override
  State<MeetingRequest> createState() => _MeetingRequestState();
}

class _MeetingRequestState extends State<MeetingRequest> {

  Map messageData = {
    'KORAB': false,
    'PASAT': false,
  };
  DateTimeRange? savedDate;

  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final albumController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    albumController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2,
        )
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10,),
            Text(
              'Umów spotkanie z opiekunem depozytu',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              'Opiekunowie najczęściej obsługują depozyty\nmiędzy 18:00, a 20:00',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: nameController,
              validator: (value){
                if( value == null || value.isEmpty ){
                  return 'To pole jest wymagane';
                }
              },
              decoration: const InputDecoration(
                hintText: 'imię',
                labelText: 'imię',
              ),
            ),
            TextFormField(
              validator: (value){
                if( value == null || value.isEmpty ){
                  return 'To pole jest wymagane';
                }
              },
              controller: albumController,
              decoration: const InputDecoration(
                hintText: 'numer albumu / e-mail',
                labelText: 'numer albumu / e-mail'
              ),
            ),
            const SizedBox(height: 10,),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: messageData['KORAB'],
                    onChanged: (bool? value){
                      setState(() {
                        messageData['KORAB'] = value!;
                      });
                    }
                  ),
                  Text(
                    'SDM Korab',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary
                    ),
                  ),
                  const SizedBox(width: 10,),
                  const VerticalDivider(
                    width: 30,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Checkbox(
                      value: messageData['PASAT'],
                      onChanged: (bool? value){
                        setState(() {
                          messageData['PASAT'] = value!;
                        });
                      }
                  ),
                  Text(
                    'SDM Pasat',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary
                    ),
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
            ),
            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Kiedy możesz przyjść?',
                labelText: 'Kiedy możesz przyjść?',
              ),
              onTap: () async {
                savedDate = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 21)),
                );
                messageData['date_start'] = savedDate?.start;
                messageData['date_end'] = savedDate?.end;
                setState(() {
                  dateController.text = savedDate.toString()
                      .replaceRange(10, 23, '')
                      .replaceRange(23, 36, '');
                });
              }
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){
                  _formKey.currentState!.validate();
                  if(messageData['KORAB'] == false && messageData['PASAT'] == false){
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar
                      (content: Text('Co najmniej jeden akademik musi być zaznaczony.'))
                    );
                    return;
                  }
                  messageData['name'] = nameController.text;
                  messageData['album'] = albumController.text;
                },
                child: const Text('Wyślij')
            )
          ],
        ),
      )
    );
  }
}
