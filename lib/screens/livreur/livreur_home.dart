import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';

import '../../providers/auth_provider.dart';
import '../../providers/livraison_provider.dart';
import '../../providers/commission_provider.dart';

import '../../widgets/common/stat_card.dart';


class LivreurHome extends StatefulWidget {

  const LivreurHome({
    super.key,
  });


  @override
  State<LivreurHome> createState() => _LivreurHomeState();

}



class _LivreurHomeState extends State<LivreurHome> {


  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {

      context
          .read<LivraisonProvider>()
          .fetchLivraisonsDisponibles();


      context
          .read<LivraisonProvider>()
          .fetchLivraisons();


      context
          .read<CommissionProvider>()
          .fetchCommissions();


    });

  }





  Future<void> _refresh() async {


    await context
        .read<LivraisonProvider>()
        .fetchLivraisonsDisponibles();


    await context
        .read<LivraisonProvider>()
        .fetchLivraisons();


    await context
        .read<CommissionProvider>()
        .fetchCommissions();


  }







  @override
  Widget build(BuildContext context) {


    final user =
    context.watch<AuthProvider>().user;



    return Scaffold(


      appBar: AppBar(


        titleSpacing: 16,


        title: Row(

          children: [


            const Icon(
              Icons.local_shipping_outlined,
            ),


            const SizedBox(width: 8),



            const Text(
              "Espace Livreur",
            ),


          ],

        ),



        actions: [



          IconButton(

            tooltip: "Forum",

            icon: const Icon(
              Icons.forum_outlined,
            ),

            onPressed: () =>
                context.push(
                  AppRoutes.forum,
                ),

          ),





          IconButton(

            tooltip: "Notifications",

            icon: const Icon(
              Icons.notifications_outlined,
            ),

            onPressed: () =>
                context.push(
                  AppRoutes.notifications,
                ),

          ),



          const SizedBox(width: 8),


        ],


      ),





      body: RefreshIndicator(


        onRefresh: _refresh,


        child: SingleChildScrollView(


          physics:
          const AlwaysScrollableScrollPhysics(),


          padding:
          const EdgeInsets.all(16),



          child: Column(


            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [





              // BIENVENUE


              Container(


                width:
                double.infinity,


                padding:
                const EdgeInsets.all(20),



                decoration:
                BoxDecoration(


                  gradient:
                  LinearGradient(

                    colors: [

                      Colors.blue.shade700,

                      Colors.blue.shade400,

                    ],

                    begin:
                    Alignment.topLeft,

                    end:
                    Alignment.bottomRight,

                  ),


                  borderRadius:
                  BorderRadius.circular(22),


                ),



                child: Column(


                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children: [



                    Text(

                      "Bonjour ${user?.prenom ?? ''}",


                      style:
                      const TextStyle(

                        color:
                        Colors.white,

                        fontSize:
                        22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),




                    const SizedBox(height:8),




                    const Text(

                      "Gérez vos livraisons facilement",

                      style:
                      TextStyle(

                        color:
                        Colors.white70,

                        fontSize:
                        14,

                      ),

                    ),


                  ],


                ),


              ),






              const SizedBox(height:24),





              Text(

                "Tableau de bord",

                style:
                Theme.of(context)

                    .textTheme

                    .titleLarge

                    ?.copyWith(

                  fontWeight:
                  FontWeight.bold,

                ),

              ),





              const SizedBox(height:16),






              LayoutBuilder(


                builder:
                    (context,constraints){


                  int columns = 2;



                  if(constraints.maxWidth > 900){

                    columns = 4;


                  }

                  else if(constraints.maxWidth > 600){

                    columns = 3;

                  }





                  return GridView(


                    shrinkWrap:true,


                    physics:
                    const NeverScrollableScrollPhysics(),


                    gridDelegate:

                    SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount:
                      columns,


                      crossAxisSpacing:
                      12,


                      mainAxisSpacing:
                      12,


                      childAspectRatio:
                      1,


                    ),




                    children: [





                      Consumer<LivraisonProvider>(


                        builder:
                            (context,provider,child)=>


                            StatCard(


                              icon:
                              Icons.delivery_dining_outlined,


                              value:

                              "${provider.livraisonsDisponibles.length}",


                              label:

                              "Disponibles",


                              onTap: () =>

                                  context.push(

                                    AppRoutes.livraisonsDisponibles,

                                  ),

                            ),


                      ),






                      Consumer<LivraisonProvider>(


                        builder:
                            (context,provider,child)=>


                            StatCard(


                              icon:

                              Icons.local_shipping_outlined,


                              value:

                              "${provider.livraisons.length}",


                              label:

                              "Mes livraisons",


                              onTap: () =>

                                  context.push(

                                    AppRoutes.mesLivraisons,

                                  ),


                            ),


                      ),







                      Consumer<LivraisonProvider>(


                        builder:
                            (context,provider,child){


                          final terminees =

                          provider.livraisons

                              .where(

                                (l)=>

                            l["statut"]

                                =="LIVREE",

                          )

                              .length;



                          return StatCard(


                            icon:

                            Icons.check_circle_outline,


                            value:

                            "$terminees",


                            label:

                            "Terminées",


                          );


                        },


                      ),







                      Consumer<CommissionProvider>(


                        builder:
                            (context,provider,child){


                          final total =

                          provider.commissions.fold<double>(

                            0,

                                (sum,c)=>

                            sum +

                                (

                                    double.tryParse(

                                      c["montant"]

                                          .toString(),

                                    )

                                        ??

                                        0

                                ),

                          );



                          return StatCard(


                            icon:

                            Icons.payments_outlined,


                            value:

                            "${total.toStringAsFixed(0)} FCFA",


                            label:

                            "Commission",


                          );


                        },


                      ),



                    ],


                  );


                },


              ),



            ],


          ),


        ),


      ),


    );

  }

}