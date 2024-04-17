import 'package:api_crud_operation_jan/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeScreenController>(context, listen: false)
          .getEmployees();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenController>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter",
                    label: Text("Employee Name"),
                    fillColor: Colors.lightBlue.withOpacity(.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    label: Text("Designation"),
                    hintText: "Enter",
                    fillColor: Colors.lightBlue.withOpacity(.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      await Provider.of<HomeScreenController>(context,
                              listen: false)
                          .addEmployee();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.3),
                          borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  )),
                  SizedBox(width: 20),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.3),
                          borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<HomeScreenController>(context,
                          listen: false)
                      .getEmployees();
                },
                child: provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: provider.employeesList.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(
                                      provider.employeesList[index].name ?? ""),
                                  subtitle: Text(
                                      provider.employeesList[index].role ?? ""),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        // await Provider.of<HomeScreenController>(
                                        //         context,
                                        //         listen: false)
                                        //     .deleteEmployee(provider
                                        //         .employeesList[index].id);
                                        await Provider.of<HomeScreenController>(
                                                context,
                                                listen: false)
                                            .updateEmployee(provider
                                                .employeesList[index].id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ),
                              ),
                            )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
