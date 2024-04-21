

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:segundaapp/pages/start.dart';

import '../clases/datos.dart';



class ListaDatos extends StatelessWidget {
  Datos dat = Datos("", "", "", "");
  String nombre="";
  String desc="";
  String precio="";

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Herramientas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('herr').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              final TextEditingController cnombre = TextEditingController(text: data['nombreherr']);
              final TextEditingController cdesc = TextEditingController(text: data['descripcion']);
              final TextEditingController cprecio = TextEditingController(text: data['precio']);
              return InkWell(
                onTap: () {
                  // Add your edit button logic here
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print('Editado: '+data['nombreherr']);
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Editar información"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children:<Widget> [
                                          Padding(padding: EdgeInsets.all(10.00)),
                                          TextField(
                                            controller: cnombre,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Nombre",
                                                hintText: data['nombreherr']),
                                          ),
                                          Padding(padding: EdgeInsets.all(10.00)),

                                          TextField(
                                            controller: cdesc,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Descripción",
                                                ),

                                          ),
                                          Padding(padding: EdgeInsets.all(10.00)),
                                          TextField(
                                            controller: cprecio,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Precio",
                                                hintText: data['precio']),
                                          ),
                                          Padding(padding: EdgeInsets.all(10.00)),
                                          ElevatedButton(
                                            onPressed: () {
                                              nombre = cnombre.text;
                                              desc = cdesc.text;
                                              precio = cprecio.text;

                                              FirebaseFirestore.instance.collection('herr').doc(document.id).update({
                                                'nombreherr': nombre,
                                                'descripcion': desc,
                                                'precio': precio,
                                              });

                                              Navigator.pushAndRemoveUntil(context,
                                                  MaterialPageRoute(builder: (BuildContext context) {
                                                    return ListaDatos();
                                                  }), ModalRoute.withName("/"));
                                            },
                                            child: Text("Actualizar"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("La información se eliminará permanentemente,\n¿Desea continuar?"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children:<Widget> [
                                          GestureDetector(
                                              child: Text("Si"),
                                              onTap: (){
                                                print('Eliminado: '+data['nombreherr']);
                                                FirebaseFirestore.instance.collection('herr').doc(document.id).delete();
                                                ListaDatos();
                                              }
                                          ),
                                          Padding(padding: EdgeInsets.all(8.0)),
                                          GestureDetector(
                                            child: Text("No"),
                                            onTap: (){
                                              ListaDatos();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                              }
                            );


                          },
                        ),
                      ],
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                      margin: EdgeInsets.all(10.0),
                      child: new Column(
                        children: [
                          Image.network(data['imagen']),
                          ListTile(
                            title: Text("Nombre: " + data['nombreherr']),
                            subtitle: Text("Descripción: " + data['descripcion'] + "\nPrecio: " + data['precio'], style: TextStyle(fontSize: 15),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }



}