import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/container_product.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/custom_search_widget.dart';
//import 'package:antonella/features/service/presentation/widgets/services_filter_widget.dart';
import 'package:antonella/features/product/presentation/bloc/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsTabSection extends StatelessWidget {
  const ProductsTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> image = ['https://es.lorealparisusa.com/-/media/project/loreal/brand-sites/oap/americas/us/beauty-magazine/slideshows/makeup-product-essentials/loreal-paris-bmag-slideshow-20-makeup-product-essentials-every-woman-should-own-slide5.jpg?cx=0.49&cy=0.54&cw=1510&ch=815&hash=BB853C27630C49D1304533E48FFA44DE',
      'https://images.ctfassets.net/m9qku1qrfhc5/3A1sZkLPXOjSiQRlc35aa8/17fe8b61ac24508ad72b9e87268c1934/johnsons_shampoo_gotas_de_brillo-es-ec'];
    return Column(
      children: [
        CustomSearchWidget(),
        //const SizedBox(height: 16),
        //ServicesFilterWidget(),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomTitle(title: 'Todos'),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      ContainerProduct(text: 'Maquillaje', image: image), 
                      SizedBox(width: 16),
                      ContainerProduct(text: 'Shampoo', image: image)
                    ],
                  ),
                )
              )
            ],
          ), 
        )
      ]
    );
    // return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
    //   return (state is ProductsLoaded)
    //       ? Text(state.products[0].nombre)
    //       : (state is ProductsError)
    //           ? Text(state.message)
    //           : Center(child: CircularProgressIndicator());
    // });
  }
}
