import 'package:app_muestra/screens/Peliculas.dart';
import 'package:flutter/material.dart';
///////////////////////////////////

void main() {
  runApp(const Aplicacion());
}

class Aplicacion extends StatelessWidget {
  const Aplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home()
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Cuerpo(context),
      
   
    );
  }
}

Widget Cuerpo(context){
  return ( 
    Column(
      children: <Widget>[
        const Text("Welcome"),
        BotonIngresar(context)
      ],
    )
  );
}

Widget BotonIngresar(context){
  return( 
    FilledButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Peliculas()));
    }, child: Text("Ingresar"))
  );
}