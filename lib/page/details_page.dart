import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/space.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/model/model.dart';
import 'package:uidesign03/model/cart_model.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final Model model;
  const DetailsPage({Key? key, required this.model}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectIndex = 0;
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: black,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.model.category,
          style: itemCardHeading,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_outlined,
              color: black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height / 1.7,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: height / 10.0,
                  child: Container(
                    width: 60.0,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.3),
                          offset: Offset(5, 5),
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < widget.model.image.length; i++)
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectIndex = i;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectIndex == i ? primary : Colors.transparent,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(widget.model.image[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Hero(
                      tag: 'image_${widget.model.image[0]}',
                      child: Container(
                        width: height / 2.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            widget.model.image[selectIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.model.name,
                      style: heading.copyWith(fontSize: 28.0),
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: gray,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            MaterialButton(
                              minWidth: 10,
                              onPressed: () {
                                setState(() {
                                  qty++;
                                });
                              },
                              child: Text(
                                '+',
                                style: itemCardHeading.copyWith(color: lightBlack),
                              ),
                            ),
                            Text(
                              '$qty',
                              style: itemCardHeading.copyWith(color: lightBlack),
                            ),
                            MaterialButton(
                              minWidth: 10,
                              onPressed: () {
                                if (qty > 1)
                                  setState(() {
                                    qty--;
                                  });
                              },
                              child: Text(
                                '-',
                                style: itemCardHeading.copyWith(color: lightBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SpaceVH(height: 20.0),
                Text(
                  widget.model.description,
                  style: itemCardDes,
                ),
                SpaceVH(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Total Price\n',
                          style: subHeading,
                        ),
                        TextSpan(
                          text: widget.model.price,
                          style: itemCardHeading,
                        ),
                      ]),
                    ),
                    Container(
                      height: 40.0,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          final item = CartItem(
                            id: widget.model.id,
                            name: widget.model.name,
                            image: widget.model.image[0],
                            price: double.parse(widget.model.price.replaceAll('\$', '')),
                            quantity: qty,
                          );
                          cartManager.addItem(item);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cartManager.isInCart(widget.model.id) ? 'Update Cart' : 'Add to Cart',
                              style: itemCardHeading.copyWith(color: white),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              cartManager.isInCart(widget.model.id)
                                  ? Icons.shopping_cart
                                  : Icons.add_shopping_cart_outlined,
                              color: white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
