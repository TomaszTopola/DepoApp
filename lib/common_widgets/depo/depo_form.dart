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
  final telephoneNumberController = TextEditingController();
  final emailAdressController = TextEditingController();

  String sdm = 'KORAB';

  @override
  void dispose(){
    idController.dispose();
    firstNameController.dispose();
    albumNumberController.dispose();
    telephoneNumberController.dispose();
    emailAdressController.dispose();
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
              controller: albumNumberController,
              decoration: const InputDecoration(
                hintText: 'numer albumu',
                labelText: 'numer albumu',
              ),
            ),
            TextFormField(
              controller: telephoneNumberController,
              decoration: const InputDecoration(
                hintText: 'numer telefonu',
                labelText: 'numer telefonu',
              ),
            ),
            TextFormField(
              controller: emailAdressController,
              decoration: const InputDecoration(
                hintText: 'adres e-mail',
                labelText: 'adres e-mail',
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){

                List userData = [(idController.text), sdm, (firstNameController.text), (lastNameController.text), (albumNumberController.text), (telephoneNumberController.text), (emailAdressController.text)];
                for(int i=0; i < userData.length; i ++){
                  if(userData[i].isEmpty){
                    break;
                  } else {
                    print(userData[i]);
                  }
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
                'Wyślij',
              ),
            ),
          ],
        ),
      )
    );
  }
}
