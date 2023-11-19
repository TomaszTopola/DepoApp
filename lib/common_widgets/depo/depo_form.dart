import 'package:depo_app/services/server/depo_service.dart';
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
  List<String> depoContent = [];

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
      depoDateController.text = DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').parse(widget.depo["depo_date"]));
      validToController.text = DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').parse(widget.depo["valid_to"]));
      sdm = widget.depo["sdm"];
      depoContent = widget.depo["content"].toString().split(', ');
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
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
                        ],
                      ),

                      Row(
                        children: [
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
                      TextFormField(
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
                      TextFormField(
                        controller: validToController,
                        decoration: InputDecoration(
                          hintText: DateFormat(displayDateFormat).format(DateTime.now()),
                          labelText: 'Data zdeponowania mienia',
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateFormat(displayDateFormat).parse(validToController.text),
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
                    ],
                  ),
                ),


                ////////////////////////////////////////////////////////////////
                //DEPO CONTENT DEPO CONTENT DEPO CONTENT DEPO CONTENT DEPO CON//
                ////////////////////////////////////////////////////////////////

                const SizedBox(width: 50,),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                        child: Text(
                          'ZAWARTOŚĆ DEPOZYTU',
                          style: TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ListView.builder(
                        itemCount: depoContent.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: ListTile(
                              title: Text(depoContent[index]),
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              tileColor: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    depoContent.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 9,
                            child: TextFormField(
                              controller: contentController,
                              decoration: const InputDecoration(
                                labelText: 'Dodaj element/elementy',
                                hintText: 'Karton, lodówka, krzesło',
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: (){
                                if(contentController.text=='')return;
                                setState(() {
                                  List<String> contentToAdd = contentController.text.split(', ');
                                  contentToAdd.forEach((element) {depoContent.add(element);});
                                  contentController.text = '';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                minimumSize: const Size(60,60),
                              ),
                              child: const Icon(Icons.add_card,),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 50,),

            ////////////////////////////////////////////////////////////////////
            //BUTTONS BUTTONS BUTTONS BUTTONS BUTTONS BUTTONS BUTTONS BUTTONS //
            ////////////////////////////////////////////////////////////////////

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: OutlinedButton(
                    //TODO: implement
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(10, 10.0, 10.0, 10.0),
                        minimumSize:  const Size.fromHeight(50),
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                        ),
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel),
                          SizedBox(width: 10,),
                          Text('anuluj')
                        ],
                      )
                  ),
                ),

                const SizedBox(width: 20),

                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: (){
                      
                      dynamic message;
                      
                      if (_formKey.currentState!.validate()) {
                        dynamic newDepo = {
                          "_id": idController.text,
                          "sdm": sdm,
                          "depo_status": depoStatus,
                          "first_name": firstNameController.text,
                          "last_name": lastNameController.text,
                          "album": albumNumberController.text,
                          "phone": phoneController.text,
                          "mail": mailController.text,
                          // "content": content,
                          "depo_date": DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').format(DateFormat(displayDateFormat).parse(depoDateController.text)),
                          "valid_to": DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').format(DateFormat(displayDateFormat).parse(validToController.text)),
                        };
                        if(widget.depo != null){
                          message = DepoService.patchDepo(newDepo);
                        }else {
                          message = DepoService.postDepo(newDepo);
                        }
                        Navigator.pop(context);
                        if (message == -1){
                          message = 'Niespodziewany błąd';
                        }
                      
                        final snackBar = SnackBar(
                          content: Text(message.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
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
            const SizedBox(height: 20,),
            Flexible(
              flex: 1,
              child: OutlinedButton(
                //TODO: implement
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Drukowanie nie jest jeszcze obsługiwane.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary
                        )),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                      )
                    );
                  },
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
          ],
        ),
      )
    );
  }
}
