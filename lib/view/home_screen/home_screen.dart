import 'package:flutter/material.dart';
import 'package:interviewtask03/controller/homescreencontroller.dart';
import 'package:interviewtask03/service/authhandel.dart';
import 'package:interviewtask03/view/loginscreen/login.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  String? userEmail;
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<Homescreencontroller>().getproducts();
    },);
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await AuthHandler.getUserName();
    final email = await AuthHandler.getUserEmail();
    
    setState(() {
      userName = name;
      userEmail = email;
      isLoading = false;
    });
  }

  Future<void> _handleLogout() async {
    await AuthHandler.logout();
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final homescreenstate=context.watch<Homescreencontroller>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'User Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(height: 30),
                              Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.blue),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Name: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      userName ?? 'N/A',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(Icons.email, color: Colors.green),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Email: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      userEmail ?? 'N/A',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                     GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,mainAxisSpacing: 15,crossAxisSpacing: 20, mainAxisExtent: 250), itemBuilder: (context, index) {
                      final homescreenstate=context.watch<Homescreencontroller>();
                       return homescreenstate.isLoading ? Center(child: CircularProgressIndicator(),) : Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(homescreenstate.product[index].image!, height: 120, width: double.infinity, fit: BoxFit.cover,),
                              const SizedBox(height: 10),
                              Text(homescreenstate.product[index].title!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5),
                              Text('\$${homescreenstate.product[index].price}', style: const TextStyle(fontSize: 14, color: Colors.green),),
                              const SizedBox(height: 5),
                              Expanded(child: Text(homescreenstate.product[index].description!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12),)),
                            ],
                          ),
                        ),
                       );
                     }, itemCount: homescreenstate.product.length, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}