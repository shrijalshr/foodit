import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';

class SearchBarDelegate extends SearchDelegate {
  List? recentSuggest;

  List<String>? foodList;

  SearchBarDelegate() {
    foodList = [
      "Momo",
      "Chowmein",
      "Burger",
      "Coffee",
      "Americano",
      "Water",
      "Pasta",
      "Sandwich"
    ];
    recentSuggest = ['Americano', 'Burger'];
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = "")
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading

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

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: Card(
          color: Colors.redAccent,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String queryStr = query.toLowerCase();

    List<String> suggestions = foodList!.where((element) {
      final result = element.toLowerCase();
      return result.contains(queryStr);
    }).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                query = suggestions[index];
                showResults(context);

                if (!recentSuggest!.contains(query)) {
                  recentSuggest!.insert(0, query);
                }
              },
              title: RichText(
                  text: TextSpan(
                      text: suggestions[index].substring(0, query.length),
                      style: context.textTheme.bodyLarge,
                      children: [
                    TextSpan(
                      text: suggestions[index].substring(query.length),
                      style: context.textTheme.bodyMedium,
                    )
                  ])),
            ));
  }
}
