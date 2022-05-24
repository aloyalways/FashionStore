import 'package:flutter/cupertino.dart';
import 'package:fashion_store/model/cartscreen_tem_model.dart';
import 'package:fashion_store/model/homescreen_item_model.dart';

class CartModel extends ChangeNotifier{
  List<CartScreenItemModel> cartItemList = [];
  double totalPrice = 0.00;

  addItemInCartList(HomeScreenProductModel selectedProduct) {
    CartScreenItemModel cartItem = CartScreenItemModel(
      selectedProduct.id, 
      selectedProduct.title, 
      selectedProduct.price, 
      selectedProduct.category, 
      selectedProduct.image, 
      selectedProduct.count, 
      1);
    cartItemList.add(cartItem);
    totalPrice += cartItem.price;
    totalPrice = double.parse(totalPrice.toStringAsFixed(2));

    notifyListeners();
  }

  increaseProductCount(int index) {
    if (cartItemList[index].maxCount > cartItemList[index].currentCount)  {
      cartItemList[index].currentCount+=1;
      totalPrice += cartItemList[index].price;
      totalPrice = double.parse(totalPrice.toStringAsFixed(2));
    }

    notifyListeners();
  }

  decreaseProductCount(int index) {
    if (cartItemList[index].currentCount==1) {
      totalPrice -= cartItemList[index].price;
      totalPrice = double.parse(totalPrice.toStringAsFixed(2));
      cartItemList.removeAt(index);
    } else {
      totalPrice -= cartItemList[index].price;
      totalPrice = double.parse(totalPrice.toStringAsFixed(2));
      cartItemList[index].currentCount-=1;
    }
    if (totalPrice<0) totalPrice = 0.00;

    notifyListeners();
  }
}