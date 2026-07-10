import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class LivreurHome extends StatefulWidget {
  const LivreurHome({super.key});

  @override
  State<LivreurHome> createState() =>
      _LivreurHomeState();
}


class _LivreurHomeState
    extends State<LivreurHome> {

  int _currentIndex = 0;


  final List<Widget> _pages = [

    const Center(
      child: Text(
        "Livraisons disponibles",
      ),
    ),

    const Center(
      child: Text(
        "Mes livraisons",
      ),
    ),

    const Center(
      child: Text(
        "Profil",
      ),
    ),
  ];



  void _onTap(int index) {

    setState(() {

      _currentIndex = index;

    });


    switch(index){

      case 0:
        context.go(
          "/livreur/livraisons-disponibles",
        );
        break;


      case 1:
        context.go(
          "/livreur/mes-livraisons",
        );
        break;


      case 2:
        context.go(
          "/profile",
        );
        break;

    }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Espace Livreur",
        ),


        actions: [

          IconButton(

            icon: const Icon(
              Icons.notifications,
            ),

            onPressed: () {

              context.push(
                "/notifications",
              );

            },
          ),

        ],

      ),



      body: _pages[_currentIndex],



      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex:
            _currentIndex,


        onTap:
            _onTap,


        items: const [

          BottomNavigationBarItem(

            icon: Icon(
              Icons.delivery_dining,
            ),

            label:
                "Disponibles",
          ),


          BottomNavigationBarItem(

            icon: Icon(
              Icons.local_shipping,
            ),

            label:
                "Mes livraisons",
          ),


          BottomNavigationBarItem(

            icon: Icon(
              Icons.person,
            ),

            label:
                "Profil",
          ),

        ],

      ),

    );

  }

}