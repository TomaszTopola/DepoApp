import 'package:flutter/material.dart';

class DepoForm extends StatefulWidget {
  const DepoForm({Key? key, this.depo}) : super(key: key);

  final dynamic depo;

  @override
  State<DepoForm> createState() => _DepoFormState();
}

class _DepoFormState extends State<DepoForm> {


  final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String sdm = 'KORAB';

  @override
  void dispose(){
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'ID',
                labelText: 'ID',
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Text('SDM: '),
                DropdownButton(
                  value: sdm,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'KORAB',
                      child: Text('KORAB'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'PASAT',
                      child: Text('PASAT'),
                    )
                  ],
                  onChanged: (String? value) {
                    setState((){
                      sdm= value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: 'imię',
                labelText: 'imię',
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'nazwisko',
                labelText: 'nazwisko',
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'numer albumu',
                labelText: 'numer albumu',
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'numer telefonu',
                labelText: 'numer telefonu',
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'adres e-mail',
                labelText: 'adres e-mail',
              ),
            ),
          ],
        ),
      )
    );
  }
}
