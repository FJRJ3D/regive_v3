import 'package:flutter/material.dart';
import '../models/Subcategory.dart';

class SubcategoryComponent extends StatelessWidget {
  final List<Subcategory> subcategoryList;
  final String categoryName;
  const SubcategoryComponent({super.key, required this.subcategoryList, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            ),
       LayoutBuilder(
          builder: (context, constraints) {
            final double itemWidth = 100;
            final int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 3.5,
              ),
              itemCount: subcategoryList.length,
              itemBuilder: (context, index) {
                final subcategory = subcategoryList[index];
                return InkWell(
                  onTap: () {
                    print("Tapped on subcategory ${subcategory.name}");
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      child: Text(
                        "> ${subcategory.name}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
          ],
        )
      ),
    );
  }
}
