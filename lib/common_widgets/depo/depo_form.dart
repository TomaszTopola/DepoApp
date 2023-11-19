import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepoForm extends StatefulWidget {
  DepoForm({super.key, this.depo});

  final dynamic depo;

  @override
  State<DepoForm> createState() => _DepoFormState();
}

class _DepoFormState extends State<DepoForm> {

  final String displayDateFormat = 'dd MMMM yyyy';

  final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final albumNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();
  final contentController = TextEditingController();
  final depoDateController = TextEditingController();
  final validToController = TextEditingController();

  String sdm = 'KORAB';
  String depoStatus = 'ACTIVE';

  final _formKey = GlobalKey<FormState>();

  String? Function(String? value) nonEmptyValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'To pole nie może być puste.';
    }
    return null;
  };

  @override
  void dispose(){
    idController.dispose();
    firstNameController.dispose();
    albumNumberController.dispose();
    phoneController.dispose();
    mailController.dispose();
    contentController.dispose();
    depoDateController.dispose();
    validToController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    if(widget.depo != null){
      print(widget.depo);
      idController.text = widget.depo["_id"];
      depoStatus = widget.depo["depo_status"];
      albumNumberController.text = widget.depo["album"];
      firstNameController.text = widget.depo["first_name"];
      lastNameController.text = widget.depo["last_name"];
      phoneController.text = widget.depo["phone"];
      mailController.text = widget.depo["mail"];
      contentController.text = widget.depo["content"];
      depoDateController.text = DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').parse(widget.depo["depo_date"]));
      validToController.text = DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').parse(widget.depo["valid_to"]));
      sdm = widget.depo["sdm"];
    }else{
      depoDateController.text = DateFormat(displayDateFormat).format(DateTime.now());
      validToController.text = DateFormat(displayDateFormat).format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: '12-2023',
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

                const SizedBox(width: 20,),

                const Text('Status: '),
                DropdownButton(
                  value: depoStatus,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'ACTIVE',
                      child: Text('AKTYWNY'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'CONTACTED',
                      child: Text('PODJĘTO KONTAKT'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'OUTDATED',
                      child: Text('PRZETERMINOWANY'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'DISPOSED',
                      child: Text('PRZEZNACZONY DO UTYLIZACJI'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ARCHIVED',
                      child: Text('ZARCHIWIZOWANY'),
                    ),
                  ],
                  onChanged: (String? value) {
                    setState((){
                      depoStatus = value!;
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
                hintText: '12345',
                labelText: 'numer albumu',
              ),
              validator: nonEmptyValidator,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: '(+48) 123 456 789',
                labelText: 'numer telefonu',
              ),
              validator: nonEmptyValidator,
            ),
            TextFormField(
              controller: mailController,
              decoration: const InputDecoration(
                hintText: '12345@s.pm.szczecin.pl',
                labelText: 'adres e-mail',
              ),
              validator: nonEmptyValidator,
            ),

            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: depoDateController,
                    decoration: InputDecoration(
                      hintText: DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      labelText: 'Data zdeponowania mienia',
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateFormat(displayDateFormat).parse(depoDateController.text),
                        lastDate: DateTime.now(),
                        firstDate: DateTime(2023, 1, 1),
                        helpText: 'ZDEPONOWANO'
                      );
                      if(pickedDate != null){
                        String formattedDate = DateFormat(displayDateFormat).format(pickedDate);
                        setState(() {
                          depoDateController.text = formattedDate;
                        });
                      }
                    },
                    validator: nonEmptyValidator,
                  ),
                ),
                const SizedBox(width: 40,),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: validToController,
                    decoration: InputDecoration(
                      hintText: DateFormat(displayDateFormat).format(DateTime.now()),
                      labelText: 'Data zdeponowania mienia',
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateFormat(displayDateFormat).parse(depoDateController.text),
                        lastDate:  DateTime(
                          DateTime.now().year + 2,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        firstDate: DateFormat(displayDateFormat).parse(depoDateController.text),
                        helpText: 'DEADLINE',
                      );
                      if(pickedDate != null){
                        String formattedDate = DateFormat(displayDateFormat).format(pickedDate);
                        setState(() {
                          validToController.text = formattedDate;
                        });
                      }
                    },
                    validator: nonEmptyValidator,
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Lodówka, karton, krzesło',
                labelText: 'Zawartość depozytu (oddzielona przecinkami)',
              ),
              validator: nonEmptyValidator,
            ),

            const SizedBox(height: 50,),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: OutlinedButton(
                    //TODO: implement
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(10, 10.0, 10.0, 10.0),
                      minimumSize:  const Size.fromHeight(50),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                      ),
                      foregroundColor: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.print),
                        SizedBox(width: 10,),
                        Text('Drukuj etykietę')
                      ],
                    )
                  ),
                ),

                const SizedBox(width: 20),

                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: (){
                      String content = contentController.text.replaceAll('\n', ',');
                      dynamic newDepo = {
                        "_id": idController.text,
                        "sdm": sdm,
                        "depo_status": depoStatus,
                        "first_name": firstNameController.text,
                        "last_name": lastNameController.text,
                        "album": albumNumberController.text,
                        "phone": phoneController.text,
                        "mail": mailController.text,
                        "content": content,
                        "depo_date": DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').format(DateFormat(displayDateFormat).parse(depoDateController.text)),
                        "valid_to": DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').format(DateFormat(displayDateFormat).parse(validToController.text)),
                      };
                      if (_formKey.currentState!.validate()) {
                        print(newDepo);
                        if(widget.depo != null){
                          //TODO: PATCH depo
                        }else {
                          //TODO: POST depo
                        }
                      }
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(10, 10.0, 10.0, 10.0),
                      minimumSize:  const Size.fromHeight(50),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save),
                        SizedBox(width: 10,),
                        Text('Zapisz Depozyt')
                      ],
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
