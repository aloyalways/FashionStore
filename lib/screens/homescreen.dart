import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zupay_assignment/constants/colors.dart';
import 'package:zupay_assignment/constants/dimens.dart';
import 'package:zupay_assignment/constants/strings.dart';
import 'package:zupay_assignment/model/cart_model.dart';
import 'package:zupay_assignment/model/homescreen_item_model.dart';
import 'package:zupay_assignment/network/get_all_products_api.dart';
import 'package:zupay_assignment/screens/cart_screen.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<HomeScreenModel>? futureGetAllProducts;

  @override
  void initState() {
    futureGetAllProducts = getAllProductsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
      color: appBarColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: paddingMainLeft, right: paddingMainRight),
            child: Row(
              children: const [ 
                Icon(Icons.menu),
                Spacer(),
                Icon(Icons.search)
              ],
            ),
          ),
          Align(alignment: Alignment.centerLeft, child: Padding(
            padding: EdgeInsets.only(left: paddingMainLeft),
            child: Text(newArrivals, style: TextStyle(fontSize: font12sp, fontWeight: FontWeight.bold)),
          ))
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      height: bottombarHomescreenHeight,
      width: screenWidth,
      color: bottomBarColor,
      child: Row(
        children: [
          Expanded(
            flex: expandedFlex5,
            child: Center(
              child: Container(
                height: bottomBarHomescreenItemHeight,
                width: bottomBarHomescreenItemWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bottomBarHomescreenItemBorderRadius),
                  color: bottomBarItemColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.home_outlined),
                    Text(home, style: TextStyle(fontSize: font10sp),)
                  ],
                )),
            ),
          ),
          Expanded(
            flex: expandedFlex5,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) {
                    return const CartScreen();
                  })
                );
              },
              child: Consumer<CartModel>(
                builder: (context, cartModel, child) {
                  return Badge(
                    badgeContent: Text("${cartModel.cartItemList.length}", style: TextStyle(fontWeight: FontWeight.bold, color: white),),
                    showBadge: cartModel.cartItemList.isNotEmpty,
                    position: BadgePosition.topEnd(end: cartBadgePositionEnd),
                    child: const Icon(Icons.shopping_bag_outlined));
                }
              ))
          )
        ],
      ),
    );
  }

  Widget body() {
    return Container(
      height: homeScreenBodyHeight - MediaQuery.of(context).padding.top,
      width: screenWidth,
      color: bodyBgColor,
      child: FutureBuilder<HomeScreenModel>(
        future: futureGetAllProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<HomeScreenProductModel> allProducts = snapshot.data!.allProducts;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, 
                crossAxisSpacing: crossAxisSpacing, 
                mainAxisSpacing: mainAxisSpacing, 
                childAspectRatio: childAspectRatio),
              itemCount: allProducts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index%2==0 ? gridViewItemPaddingLeft : 0.0, 
                    right: index%2==0 ? 0.0 : gridViewItemPaddingRight),
                  child: Container(
                    color: gridViewItemColor,
                    child: Column(
                      children: [
                        Container(
                          height: gridImageHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(allProducts[index].image), 
                              fit: BoxFit.contain)
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: gridItemPaddingLeft, right: gridItemPaddingRight, top: gridItemPaddingTop),
                          child: Align(
                            alignment: Alignment.centerLeft, 
                            child: Text(
                              allProducts[index].category, 
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: font8sp, 
                                color: gridItemTitleColor))
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: gridItemPaddingLeft, right: gridItemPaddingRight),
                          child: Align(
                            alignment: Alignment.centerLeft, 
                            child: Text(
                              allProducts[index].title, 
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: font10sp,))
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: gridItemPaddingLeft, right: gridItemPaddingRight, top: gridItemPaddingTop),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                              "\$ ${allProducts[index].price}", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: font13sp,)),
                              GestureDetector(
                                onTap: () => Provider.of<CartModel>(context, listen: false).addItemInCartList(allProducts[index]),
                                child: const Icon(Icons.shopping_bag_outlined))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Server Error")
            );
          }
          return const CupertinoActivityIndicator();
            
        }
      ),
    );
  }
}