import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/normal_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fireblogs/date_enum.dart';

class Paginator extends StatefulWidget {
  @override
  _PaginatorState createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  bool isLoading = false;

  void onClick(DateType dateType) async {
    Provider.of<Blogs>(context, listen: false)
        .resetFetchingBooleans(true, true);
    setState(() {
      isLoading = true;
    });
    await Provider.of<Blogs>(context, listen: false)
        .fetchBlogsFromFirebase(false, dateType);
    Provider.of<Blogs>(context, listen: false)
        .resetFetchingBooleans(false, true);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Blogs>(
      builder: (ctx, blogs, _) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: !blogs.selectedDate.isAfter(DateTime.utc(2020, 08, 30))
                ? null
                : () => onClick(DateType.older),
          ),
          isLoading
              ? NormalLoader(
                  size: 18,
                )
              : Text(DateFormat('MMM-dd').format(blogs.getSelectedDate)),
          IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: !blogs.selectedDate
                      .isBefore(DateTime.now().subtract(Duration(days: 1)))
                  ? null
                  : () => onClick(DateType.newer)),
        ],
      ),
    );
  }
}