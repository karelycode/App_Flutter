import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaDatos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Herramientas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('herr').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document){
              Map<String, dynamic> data=document.data()! as Map<String, dynamic>;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                elevation: 10,
                margin: EdgeInsets.all(10.0),
                child: new Column(
                  children: [
                    Image.network(data['imagen']),
                    ListTile(
                      title: Text("Nombre: "+data['nombreherr']),
                      subtitle: Text("Descripción: "+data['descripcion']+"\nPrecio: "+data['precio'],style: TextStyle(fontSize: 15),),
                    )
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