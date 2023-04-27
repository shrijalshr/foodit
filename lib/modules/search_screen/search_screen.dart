import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/modules/item_list/view/item_list.dart';
import 'package:foodit/modules/search_screen/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchBarDelegate extends SearchDelegate {
  List? recentSuggest;

  List<String>? foodList;

  SearchBarDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = "")
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page

        close(context, null);
      },
    );
  }

  List<ItemModel> itemList = <ItemModel>[];
  String oldQuery = "";
  @override
  Widget buildResults(BuildContext context) {
    final SearchProvider provider = Provider.of<SearchProvider>(context);
    String queryStr = "";

    queryStr = query.toLowerCase();
    print(queryStr);
    if (oldQuery == queryStr) {
      return ListView.builder(
        itemCount: itemList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final ItemModel item = itemList[index];
          return ItemCard(item: item);
        },
      );
    }
    oldQuery = queryStr;
    return FutureBuilder(
      future: provider.getSearchedItems(queryStr),
      builder: (context, snapshot) {
        print(snapshot.error);
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text("No item found!"),
          );
        } else {
          itemList = snapshot.data!;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final ItemModel item = snapshot.data![index];
              return ItemCard(item: item);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String queryStr = query.toLowerCase();
    List<ItemModel> suggestions = [];
    // final SearchProvider provider = Provider.of<SearchProvider>(context);
    // provider.getSearchedItems(queryStr).then((isSucsess) {
    //   if (isSucsess != null && isSucsess) {
    //     suggestions = provider.searchedResult;
    //   }
    // });

//TODO: UI change
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                query = suggestions[index].name ?? "";
                showResults(context);

                if (!recentSuggest!.contains(query)) {
                  recentSuggest!.insert(0, query);
                }
              },
              title: RichText(
                  text: TextSpan(
                      text: suggestions[index].name?.substring(0, query.length),
                      style: context.textStyles.bodyLarge,
                      children: [
                    TextSpan(
                      text: suggestions[index].name?.substring(query.length),
                      style: context.textStyles.bodyMedium,
                    )
                  ])),
            ));
  }
}
