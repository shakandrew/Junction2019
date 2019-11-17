import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlist/blocs/history/index.dart';
import 'package:greenlist/screens/main/widgets/expandableProductCard.dart';
import 'package:greenlist/screens/main/widgets/placeholderCard.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    if (HistoryBloc().state.products.length == 0)
      HistoryBloc().add(FetchHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: RefreshIndicator(
        onRefresh: () async {
          HistoryBloc().add(FetchHistoryEvent());
        },
        child: BlocBuilder(
          bloc: HistoryBloc(),
          builder: (context, HistoryState state) {
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
                return ExpandableProductCard(product: state.products[index]);
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
