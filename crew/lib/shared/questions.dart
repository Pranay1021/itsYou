import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Questionsss extends StatefulWidget {
  const Questionsss({super.key});

  @override
  State<Questionsss> createState() => _QuestionsssState();
}

class _QuestionsssState extends State<Questionsss> {
  
  var question = [  
    
    "Most likely to become a successful app developer",
  "Most likely to become a varsity cheerleader",
  "Most likely to win a school science fair",
  "Most likely to start a successful online business",
  "Most likely to become a skilled beatboxer",
  "Most likely to have the best sense of humor",
  "Most likely to become a talented digital artist",
  "Most likely to excel in a school debate club",
  "Most likely to win a school writing competition",
  "Most likely to have the most impressive sneaker collection",
  "Most likely to become a popular Instagram influencer",
  "Most likely to start a successful gaming YouTube channel",
  "Most likely to have the most creative DIY projects",
  "Most likely to become a star in school choir or band",
  "Most likely to excel in a school robotics club",
  "Most likely to become a professional breakdancer",
  "Most likely to win a school poetry slam",
  "Most likely to have the best skateboarding tricks",
  "Most likely to become a talented spoken word poet",
  "Most likely to create viral internet challenges",
  "Most likely to be voted as the most caring person in class",
  "Most likely to excel in a school mathletes team",
  "Most likely to become a star in school drama productions",
  "Most likely to start a successful e-commerce store",
  "Most likely to have the most followers on TikTok",
  "Most likely to become a skilled freestyle rapper",
  "Most likely to win a school art exhibit",
  "Most likely to have the best gaming setup",
  "Most likely to become a successful young fashion designer",
  "Most likely to excel in a school coding club",
  "Most likely to win a school sports MVP award",
  "Most likely to have the most unique fashion style",
  "Most likely to become a talented parkour athlete",
  "Most likely to start a successful podcast",
  "Most likely to excel in a school photography club",
  "Most likely to win a school spelling bee",
  "Most likely to have the most followers on Snapchat",
  "Most likely to become a successful young musician",
  "Most likely to organize the best school events",
  "Most likely to excel in a school environmental club",
  "Most likely to start a successful clothing brand",
  "Most likely to have the most impressive makeup skills",
    "Most likely to become a millionaire",
      "Most likely to forget their own birthday",
      "Most likely to become a famous actor/actress",
      "Most likely to win a reality TV show",
      "Most likely to travel the world",
      "Most likely to become a professional athlete",
      "Most likely to own a zoo",
      "Most likely to become a rockstar",
      "Most likely to win a Nobel Prize",
      "Most likely to invent something useful",
      "Most likely to skydive without fear",
      "Most likely to become a famous chef",
      "Most likely to start their own business",
      "Most likely to win a game show",
      "Most likely to become a superhero",
      "Most likely to sleep through an earthquake",
      "Most likely to become a world-renowned artist",
      "Most likely to be a stand-up comedian",
      "Most likely to become a bestselling author",
      "Most likely to become a famous fashion designer",
      "Most likely to survive a zombie apocalypse",
      "Most likely to win a hot dog eating contest",
      "Most likely to be a professional gamer",
      "Most likely to become a famous YouTuber",
      "Most likely to win a dance competition",
      "Most likely to become a professional surfer",
      "Most likely to star in a reality TV show",
      "Most likely to live in a foreign country",
      "Most likely to become a renowned scientist",
      "Most likely to win an Olympic gold medal",
      "Most likely to become a famous musician",
      "Most likely to have the most pets",
      "Most likely to become a world-class chef",
      "Most likely to join the circus",
      "Most likely to win a singing competition",
      "Most likely to climb Mount Everest",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big tech gadget",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a professional athlete",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous actor/actress",
      "Most likely to become a professional dancer",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big thing",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a famous actor/actress",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big thing",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a famous actor/actress",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big thing",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a famous actor/actress",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big thing",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a famous actor/actress",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big thing",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a famous actor/actress",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to invent the next big thing",
      "Most likely to become a famous writer",
      "Most likely to have their own reality TV show",
      "Most likely to become a famous actor/actress",
      "Most likely to win a Grammy Award",
      "Most likely to become a famous director",
      "Most likely to win a gold medal in the Olympics",
      "Most likely to become a famous comedian",
      "Most likely to have their own TV show",
      "Most likely to become a famous painter",
      "Most likely to win a Nobel Peace Prize",
      "Most likely to become a famous fashion designer",
      "Most likely to travel the world",
      "Most likely to start their own successful business",
      "Most likely to win a singing competition",
      "Most likely to become a famous musician",
      "Most likely to become a renowned scientist",
      "Most likely to become a professional surfer",
      "Most likely to win a Pulitzer Prize",
      "Most likely to become a famous chef",
      "Most likely to join the circus",
      "Most likely to become a bestselling author",
      "Most likely to become a professional athlete",
      "Most likely to win an Oscar",
      "Most likely to start their own nonprofit organization",
      "Most likely to become a famous model",
      "Most likely to become a professional photographer",
      "Most likely to win a marathon",
      "Most likely to become a famous dancer",
      "Most likely to become a professional gamer",
  "Most likely to adopt a pet from a shelter",
  "Most likely to become a professional surfer",
  "Most likely to become a famous YouTuber",
  "Most likely to become a master at chess",
  "Most likely to learn to juggle",
  "Most likely to become a fashion designer",
  "Most likely to win a lottery jackpot",
  "Most likely to become a successful stand-up comedian",
  "Most likely to start a popular podcast",
  "Most likely to become a professional photographer",
  "Most likely to master the art of cooking",
  "Most likely to become a top-tier poker player",
  "Most likely to become a professional rock climber",
  "Most likely to go on a world tour as a musician",
  "Most likely to become an expert in martial arts",
  "Most likely to invent something revolutionary",
  "Most likely to become a world-renowned architect",
  "Most likely to learn to do parkour",
  "Most likely to become a professional dancer",
  "Most likely to discover a cure for a disease",
  "Most likely to become a successful motivational speaker",
  "Most likely to become a master at playing poker",
  "Most likely to compete in the Olympics",
  "Most likely to become a professional race car driver",
  "Most likely to become a well-known fashion model",
  "Most likely to travel to space",
  "Most likely to become a master of disguise",
  "Most likely to start a successful charity",
  "Most likely to become a professional magician",
  "Most likely to write and direct a blockbuster movie",
  "Most likely to become a professional skateboarder",
  "Most likely to become a top-level hacker",
  "Most likely to become a renowned art collector",
  "Most likely to become a successful fashion blogger",
  "Most likely to become a famous wildlife photographer",
  "Most likely to become a world-class synchronized swimmer",
  "Most likely to start a popular food truck",
  "Most likely to become a professional e-sports player",
  "Most likely to become a recognized motivational speaker",
  "Most likely to win an Academy Award",
  "Most likely to become a respected university professor",
  "Most likely to become a professional ballet dancer",
  "Most likely to build a successful tech startup",
  "Most likely to become a master calligrapher",
  "Most likely to become a social media influencer",
  "Most likely to pull an all-nighter studying",
  "Most likely to win a school talent show",
  "Most likely to start their own YouTube channel",
  "Most likely to become a high school class president",
  "Most likely to have the messiest locker",
  "Most likely to become a varsity sports team captain",
  "Most likely to spend the most time on their phone",
  "Most likely to have the most stylish outfit",
  "Most likely to become a popular TikTok star",
  "Most likely to organize the best parties",
  "Most likely to become a famous teenage entrepreneur",
  "Most likely to become a fashion trendsetter",
  "Most likely to have the largest collection of sneakers",
  "Most likely to excel in school academics",
  "Most likely to become a skilled skateboarder",
  "Most likely to become a professional gamer",
  "Most likely to have the best dance moves",
  "Most likely to become a talented graffiti artist",
  "Most likely to travel the world during summer break",
  "Most likely to be voted as the funniest person in class",
  "Most likely to become a successful young author",
  "Most likely to become a star in school theater productions",
  "Most likely to organize charity events and fundraisers",
  "Most likely to have the most followers on Instagram",
  "Most likely to become a self-taught coding genius",
  "Most likely to win a debate competition",
  "Most likely to be found at the local skate park",
  "Most likely to have the coolest hairstyle",
  "Most likely to become a talented street dancer",
  "Most likely to become a successful young chef",
  "Most likely to have the highest grades in math and science",
  "Most likely to start their own band",
  "Most likely to become a professional photographer",
  "Most likely to win a school art competition",
  "Most likely to excel in a foreign language class",
  "Most likely to become a top athlete in their chosen sport",
  "Most likely to become a successful young filmmaker",
  "Most likely to be voted as the best-dressed in the yearbook",
  "Most likely to become a youth activist",
  "Most likely to volunteer the most hours in community service",
  "Most likely to start their own fashion line",
  "Most likely to become a popular beauty influencer",
  "Most likely to become a successful young entrepreneur",
  "Most likely to win a school spelling competition",
  "Most likely to start a popular vlogging channel",
  "Most likely to become a skilled beat maker",
  "Most likely to have the most followers on Twitter",
  "Most likely to excel in a school robotics competition",
  "Most likely to become a talented street artist",
  "Most likely to win a school drama festival",
  "Most likely to have the best skateboarding style",
  "Most likely to become a successful young actor/actress",
  "Most likely to start a popular fashion blog",
  "Most likely to have the most impressive video editing skills",
  "Most likely to become a star in school dance performances",
  "Most likely to excel in a school science club",
  "Most likely to win a school debate championship",
  "Most likely to have the most followers on Twitch",
  "Most likely to become a skilled freestyle footballer",
  "Most likely to create the most viral social media challenges",
  "Most likely to be voted as the most supportive friend",
  "Most likely to excel in a school math competition",
  "Most likely to become a successful young singer",
  "Most likely to start a popular beauty vlog",
  "Most likely to have the most impressive video game collection",
  "Most likely to win a school art scholarship",
  "Most likely to have the best graffiti skills",
  "Most likely to become a talented slam poet",
  "Most likely to excel in a school computer club",
  "Most likely to win a school sports tournament",
  "Most likely to have the most unique fashion sense",
  "Most likely to become a successful young filmmaker",
  "Most likely to start a popular podcast series",
  "Most likely to excel in a school photography competition",
  "Most likely to win a school spelling challenge",
  "Most likely to have the most followers on Instagram",
  "Most likely to become a skilled young guitarist",
  "Most likely to organize the best school fundraisers",
  "Most likely to excel in a school environmental project",
  "Most likely to start a successful online boutique",
  "Most likely to have the most impressive makeup artistry",
  ];
  Future updateQuestion(String questions) async {
                  return await questionCollection
                  .doc()
                  .set({
                    'questions': questions, 
                    });
          }
  final CollectionReference questionCollection =
      FirebaseFirestore.instance.collection('questions');
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:                
      FloatingActionButton(onPressed: (){
              // for (var i = 0; i < question.length; i++) {
              //   print(question[i]);
              //   updateQuestion(question[i]);
              // }
              print(question.length);
            }
            ),
           
      );
  }
}