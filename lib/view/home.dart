import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';
import 'package:newsapp/model/news_model.dart';
class HomePage extends GetWidget {
  HomePage({super.key});
  @override
  final NewsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false  ,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News App"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(onPressed: (){
              controller.changeTheme();
            }, icon: const Icon(Icons.dark_mode))
          ],
        ),
        body: FutureBuilder(
          future: controller.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Articles data = snapshot.data;
              return ListView.builder(
                  itemCount: data.articles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(20),
                      elevation: 10,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: (){controller.openUrl(data.articles[index].url);},
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  data.articles[index].urlToImage == null
                                      ? "https://cdn3.iconfinder.com/data/icons/web-development-and-programming-2/64/development_Not_Found-512.png"
                                      : data.articles[index].urlToImage.toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(height: 5,),
                              ListTile(title: SelectableText(data.articles[index].title,textAlign: TextAlign.start,style: const TextStyle(fontSize: 16),),),
                              const SizedBox(height: 10,),
                              Text("Source: ${data.articles[index].source.name}",textAlign: TextAlign.start,),

                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.inversePrimary,));
            }
          },
        ),
      ),
    );
  }
}
