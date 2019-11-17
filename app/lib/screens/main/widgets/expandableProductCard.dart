import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greenlist/blocs/index.dart';
import 'package:greenlist/models/index.dart';
import 'package:greenlist/services/utils.dart';
import 'package:greenlist/styles.dart';
import 'package:greenlist/screens/main/widgets/productCard.dart';

class ExpandableProductCard extends StatefulWidget {
  final Product product;
  ExpandableProductCard({this.product});

  @override
  _ExpandableProductCardState createState() => _ExpandableProductCardState();
}

class _ExpandableProductCardState extends State<ExpandableProductCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              height: 130,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 130,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(widget.product.picture),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Spacer(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.product.name,
                                  style:
                                      genTextStyle(null, bigSize, mediumWeight),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "CO2: ${widget.product.footprint}g",
                                  style: genTextStyle(),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (index, _isExpanded) {
                setState(() => isExpanded = !isExpanded);
              },
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: isExpanded,
                  headerBuilder: (context, _isExpanded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 45),
                        Text(
                          "${widget.product.alternatives.length} " +
                              Utils.getNoun(
                                widget.product.alternatives.length,
                                "alternative",
                                "alternatives",
                                "alternatives",
                              ),
                          style:
                              genTextStyle(blackColor, bigSize, mediumWeight),
                        ),
                      ],
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        for (Product alt in widget.product.alternatives)
                          ProductCard(
                            product: alt,
                            onTap: () {
                              GreenListBloc()
                                  .add(AddProductGreenListEvent(alt));
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
