import 'package:flutter/material.dart';


class AppImage extends StatelessWidget {

  final String? url;

  final double height;

  final double width;

  final BoxFit fit;

  final BorderRadius? borderRadius;

  final IconData placeholderIcon;


  const AppImage({

    super.key,

    this.url,

    this.height = 120,

    this.width = double.infinity,

    this.fit = BoxFit.cover,

    this.borderRadius,

    this.placeholderIcon = Icons.image_outlined,

  });



  @override
  Widget build(BuildContext context) {


    return ClipRRect(

      borderRadius:

      borderRadius ??

          BorderRadius.circular(12),



      child:

      url == null || url!.isEmpty


          ? _placeholder(context)


          : Image.network(

              url!,

              height: height,

              width: width,

              fit: fit,


              loadingBuilder:

              (context, child, loadingProgress) {


                if (loadingProgress == null) {

                  return child;

                }


                return _loading();

              },


              errorBuilder:

              (context, error, stackTrace) {


                return _error();

              },

            ),

    );

  }





  Widget _placeholder(BuildContext context) {


    return Container(

      height: height,

      width: width,


      color:

      Theme.of(context)

          .colorScheme

          .primary

          .withOpacity(.10),



      child:

      Icon(

        placeholderIcon,

        size: 45,

        color:

        Theme.of(context)

            .colorScheme

            .primary,

      ),

    );

  }





  Widget _loading() {


    return Container(

      height: height,

      width: width,


      color: Colors.grey.shade100,


      child:

      const Center(

        child:

        CircularProgressIndicator(

          strokeWidth: 2,

        ),

      ),

    );

  }





  Widget _error() {


    return Container(

      height: height,

      width: width,


      color: Colors.grey.shade200,


      child:

      const Icon(

        Icons.broken_image_outlined,

        size:45,

        color:Colors.grey,

      ),

    );

  }

}