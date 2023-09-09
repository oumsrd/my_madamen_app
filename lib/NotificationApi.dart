import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationApi{
  static final _notifications=FlutterLocalNotificationsPlugin();
  static final onNotifications=BehaviorSubject<NotificationResponse?>();
 static Future _notificationDetails()async{
  return const NotificationDetails(
   android: AndroidNotificationDetails( 
    'Channel id',
    'Channel name',
    ),
  );

 }
 static Future init({bool initScheduled=false})async{
  final android=AndroidInitializationSettings('@drawable/ic_launcher');
  final settings=InitializationSettings(android: android);
  await _notifications.initialize(settings,
  onDidReceiveNotificationResponse: ( payload) async{
    onNotifications.add(payload );
  } ,);
if(initScheduled){
  tzdata.initializeTimeZones();
  final locationName=await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(locationName));
}
 }
 static Future showNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
  }) async=>
  _notifications.show(
    id,
   title, 
  body,
  await _notificationDetails(),
  payload: payload);
   static Future showScheduledNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate
  }) async=>
  _notifications.zonedSchedule(
    id,
   title, 
  body,
  //_scheduleWeekly(DateTime(8),days:[DateTime.friday,DateTime.saturday]),
//_scheduleDaily(DateTime(17,16)),
tz.TZDateTime.from(scheduledDate,tz.local),
  await _notificationDetails(),
  payload: payload,
  androidAllowWhileIdle: true,
  uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
 //matchDateTimeComponents: DateTimeComponents.time,
  );
  static tz.TZDateTime _scheduleDaily(DateTime time) {
    final now=tz.TZDateTime.now(tz.local);
    final scheduleDate=tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,time.minute,time.second );
      return scheduleDate.isBefore(now)?
       scheduleDate.add(const Duration(minutes: 1))
      :scheduleDate;
  }
static tz.TZDateTime _scheduleWeekly(DateTime time,{required List<int> days}){
  tz.TZDateTime scheduleDate=_scheduleDaily(time);
  while(!days.contains(scheduleDate.weekday)){
    scheduleDate=scheduleDate.add(Duration(minutes: 1));
  }
    return scheduleDate;
}

}