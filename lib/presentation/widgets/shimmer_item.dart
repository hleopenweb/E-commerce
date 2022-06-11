import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sajilo_dokan/config/theme.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    Key? key,
    required this.isGrid,
    this.crossAxisCount = 2,
    this.itemCount = 4,
  }) : super(key: key);

  final bool isGrid;
  final int crossAxisCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 5),
        primary: false,
        crossAxisCount: crossAxisCount,
        itemCount: itemCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) => Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        color: AppColors.darkGray.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 20,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 10,
          top: 10,
        ),
        child: Stack(
          children: [
            Card(
              elevation: 2,
              child: Row(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    color: AppColors.darkGray.withOpacity(0.2),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              color: AppColors.darkGray.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.darkGray.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 15,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppColors.darkGray.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.darkGray.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
