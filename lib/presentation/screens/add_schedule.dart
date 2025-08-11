import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:time_management_ai/constants/app_colors.dart';
import 'package:time_management_ai/constants/texts.dart';
import 'package:time_management_ai/di/injector.dart';
import 'package:time_management_ai/domain/entities/task_entity.dart';
import 'package:time_management_ai/domain/entities/task_input_entity.dart';
import 'package:time_management_ai/presentation/screens/home.dart';
import 'package:time_management_ai/presentation/stores/add_schedule_store.dart';
import 'package:time_management_ai/presentation/widgets/button_widget.dart';
import 'package:time_management_ai/utils/context_extension.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final TextEditingController _textController = TextEditingController();
  final AddScheduleStore store = getIt<AddScheduleStore>();
  SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false;
  String _lastWords = '';
  String _currentLocaleId = 'vi-VN'; 
  int _maxLength = 100;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _textController.dispose();
    _speechToText.stop();
    super.dispose();
  }

  void _initSpeech() async {
    speechEnabled = await _speechToText.initialize();
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: _currentLocaleId, );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      if (_lastWords.length > _maxLength) {
        _lastWords = _lastWords.substring(0, _maxLength);
      }

      _textController.text = _lastWords;

      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.White000,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildBody(context),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.indigo,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child:
            const Icon(Icons.chevron_left, size: 32, color: AppColors.White000),
      ),
      title: Text('Thêm lịch trình',
          style: CustomTextStyle.textLarge(context).copyWith(
              color: AppColors.White000, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          16.height,
          _inputDescription(context),
          16.height,
          _buildScheduleList(),
        ],
      ),
    );
  }

  Widget _inputDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreys, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _textController,
            maxLines: 5,
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nhập thông tin lịch trình hôm nay của bạn',
              hintStyle: CustomTextStyle.textNormal(context).copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.gray500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _speechToText.isNotListening
                      ? _startListening()
                      : _stopListening();
                },
                child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                  color: AppColors.primaryBlue,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await store.fetchTasks(
                      TaskInputEntity(inputText: _textController.text));
                },
                child: const Icon(Icons.arrow_circle_right_rounded, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList() {
    return Observer(
      builder: (_) => store.isLoading
          ? Column(
              children: [
                200.height,
                const Center(child: CircularProgressIndicator(color: AppColors.neutral500,)),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: store.schedules.length,
              itemBuilder: (_, index) {
                var data = store.schedules[index];
                return Column(
                  children: data.tasks.map(_buildTaskItem).toList(),
                );
              },
            ),
    );
  }

  Widget _buildTaskItem(TaskEntity item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.White000,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            item.time,
            style: CustomTextStyle.customTextStyle()
                .copyWith(color: AppColors.black),
          ),
          4.width,
          Text(
            item.description,
            style: CustomTextStyle.customTextStyle()
                .copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: ButtonWidget(
        title: 'Thêm lịch trình công việc',
        onPressed: () async {
          await store.addTask(store.schedules);
          await store.loadTasksFromPrefs();
          if (store.isSuccess == true &&
              store.loadSuccess == true &&
              _textController.text.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Lịch trình đã được lưu thành công')),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Vui lòng nhập lịch trình trước')),
            );
          }
        },
      ),
    );
  }
}
