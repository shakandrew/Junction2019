import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlist/blocs/index.dart';
import 'package:greenlist/screens/main/widgets/placeholderCard.dart';
import 'package:greenlist/screens/main/widgets/productCard.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    if (GreenListBloc().state.products.length == 0)
      GreenListBloc().add(FetchGreenListEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: RefreshIndicator(
        onRefresh: () async {
          GreenListBloc().add(FetchGreenListEvent());
        },
        child: BlocBuilder(
          bloc: GreenListBloc(),
          builder: (context, GreenListState state) {
            if (state.products.length == 0)
              return Column(
                children: <Widget>[
                  PlaceholderCard(fade: 0),
                  PlaceholderCard(fade: 1),
                  PlaceholderCard(fade: 2),
                ],
              );
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: state.products[index]);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;
}
