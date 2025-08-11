import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:time_management_ai/constants/app_colors.dart';
import 'package:time_management_ai/constants/texts.dart';
import 'package:time_management_ai/di/injector.dart';
import 'package:time_management_ai/domain/entities/schedule_entity.dart';
import 'package:time_management_ai/domain/entities/task_entity.dart';
import 'package:time_management_ai/presentation/screens/detail.dart';
import 'package:time_management_ai/presentation/stores/add_schedule_store.dart';
import 'package:time_management_ai/utils/context_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final AddScheduleStore store = getIt<AddScheduleStore>();

  bool isLoading = false;

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<ScheduleEntity> filteredTasksList = [];

  @override
  void initState() {
    super.initState();
    store.loadTasksFromPrefs().then((_) {
      setState(() {
        filteredTasksList = List.from(store.tasksList);
      });
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void _searchTasks(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredTasksList = List.from(store.tasksList);
      } else {
        filteredTasksList = store.tasksList
            .where((task) =>
                task.title.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueGrey,
      floatingActionButton: _buildFloatingButton(context),
      drawer: _rightDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            34.height,
            _inputSearch(context),
            _buildTaskList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.indigo,
      onPressed: () {
        Navigator.pushNamed(context, '/add_schedule');
      },
      child: const Icon(
        Icons.add,
        color: AppColors.White000,
      ),
    );
  }

  Widget _buildTaskList() {
    return Observer(
      builder: (_) {
        if (store.tasksList.isEmpty) {
          return _buildEmptyMessage();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredTasksList.length,
          itemBuilder: (context, index) {
            return _buildTaskCard(filteredTasksList[index]);
          },
        );
      },
    );
  }

  Widget _buildEmptyMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        300.height,
        Center(
          child: Text(
            'Không có lịch trình công việc nào',
            style: CustomTextStyle.textNormal(context).copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(ScheduleEntity data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailScreen(data: data), // <-- truyền trực tiếp object
          ),
        );
      },
      child: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.White000,
            border: Border.all(color: AppColors.indigoAccent, width: 1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTaskCardHeader(data.title),
              Column(
                children: data.tasks.map(_buildTaskItem).toList(),
              ),
              _buildTaskDate(data.date),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCardHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.neutral100, width: 0.5),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: CustomTextStyle.customTextStyle().copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.blueGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(TaskEntity item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.White000,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${item.time} ${item.description}',
              style: CustomTextStyle.customTextStyle().copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.charcoal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDate(DateTime date) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          _formatDate(date),
          style: CustomTextStyle.customTextStyle().copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.charcoal,
          ),
        ),
      ),
    );
  }

  Widget _rightDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.White000,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Text('AI TimeGenie',
                  style: CustomTextStyle.textLarge(context).copyWith(
                      color: AppColors.Primary, fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Lưu ý'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Lời nhắc'),
            onTap: () {},
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Tạo nhãn mới'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Lưu trữ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Thùng rác'),
            onTap: () {},
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Phản hồi về ứng dụng'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Trợ giúp'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _inputSearch(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // độ lệch đổ bóng (x, y)
          ),
        ],
      ),
      child: TextField(
        cursorColor: AppColors.neutral400,
        controller: _controller,
        onChanged: (value) {
          _searchTasks(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          enabledBorder: InputBorder.none
          // OutlineInputBorder(
          //     borderSide: BorderSide(width: 0.5, color: AppColors.neutral300),
          //     borderRadius: BorderRadius.circular(16))
          ,
          focusedBorder: InputBorder.none,
          //  OutlineInputBorder(
          //     borderSide: BorderSide(width: 1.0, color: AppColors.neutral300),
          //     borderRadius: BorderRadius.circular(16))

          hintText: 'Tìm kiếm ghi chú',
          hintStyle: CustomTextStyle.textNormal(context)
              .copyWith(color: AppColors.neutral400),
          prefixIcon: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.dehaze_outlined));
          }),
          border: InputBorder.none,
          // OutlineInputBorder(
          //     borderSide: BorderSide(width: 0.5),
          //     borderRadius: BorderRadius.circular(16))
        ),
      ),
    );
  }
}
