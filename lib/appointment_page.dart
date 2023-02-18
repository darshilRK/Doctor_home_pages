import 'package:doctor_home_page/config.dart';
import 'package:flutter/material.dart';
class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus {upcomig,complete,cancle}

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status=FilterStatus.upcomig;
  Alignment _alignment=Alignment.centerLeft;
  List<dynamic> schedules=[
    {
      "doctor_name":"Richard Tan",
      "doctor_profile":"image/2.jpg",
      "category":"Dental",
      "status":FilterStatus.upcomig,
    },
    {
      "doctor_name":"Max Lim",
      "doctor_profile":"image/3.jpg",
      "category":"Cardiology",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"Jane Wong",
      "doctor_profile":"image/4.jpg",
      "category":"Respiration",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"Jenny Song",
      "doctor_profile":"image/5.jpg",
      "category":"Genral",
      "status":FilterStatus.cancle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule){
      // switch(schedule['status']){
      //   case 'upcoming':
      //     schedule['status']=FilterStatus.upcomig;
      //     break;
      //   case 'complete':
      //     schedule['status']=FilterStatus.complete;
      //     break;
      //   case 'cancle':
      //     schedule['status']=FilterStatus.cancle;
      //     break;
      // }
      return schedule['status'] == status;
    }).toList();
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
             const Text(
                'Appointment Schedule',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(FilterStatus filterStatus in FilterStatus.values)
                          Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(filterStatus==FilterStatus.upcomig){
                                      status=FilterStatus.upcomig;
                                      _alignment=Alignment.centerLeft;
                                    }else if(filterStatus==FilterStatus.complete){
                                      status=FilterStatus.complete;
                                      _alignment=Alignment.center;
                                    }else if(filterStatus==FilterStatus.cancle){
                                      status=FilterStatus.cancle;
                                      _alignment=Alignment.centerRight;
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text(filterStatus.name),
                                ),
                              ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedAlign(
                    alignment: _alignment,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Config.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          status.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Config.spaceSmall,
              Expanded(
                  child: ListView.builder(
                      itemCount: filteredSchedules.length,
                      itemBuilder: ((context,index){
                        var _schedule=filteredSchedules[index];
                        bool isLastElement=filteredSchedules.length+1==index;
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: !isLastElement
                            ?const EdgeInsets.only(bottom: 20)
                              :EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(_schedule['doctor_profile']),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _schedule['doctor_name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          _schedule['category'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const ScheduleCard(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: OutlinedButton(
                                          onPressed: (){},
                                          child: const Text(
                                              'Cancle',
                                            style: TextStyle(color: Config.primaryColor),
                                          ),
                                        ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Config.primaryColor,
                                          ),
                                          onPressed: (){},
                                          child: const Text(
                                            'Reschedule',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        );
                      }),
                  ),
              ),
            ],
          ),
        ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Colors.grey.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Icon(
            Icons.calendar_today,
            color:Config.primaryColor,
            size: 15,
          ),
          SizedBox(width: 5,),
          Text(
            'Monday, 11/28/2022',
            style: const TextStyle(color: Config.primaryColor),
          ),
          SizedBox(width: 20,),
          Icon(
            Icons.access_alarm,
            color:Config.primaryColor,
            size: 17,
          ),
          SizedBox(width: 5,),
          Flexible(child: Text('2:00 PM',style: TextStyle(color: Config.primaryColor),))
        ],
      ),
    );
  }
}
