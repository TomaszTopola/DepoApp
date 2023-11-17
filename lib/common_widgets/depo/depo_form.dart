import 'package:flutter/material.dart';

class DepoForm extends StatefulWidget {
  @override
  State<DepoForm> createState() => _DepoFormState();
}

class _DepoFormState extends State<DepoForm> {


  final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final albumNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();

  String sdm = 'KORAB';

  @override
  void dispose(){
    idController.dispose();
    firstNameController.dispose();
    albumNumberController.dispose();
    phoneController.dispose();
    mailController.dispose();
    super.dispose();
  }

  String? Function(String? value) nonEmptyValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'To pole nie może być puste.';
    }
    return null;
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'ID',
                labelText: 'ID',
              ),
              validator: nonEmptyValidator,
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
              validator: nonEmptyValidator,
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'nazwisko',
                labelText: 'nazwisko',
              ),
              validator: nonEmptyValidator,
            ),
            TextFormField(
              controller: albumNumberController,
              decoration: const InputDecoration(
                hintText: 'numer albumu',
                labelText: 'numer albumu',
              ),
              validator: nonEmptyValidator,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'numer telefonu',
                labelText: 'numer telefonu',
              ),
              validator: nonEmptyValidator,
            ),
            TextFormField(
              controller: mailController,
              decoration: const InputDecoration(
                hintText: 'adres e-mail',
                labelText: 'adres e-mail',
              ),
              validator: nonEmptyValidator,
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){
                dynamic newDepo = {
                  "_id": idController.text,
                  "sdm": sdm,
                  "first_name": firstNameController.text,
                  "last_name": lastNameController.text,
                  "album": albumNumberController.text,
                  "phone": phoneController.text,
                  "mail": mailController.text,
                };
                if (_formKey.currentState!.validate()) {
                  print(newDepo);
                }
              },

              style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(10, 10.0, 10.0, 10.0),
              minimumSize:  const Size.fromHeight(50),
              textStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              child:
              const Text(
                'Dodaj depozyt',
              ),
            ),
          ],
        ),
      )
    );
  }
}
