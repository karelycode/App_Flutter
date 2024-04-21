
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:segundaapp/clases/datos.dart';
import 'package:segundaapp/pages/start.dart';

class Formulario extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MiFormulario();
  }


}

class MiFormulario extends State<Formulario> {
  final controladorn = TextEditingController();
  final controladord = TextEditingController();
  final controladorp = TextEditingController();
  final controladori = TextEditingController();

  Datos dat = Datos("", "", "", "");

  Future <void> guardarDatos(String nombre, String desc, String precio, String imagen) async {
    Future.delayed(Duration(seconds: 7), () async {
      final datos = await FirebaseFirestore.instance.collection('herr');
      return datos.add({
        'nombreherr': nombre,
        'descripcion': desc,
        'precio': precio,
        'imagen': imagen
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datos de las herramientas"),
        backgroundColor: Color.fromRGBO(200, 200, 200, .9),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10.00)),
              TextField(
                controller: controladorn,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Nombre"),
              ),
              Padding(padding: EdgeInsets.all(10.00)),
              TextField(
                controller: controladord,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descripción"),
              ),
              Padding(padding: EdgeInsets.all(10.00)),
              TextField(
                controller: controladorp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Precio"),
              ),
              Padding(padding: EdgeInsets.all(10.00)),
              ElevatedButton(
                onPressed: () {
                  dat.nombreherr = controladorn.text;
                  dat.descripcion = controladord.text;
                  dat.precio = controladorp.text;
                  dat.imagen = Datos.downloadURL;
                  guardarDatos(dat.nombreherr, dat.descripcion,
                      dat.precio, dat.imagen);
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Start();
                      }), ModalRoute.withName("/"));
                },
                child: Text("Registrar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
