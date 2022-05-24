import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:fashion_store/constants/colors.dart';
import 'package:fashion_store/constants/dimens.dart';
import 'package:fashion_store/constants/strings.dart';
import 'package:fashion_store/model/cart_model.dart';
import 'package:fashion_store/model/cartscreen_tem_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBar(),
            body(),
            bottomBar()
          ],
        ),
      )
    );
  }

  Widget appBar() {
    return Container(
      height: appBarHeight,
      width: screenWidth,
      color: bodyBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: paddingMainLeft, right: paddingMainRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios)),
                Text("Your Cart", style: TextStyle(fontSize: font13sp, fontWeight: FontWeight.bold)),
                const Icon(Icons.arrow_back_ios, color: Colors.transparent,)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      height: 20.0.h,
      width: screenWidth,
      color: bodyBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: bottombarCartsItemPadding, right: bottombarCartsItemPadding),
            child: Consumer<CartModel>(
              builder: (context, cartModel, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(totalPrice, style: TextStyle(fontWeight: FontWeight.bold, fontSize: font13sp)),
                    Text("\$ ${cartModel.totalPrice}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: font18sp))
                  ],
                );
              }
            ),
          ),
          SizedBox(
            height: bottombarCartscreenPaymentHeight,
            width: bottombarCartscreenPaymentWidth,
            child: TextButton(onPressed: () {  },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(black)),
              child: Text(payment, style: TextStyle(fontWeight: FontWeight.bold, fontSize: font12sp, color: white))),
          )
        ],
      ),
    );
  }

  Widget body() {
    return Container(
      height: cartScreenBodyHeight - MediaQuery.of(context).padding.top,
      width: screenWidth,
      color: bodyBgColor,
      child: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          List<CartScreenItemModel> cartItems = cartModel.cartItemList;
          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                emptyCart, 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: font18sp),));
          } else {
            return ListView.builder(
              itemCount: cartItems.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: paddingMainLeft, right: paddingMainRight),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: cartscreenItemHeight,
                            width: cartscreenImageWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(cartItems[index].image))
                            ),
                          ),
                          SizedBox(
                            height: cartscreenItemHeight,
                            width: cartscreenTextWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 42.0.w,
                                      child: Text(
                                        cartItems[index].title, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: font9sp))),
                                    Text("\$ ${cartItems[index].price}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: font9sp))
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(cartItems[index].category, style: TextStyle(fontWeight: FontWeight.bold, fontSize: font9sp))
                                ),
                                SizedBox(height: height2h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Text(size, style: TextStyle(fontWeight: FontWeight.bold, fontSize: font9sp, color: black38)),
                                      Text("S", style: TextStyle(fontWeight: FontWeight.bold, fontSize: font9sp))
                                    ],),
                                    Row(children: [
                                      Text(color, style: TextStyle(fontWeight: FontWeight.bold, fontSize:font9sp, color: black38)),
                                      Container(
                                        height: font9sp,
                                        width: font9sp, 
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(colorBoxBorderRadius),
                                          color: black
                                        ),
                                      )
                                    ],),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => cartModel.decreaseProductCount(index),
                                          child: Container(
                                            width: plusMinusBoxSize,
                                            height: plusMinusBoxSize,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: black38),
                                              borderRadius: BorderRadius.circular(colorBoxBorderRadius)
                                            ),
                                            child: Icon(Icons.remove, size: plusMinusIconSize,),
                                          ),
                                        ),
                                        Text("   ${cartItems[index].currentCount}   ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: font12sp, color: black)),
                                        GestureDetector(
                                          onTap: () => cartModel.increaseProductCount(index),
                                          child: Container(
                                            width: plusMinusBoxSize,
                                            height: plusMinusBoxSize,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: black38),
                                              borderRadius: BorderRadius.circular(colorBoxBorderRadius)
                                            ),
                                            child: Icon(Icons.add, size: plusMinusIconSize,),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: dividerPaddingTopBottom, bottom: dividerPaddingTopBottom),
                        child: Divider(thickness: dividerThickness,),
                      )
                    ]
                  ),
                );
              });
          }
        }
      ),
    );
  }
}