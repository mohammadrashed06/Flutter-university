import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/universities_conttroller.dart';
import '../models/universities_response_model.dart';
import '../providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final _controller = ScrollController();
    List<UniversitiesResponseModel?>? searchResult = [];
    final TextEditingController filterController = TextEditingController();


    final country = ref.watch(countryProvider).pCountry;
    final response = ref.watch(messagesFamily(country.toString()));

    // first variable is to get the data of Authenticated User
    final data = ref.watch(fireBaseAuthProvider);

    //  Second variable to access the Logout Function
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.currentUser!.email ?? 'You are logged In'),
      ),
      body: response.isLoading ? const Center(child: CircularProgressIndicator(),) : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: filterController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search here',
                ),
              ),
              DropdownButton(
                hint: const Text("Choose country"),
                value: country,
                items: <String>["jordan", "egypt", "spain"]
                    .map((e) => DropdownMenuItem<String>(

                  onTap: () => e,
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (value) {
                  ref.read(countryProvider).countryOnChanged(value.toString());
                },
              ),
              response.listDataModel.isEmpty ?
              const Text('Select country')
              :
                  Expanded(
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (scrollEnd){
                        final metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          bool isTop = metrics.pixels == 0;
                          if (isTop) {
                          } else {
                            // response.addPagination(response.listDataModel);
                          }
                        }
                        return true;
                      },
                      child:filterController.text == "" ? ListView.builder(
                        itemCount: response.listDataModel.length,
                        controller: _controller,
                        itemBuilder: (context, index){
                          return Card(
                            child: ListTile(
                              title: Text(
                                  response.listDataModel[index].name??""
                              ),
                            ),
                          );
                        },
                      ) :ListView.builder(
                        itemCount: searchResult.length,
                        controller: _controller,
                        itemBuilder: (context, index){
                          return Card(
                            child: ListTile(
                              title: Text(
                                  searchResult[index]?.name??""
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              Container(
                padding: const EdgeInsets.only(top: 48.0),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () => auth.signOut(),
                  textColor: Colors.blue.shade700,
                  textTheme: ButtonTextTheme.primary,
                  minWidth: 100,
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.blue.shade700),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
final countryProvider =
ChangeNotifierProvider<PostProvider>((ref) => PostProvider());

class PostProvider extends ChangeNotifier {

  String? _country;

  String? get pCountry => _country;

  countryOnChanged(String value) {
    if (value.isEmpty) {
      return _country;
    }
    _country = value;
    print(_country);

    return notifyListeners();
  }
}
