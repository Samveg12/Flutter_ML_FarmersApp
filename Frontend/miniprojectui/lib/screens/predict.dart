import 'dart:io';
import 'dart:convert';
import 'package:miniprojectui/screens/pages.dart';
import 'package:path/path.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';

class PredictScreen extends StatefulWidget {
  static const String id = "predict_screen";
  @override
  _PredictScreenState createState() => _PredictScreenState();
  PredictScreen(this.lang);
  final lang;
}

class _PredictScreenState extends State<PredictScreen> {
  var dict = {
    "Apple___Apple_scab" : "Apple scab is caused by the fungus Venturia inaequalis. The apple scab fungus overwinters on fallen diseased leaves. In spring, these fungi shoot spores into the air. Spores are carried by wind to newly developing leaves, flowers, fruit or green twigs.",
    "Apple___Black_rot" : "Leaf symptoms first occur early in the spring when the leaves are unfolding. They appear as small, purple specks on the upper surface of the leaves that enlarge into circular lesions 1/8 to 1/4 inch (3-6 mm) in diameter. The margin of the lesions remains purple, while the center turns tan to brown.",
    "Apple___Cedar_apple_rust" : "Cedar apple rust (Gymnosporangium juniperi-virginianae) is a fungal disease that requires juniper plants to complete its complicated two year life-cycle. These gradually enlarge to bright orange-yellow spots which make the disease easy to identify. Orange spots may develop on the fruit as well.",
    "Apple___healthy" : "No problem at all healthy apple.",

"Blueberry___healthy" : "No problem at all healthy blueberry",

"Cherry_(including_sour)___healthy" : "Moreover, tart cherries contain a good amount of tryptophan and anthocyanins, two compounds that may help the body create melatonin and lengthen its effects.",

"Cherry_(including_sour)___Powdery_mildew" : "Powdery mildew of sweet and sour cherry is caused by Podosphaera clandestina, an obligate biotrophic fungus. Mid- and late-season sweet cherry (Prunus avium) cultivars are commonly affected, rendering them unmarketable due to the covering of white fungal growth on the cherry surface." ,

"Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot" : "Grey leaf spot (GLS) is a foliar fungal disease that affects maize, also known as corn. GLS is considered one of the most significant yield-limiting diseases of corn worldwide. There are two fungal pathogens that cause GLS: Cercospora zeae-maydis and Cercospora zeina.",

"Corn_(maize)___Common_rust_" : "Common rust disease cycle. The fungus survives the winter as spores in subtropical and tropical regions; spores are carried long distances by wind and eventually reach the Midwest. Rust development is favored by high humidity with night temperatures of 65-70°F and moderate daytime temperatures.",

"Corn_(maize)___healthy" : "Healthy version no problem at all.",

"Corn_(maize)___Northern_Leaf_Blight" : "Northern corn leaf blight (NCLB) or Turcicum leaf blight (TLB) is a foliar disease of corn (maize) caused by Exserohilum turcicum, the anamorph of the ascomycete Setosphaeria turcica. With its characteristic cigar-shaped lesions, this disease can cause significant yield loss in susceptible corn hybrids.",

"Grape___Black_rot" : "Grape black rot is a fungal disease caused by an ascomycetous fungus, Guignardia bidwellii, that attacks grape vines during hot and humid weather. “Grape black rot originated in eastern North America, but now occurs in portions of Europe, South America, and Asia.",

"Grape___Esca_(Black_Measles)" : "Esca is a grape disease of mature grapevines. It is a type of grapevine trunk disease. The fungi Phaeoacremonium aleophilum, Phaeomoniella chlamydospora and Fomitiporia mediterranea are associated with the disease.",

"Grape___healthy" : "Healthy version no problem at all.",

"Grape___Leaf_blight_(Isariopsis_Leaf_Spot)" : "The yellow-green disease spots gradually appear on the fronts of the grape leaves with downy mildew, and white frosty mildew appears on the backs of the leaves. Leaf blight produces dark brown patches on the surface of grape leaves.",

"Orange___Haunglongbing_(Citrus_greening)" : "Huanglongbing (HLB) or citrus greening is the most severe citrus disease, currently devastating the citrus industry worldwide. The presumed causal bacterial agent Candidatus Liberibacter spp. affects tree health as well as fruit development, ripening and quality of citrus fruits and juice.",

"Peach___Bacterial_spot" : "Bacterial spot is an important disease of peaches, nectarines, apricots, and plums caused by Xanthomonas campestris pv. pruni. Symptoms of this disease include fruit spots, leaf spots, and twig cankers.Severe defoliation can result in reduced fruit size, and sunburn and cracking of fruit.",

"Peach___healthy" : "Healthy version no problem at all.",

"Pepper,_bell___Bacterial_spot" : "Bacterial spot is one of the most devastating diseases of pepper and tomato. The disease occurs worldwide where pepper and tomato are grown in warm, moist areas. When it occurs soon after transplanting and weather conditions remain favorable for disease development, the results are usually total crop loss." ,

"Pepper,_bell___healthy" : "Healthy version no problem at all.",

"Potato___Early_blight" : "Symptoms of early blight occur on fruit, stem and foliage of tomatoes and stem, foliage and tubers of potatoes. Initial symptoms on leaves appear as small 1-2 mm black or brown lesions and under conducive environmental conditions the lesions will enlarge and are often surrounded by a yellow halo.",

"Potato___healthy" : "Healthy version no problem at all.",

"Potato___Late_blight" : "Phytophthora infestans is an oomycete or water mold, a fungus-like microorganism that causes the serious potato and tomato disease known as late blight or potato blight. Early blight, caused by Alternaria solani, is also often called 'potato blight'.",

"Raspberry___healthy" : "Healthy version no problem at all.",

"Soybean___healthy" : "Healthy version no problem at all.",

"Squash___Powdery_mildew" : "Powdery mildew, mainly caused by the fungus Podosphaera xanthii, infects all cucurbits, including muskmelons, squash, cucumbers, gourds, watermelons and pumpkins. In severe cases, powdery mildew can cause premature death of leaves, and reduce yield and fruit quality.",

"Strawberry___healthy" : "Healthy version no problem at all",

"Strawberry___Leaf_scorch" : "Diplocarpon earlianum is a fungus that causes leaf scorch, one of the most common leaf diseases of strawberry. This ascomycete produces disk-shaped, dark brown to black apothecia (0.25-1 mm) on advanced-stage lesions on strawberry leaves and leaf residues (Heidenreich and Turechek).",
"Tomato___Bacterial_spot" : "Bacterial spot can affect all above ground parts of a tomato plant, including the leaves, stems, and fruit. Bacterial spot appears on leaves as small (less than ⅛ inch), sometimes water-soaked (i.e., wet-looking) circular areas. Spots may initially be yellow-green, but darken to brownish-red as they age.",

"Tomato___Early_blight" : "Early blight is one of the most common tomato diseases, occurring nearly every season wherever tomatoes are grown. It affects leaves, fruits and stems and can be severely yield limiting when susceptible cultivars are used and weather is favorable. Severe defoliation can occur and result in sunscald on the fruit.",

"Tomato___healthy" : "Healthy version no problem at all.",

"Tomato___Late_blight" : "Late blight is a potentially devastating disease of tomato and potato, infecting leaves, stems and fruits of tomato plants. The disease spreads quickly in fields and can result in total crop failure if untreated. Late blight of potato was responsible for the Irish potato famine of the late 1840s.",

"Tomato___Leaf_Mold" : "Occasionally, this pathogen causes disease on the blossoms or fruits with various symptoms. The blossoms may turn black and will be killed before fruit set. Green and ripe fruits will develop smooth black irregular area on the stem end. As the disease progresses, the infected area becomes sunken, dry and leathery.",

"Tomato___Septoria_leaf_spot" : "Septoria leaf spot is caused by a fungus, Septoria lycopersici. It is one of the most destructive diseases of tomato foliage and is particularly severe in areas where wet, humid weather persists for extended periods. Septoria leaf spot usually appears on the lower leaves after the first fruit sets.",

"Tomato___Spider_mites Two-spotted_spider_mite" : "The two-spotted spider mite is the most common mite species that attacks vegetable and fruit crops in New England. Spider mites can occur in tomato, eggplant, potato, vine crops such as melons, cucumbers, and other crops. Two-spotted spider mites are one of the most important pests of eggplant. They have up to 20 generations per year and are favored by excess nitrogen and dry and dusty conditions. Outbreaks are often caused by the use of broad-spectrum insecticides which interfere with the numerous natural enemies that help to manage mite populations. As with most pests, catching the problem early will mean easier control.",

"Tomato___Target_Spot" : "Target spot of tomato often causes necrotic lesions in a concentric pattern, similar to early blight. Target spot of tomato is favored by temperatures of 68 to 82°F and leaf wetness periods as long as 16 hours. The target spot fungus can survive in host residue for a period.",

"Tomato___Tomato_mosaic_virus" : "Tomato mosaic virus (ToMV) can cause yellowing and stunting of tomato plants resulting in loss of stand and reduced yield. ToMV may cause uneven ripening of fruit, further reducing yield. Tobacco mosaic virus (TMV) was once thought to be more common on tomato.",

"Tomato__Tomato_Yellow_Leaf_Curl_Virus" : "Tomato yellow leaf curl virus (TYLCV) is a DNA virus from the genus Begomovirus and the family Geminiviridae. TYLCV causes the most destructive disease of tomato, and it can be found in tropical and subtropical regions causing severe economic losses."

  };
  var description = " ";
  var lang = " ";
  var d = "";
  File _image;
  bool isLoading = false;
  final picker = ImagePicker();
  var response;
  String display = "Select an image";
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isLoading = true;
        sendReq();
      } else {
        print('No image selected.');
      }
    });
  }

  void sendReq() async {
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));

    var length = await _image.length();

    var uri = Uri.parse("http://10.0.2.2:5000/predict");

    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(_image.path));

    request.files.add(multipartFile);

    var res = await request.send();

    response = await http.Response.fromStream(res);

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      display = decoded["class"];
      print(display);
      description = dict[display];
      int flag =0;
      d = " ";
      for(int i=0; i<display.length; i++){
        if(display[i] == '_'){
          if(flag == 0){
            d = d + ' ';
          }
          flag = 1;
        }
        else{
          d = d + display[i];
          flag = 0;
        }
      }
      display = d;
      //display.replaceAll(RegExp(r'_'), ' ');
      isLoading = false;
    });
    print(lang);
    trans(description,display, lang);
  }



void trans(String input1,String input2, String lang) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(input1,
        from: "en", to: lang.substring(0, 2));
    var translation1 = await translator.translate(input2,
        from: "en", to: lang.substring(0, 2));
    print("translation: ${(translation).toString()}");
    setState(() {
      description = translation.toString();
      display = translation1.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    lang = widget.lang;
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Plant Disease'),
      ),
      body: Column(
        children: [
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (!isLoading)
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
              //:Text(display),
            ),
          if (!isLoading)
            Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      display,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                      child: Text(
                    description,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          description = " ";
          getImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
