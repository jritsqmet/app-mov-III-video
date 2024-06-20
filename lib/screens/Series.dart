import 'package:flutter/material.dart';
import 'video_player_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Series());
}

class Series extends StatelessWidget {
  const Series({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Lista(),
    );
  }
}
//////////////////////////////////////////////////////
class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<dynamic, dynamic>> peliculasList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    /////////////////////////////////////////
    /// Función con el objetivo de traer los datos
    /////////////////////////////////////////
    
    DatabaseReference productoRef = FirebaseDatabase.instance.ref('peliculas');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateProductList(data);
    });
  }

  void updateProductList(dynamic data) {
    List<Map<dynamic, dynamic>> tempList = [];

    data.forEach((key, element) {
      //////////////////////////////////////////
      /// Se asigna la clave y valor a la lista temporal
      //////////////////////////////////////////
      tempList.add({
        "titulo": element['titulo'],
        "descripcion": element['descripcion'],
        "url": element['url'], 
      });
    });

    setState(() {
      peliculasList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Cuerpo()
     
    );
  }

  Widget Cuerpo() {
    return ListView.builder(
      itemCount: peliculasList.length,
      itemBuilder: (context, index) {
        return ListTile(
          //////////////////////////////////////
          /// Se manda a imprimir los valores solicitados
          //////////////////////////////////////
          
          title: Text('${peliculasList[index]["titulo"]}'),
          subtitle: Text('${peliculasList[index]["descripcion"]}'),
          onTap: () {
            // Navegar a la pantalla del reproductor de video
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(videoUrl: peliculasList[index]["url"]),
              ),
            );
          },
        );
      },
    );
  }
}





