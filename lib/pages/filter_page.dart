import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterPage extends StatefulWidget {
  static const routeName = '/filter';
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  FilterPage(this.currentFilters, this.saveFilters);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _glutenFree = false;

  bool _lactoseFree = false;

  bool _vegan = false;

  bool _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten-free'];

    _lactoseFree = widget.currentFilters['lactose-free'];

    _vegan = widget.currentFilters['vegan'];

    _vegetarian = widget.currentFilters['vegetarian'];

    super.initState();
  }

  Widget filterItemListBuilder(
      String title, String subtitle, bool initVal, Function switchVal) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: initVal,
        onChanged: switchVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filter Recipes'),
          actions: [
            IconButton(
                onPressed: () {
                  Map<String, bool> newFilterData = {
                    'gluten-free': _glutenFree,
                    'lactose-free': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian
                  };

                  widget.saveFilters(newFilterData);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your recipe selection!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  filterItemListBuilder(
                      'Gluten free',
                      'Only select gluten free recipes',
                      _glutenFree, (selectedVal) {
                    setState(() {
                      _glutenFree = selectedVal;
                    });
                  }),
                  filterItemListBuilder(
                      'Lactose free',
                      'Only select lactose free recipes',
                      _lactoseFree, (selectedVal) {
                    setState(() {
                      _lactoseFree = selectedVal;
                    });
                  }),
                  filterItemListBuilder(
                      'Vegan', 'Only select vegan recipes', _vegan,
                      (selectedVal) {
                    setState(() {
                      _vegan = selectedVal;
                    });
                  }),
                  filterItemListBuilder(
                      'Vegetarian',
                      'Only select vegetarian recipes',
                      _vegetarian, (selectedVal) {
                    setState(() {
                      _vegetarian = selectedVal;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
