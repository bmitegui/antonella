import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
        backgroundColor: Color(0xFFF0F0F0)
      ),
      backgroundColor: Color(0xFFF0F0F0),
      body: Column(
        children: [
          Row(
            children: [
              Text('Items'),
              SizedBox(width: 16),
              Icon(Icons.keyboard_arrow_down_outlined)
            ],
          ),
          ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              Row(
                children: [
                  Image.network(
                    'https://media.istockphoto.com/id/1457889029/es/foto/grupo-de-alimentos-con-alto-contenido-de-fibra-diet%C3%A9tica-dispuestos-uno-al-lado-del-otro.jpg?s=612x612&w=0&k=20&c=fGmnVlAU6yDfG29kEMoNZg28DWA5I_CjprvK2L1HhT8=',
                    width: 20,
                    height: 20
                  ),
                  Text('Maquillaje'),
                  SizedBox(height: 16),
                  Text('Maquillaje de noche'),
                  SizedBox(height: 16),
                  Text('Cantidad: 1'),
                  SizedBox(height: 16),
                  Text('\$ 4.74'),
                ],
              );
            }
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide())
            ),
            child: Row(
              children: [
                Text('Subtotal'),
                SizedBox(width: 16),
                Text('\$ 25.00')
              ],
            )
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide())
            ),
            child: Row(
              children: [
                Text('Iva'),
                SizedBox(width: 16),
                Text('\$ 0.15')
              ],
            )
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide())
            ),
            child: Row(
              children: [
                Text('Total'),
                SizedBox(width: 16),
                Text('\$ 25.15')
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xFFF44565),
        child: ElevatedButton(
          onPressed: () {
            // Acción del botón
          },
          child: Text('Comprar'),
          // style: ElevatedButton.styleFrom(
          //   minimumSize: Size(double.infinity, 50), // ancho completo
          //),
        )
      )
    );
  }
}