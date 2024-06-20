import 'package:app_muestra/screens/Series.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video_player_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Peliculas());
  
}

class Peliculas extends StatelessWidget {
  const Peliculas({Key? key});

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
  List<Map<String, dynamic>> peliculasList = [];
  int indice = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    /////////////////////////////////////////
    /// Función con el objetivo de traer los datos
    /////////////////////////////////////////
    
    final response = await http.get(Uri.parse('https://jritsqmet.github.io/web-api/peliculas.json'));

    if (response.statusCode == 200) {
      // Decodificar el JSON y actualizar la lista
      updateProductList(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void updateProductList(List<dynamic> data) {
    List<Map<String, dynamic>> tempList = [];

    data.forEach((element) {
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
    List <Widget> screens =[Cuerpo(), Series()];
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Películas'),
      ),
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: (value) {
          setState(() {
            indice = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
        ],
      ),
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





