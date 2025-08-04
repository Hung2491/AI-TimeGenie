import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:time_management_ai/constants/app_colors.dart';
import 'package:time_management_ai/constants/texts.dart';
import 'package:time_management_ai/di/service_locator.dart';
import 'package:time_management_ai/domain/entities/task_entity.dart';
import 'package:time_management_ai/presentation/stores/add_schedule_store.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final AddScheduleStore store = getIt<AddScheduleStore>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    store.loadTasksFromPrefs();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueGreye,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.indigo,
      centerTitle: true,
      title: Text(
        'Chi tiết công việc',
        style: CustomTextStyle.textLarge(context).copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.White000,
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/').then((_) async {
            await store.loadTasksFromPrefs();
          });
        },
        child:
            const Icon(Icons.chevron_left, size: 30, color: AppColors.White000),
      ),
      actions: [
        Observer(
          builder: (_) {
            return IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.White000),
              onPressed: () async {
                await store.deleteTask(_selectedIndex);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Observer(
          builder: (_) => _buildTaskDetailList(context),
        ),
      ),
    );
  }

  Widget _buildTaskDetailList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: store.tasksList.length,
      itemBuilder: (context, index) {
        var data = store.tasksList[index];
        _selectedIndex = index;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Ngày ${_formatDate(data.date)}",
                style: CustomTextStyle.textNormal(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBlueGrey,
                ),
              ),
            ),
            Column(
              children: data.tasks
                  .map((item) => _buildTaskItem(context, item))
                  .toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskItem(BuildContext context, TaskEntity item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.White000,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10, right: 5),
        leading: item.isCompleted
            ? const Icon(Icons.check_circle, color: AppColors.green)
            : const SizedBox(),
        title: Text(
          "${item.time} ${item.description}",
          style: CustomTextStyle.textNormal(context).copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.charcoal,
          ),
        ),
        trailing: IconButton(
          icon:
              const Icon(Icons.more_horiz, size: 24, color: AppColors.gray500),
          onPressed: () => _showTaskActionDialog(context, item),
        ),
      ),
    );
  }

  void _showTaskActionDialog(BuildContext context, TaskEntity item) {
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.White000,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text('Bạn muốn hoàn thành công việc này?',
                    style: CustomTextStyle.textNormal(context)
                        .copyWith(fontWeight: FontWeight.w500, color: AppColors.indigo)),
              ),
              const Divider(height: 0, color: AppColors.indigo,),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        store.deleteTaskById(item.id);
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Xoá',
                          style: CustomTextStyle.customTextStyle().copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.red500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5, color: AppColors.indigo),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          item.isCompleted = true;
                        });
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Hoàn thành',
                          style: CustomTextStyle.customTextStyle().copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
