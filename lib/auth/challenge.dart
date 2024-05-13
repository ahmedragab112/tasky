import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/colors.dart';

class challenge extends StatefulWidget {
  const challenge({super.key});

  @override
  _challengeState createState() => _challengeState();
}

class _challengeState extends State<challenge> {
  final List<String> availableTopics = [
    'Self Love',
    'Read Book',
    'Workout',
    'Learning',
    'Routine',
    'Health',
    'Mental Health',
    'Lifestyle',
    'Productivity',
    'Positivity',
    'Personal Growth',
  ];

  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('21-Day Challenge'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            const Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'SpaceGrotesk',
                // fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'The 21-Day Challenge',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Courgette',
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'images/Pos2.jpg',
              height: 200,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectTopicsPage(
                      availableTopics: availableTopics,
                      selectedTopics: selectedTopics,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                // White background
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 25),
                side: const BorderSide(color: Color(0xFF014B3B)),
                // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
              child: const Text(
                'Select Topics',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'InriaSans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF014B3B), // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTopicsPage extends StatefulWidget {
  final List<String> availableTopics;
  List<String> selectedTopics;

  SelectTopicsPage({
    super.key,
    required this.availableTopics,
    required this.selectedTopics,
  });

  @override
  _SelectTopicsPageState createState() => _SelectTopicsPageState();
}

class _SelectTopicsPageState extends State<SelectTopicsPage> {
  // List of colors for checkboxes
  final List<Color> checkboxColors = [
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Topics'),
      ),
      body: ListView.builder(
        itemCount: widget.availableTopics.length,
        itemBuilder: (context, index) {
          final topic = widget.availableTopics[index];
          final colorIndex = index % checkboxColors.length;
          return CheckboxListTile(
            title: Text(
              topic,
              style: const TextStyle(fontSize: 18),
            ),
            activeColor: checkboxColors[colorIndex],
            checkColor: Colors.white,
            value: widget.selectedTopics.contains(topic),
            onChanged: (value) {
              setState(() {
                value!
                    ? widget.selectedTopics.add(topic)
                    : widget.selectedTopics.remove(topic);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.selectedTopics.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedTopicsPage(
                  selectedTopics: widget.selectedTopics,
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class SelectedTopicsPage extends StatelessWidget {
  final List<String> selectedTopics;

  const SelectedTopicsPage({super.key, required this.selectedTopics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Topics'),
      ),
      body: ListView.builder(
        itemCount: selectedTopics.length,
        itemBuilder: (context, index) {
          final topic = selectedTopics[index];
          return ListTile(
            title: Text(topic),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengePage(topic: topic),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChallengePage extends StatefulWidget {
  final String topic;

  const ChallengePage({super.key, required this.topic});

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late List<String> challenges;
  late List<bool> completedDays;

  @override
  void initState() {
    super.initState();
    completedDays =
        completedDaysState[widget.topic] ?? List.generate(21, (index) => false);
    challenges = generateChallenges(widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('21-Day Challenge for ${widget.topic}'),
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Day ${index + 1}: ${challenges[index]}'),
            trailing: completedDays[index]
                ? const Icon(Icons.check, color: Colors.green)
                : const Icon(Icons.close, color: Colors.red),
            onTap: () {
              if (index == 0 || completedDays[index - 1]) {
                _showConfirmationDialog(index);
              } else {
                _showAlertDialog();
              }
            },
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you completed the day?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  completedDays[index] = true;
                });
                completedDaysState[widget.topic] = completedDays;
                Navigator.of(context).pop();
              },
              child: const Text('Complete Challenge'),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('You must complete the previous day first'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  List<String> generateChallenges(String topic) {
    Map<String, List<String>> challengesData = {
      'Self Love': [
        ' Daily Affirmations: Start each day with positive affirmations about yourself.',
        'Journaling: Reflect on your thoughts and feelings daily.',
        'Gratitude Practice: Write down things youre grateful for each day.',
        'Self-Compassion Meditation: Practice guided meditation focusing on self-compassion.',
        'Forgive Yourself: Write a letter of self-forgiveness for past mistakes.',
        'Set Boundaries: Establish boundaries to protect your well-being.',
        'Healthy Eating: Nourish your body with nutritious foods.',
        'Physical Activity: Engage in daily exercise you enjoy.',
        'Hydration: Drink plenty of water throughout the day.',
        'Mindful Eating: Practice mindful eating without distractions.',
        'Digital Detox: Take breaks from technology and social media.',
        'Relaxation Techniques: Incorporate relaxation exercises into your routine.',
        'Pamper Yourself: Dedicate time each day for self-care activities.',
        'Creative Expression: Engage in creative hobbies that bring you joy.',
        'Practice Mindfulness: Stay present and cultivate awareness.',
        'Random Acts of Kindness: Perform acts of kindness for yourself and others.',
        'Learn Something New: Challenge yourself to learn daily.',
        'Visualization: Visualize your goals and aspirations.'
            'Reflect on Progress: Review your progress throughout the challenge.',
        'Express Gratitude: Thank those who supported you during the challenge.',
        'Commit to Self-Love: Make a commitment to continue practicing self-love daily.'
      ],
      'Read Book': [
        ' Explore a New Genre : Start reading a book in a genre you\'ve never tried before. Whether it\'s science fiction, historical fiction, romance, mystery, or fantasy, dive into something new and exciting.',
        'Set Reading Goals : Set specific reading goals for yourself. Decide how many pages or chapters you want to read each day and commit to sticking to your goal.',
        ' Create a Reading Nook : Designate a cozy reading nook in your home where you can escape into your book without distractions. Add some pillows, blankets, and a warm beverage for maximum comfort.',
        ' Join a Book Club : Join a local book club or an online reading community to discuss books with fellow book lovers. Sharing your thoughts and insights can enhance your reading experience.',
        ' Read Outdoors : Take your book outside and enjoy reading in nature. Whether it\'s in your backyard, a park, or by the beach, immerse yourself in your book surrounded by the beauty of the outdoors.',
        ' Read Before Bed : Make it a habit to read for at least 30 minutes before bedtime. Reading before bed can help you relax and unwind, leading to better sleep.',
        ' Visit a Library or Bookstore : Spend some time browsing the shelves of your local library or bookstore. Explore new releases, bestsellers, and hidden gems that catch your eye.',
        'Try Audiobooks :Experiment with audiobooks as an alternative way to enjoy stories. Listen to an audiobook while commuting, exercising, or doing household chores.',
        ' Read a Classic : Pick up a classic novel that you\'ve always wanted to read but haven\'t gotten around to yet. Classics offer timeless stories and themes that resonate across generations.',
        'Read Non-Fiction :Expand your horizons with a non-fiction book on a topic that interests you. Whether it\'s history, science, self-help, or memoir, learn something new and enrich your mind.',
        ' Set Aside Dedicated Reading Time : Block off time in your schedule specifically for reading. Whether it\'s during your lunch break, in the evening, or on weekends, prioritize your reading time like any other appointment.',
        ' Revisit a Favorite : Revisit a favorite book from your childhood or adolescence. Rediscover the magic and nostalgia of a beloved story that has stood the test of time.',
        ' Read a Short Story :  Dive into a collection of short stories by a single author or explore an anthology featuring multiple authors. Short stories offer a quick dose of literary enjoyment.',
        ' Read Poetry : Explore the beauty and depth of poetry by reading a collection of poems by your favorite poet or discovering new voices in the world of poetry.',
        ' Read Aloud : Share the joy of reading by reading aloud to a friend, family member, or pet. Reading aloud can enhance comprehension and foster a sense of connection with others.',
        ' Read a Book Recommended by Someone : Ask friends, family, or colleagues for book recommendations and choose one to read. Discovering new books through recommendations can lead to delightful surprises.',
        ' Read in a Different Format : Switch up your reading format by trying an e-book, graphic novel, or illustrated edition. Experimenting with different formats can add variety to your reading experience.',
        ' Read a Book Set in a Different Culture : Explore diverse perspectives by reading a book set in a different culture or country. Gain insight into different customs, traditions, and ways of life.',
        ' Read a Book Outside Your Comfort Zone : Challenge yourself to read a book outside your usual preferences or comfort zone. Step into unfamiliar territory and broaden your literary horizons.',
        ' Read for Pleasure : Allow yourself to simply enjoy the act of reading without any pressure or agenda. Choose a book that brings you joy and immerse yourself in its pages.',
        'Reflect on Your Reading Journey :Take some time to reflect on your reading journey over the past 21 days. What books did you enjoy the most? What insights did you gain? Use this reflection to inform your future reading habits and choices.',
      ],
      'Workout': [
        ' Cardio Blast :Start with a 20-minute brisk walk or jog.',
        ' Core Strength : Complete a 10-minute core workout focusing on exercises like planks, crunches, and leg raises.',
        ' Full Body Stretch: Dedicate 15 minutes to stretching all major muscle groups to improve flexibility and prevent injury.',
        ' Upper Body Sculpt :Perform a 15-minute upper body workout including push-ups, dumbbell rows, and shoulder presses.',
        ' Active Rest : Engage in light physical activity such as swimming, cycling, or yoga for 30 minutes to promote recovery.',
        ' Lower Body Burn : Complete a 20-minute lower body workout featuring squats, lunges, and calf raises.',
        'Pilates Fusion :Try a 20-minute Pilates session focusing on core strength, stability, and flexibility.',
        ' HIIT Challenge : Do a high-intensity interval training (HIIT) workout consisting of 30 seconds of intense exercise followed by 30 seconds of rest, repeated for 15 minutes.',
        'Yoga Flow: Practice a 20-minute yoga flow to improve balance, strength, and mental focus.',
        ' Circuit Training : Create a circuit of bodyweight exercises such as jumping jacks, burpees, mountain climbers, and plank variations, performing each exercise for 45 seconds with 15 seconds rest between exercises.',
        'Active Recovery : Go for a leisurely walk or bike ride for 30-45 minutes to promote circulation and reduce muscle soreness.',
        ' Total Body Sculpt : Incorporate resistance bands or dumbbells into a 20-minute full-body strength training routine.',
        'Dance Party : Have fun with a 30-minute dance workout, following along with your favorite dance tutorials or videos.',
        ' Flexibility Flow: Spend 20 minutes on a dynamic stretching routine to improve range of motion and mobility.',
        ' Cardio Kickboxing : Try a 30-minute cardio kickboxing workout to improve cardiovascular endurance and release stress.',
        ' Strength Challenge : Perform a series of bodyweight exercises, aiming for maximum repetitions in 15 minutes.',
        'Stability Training :Practice balance exercises like single-leg stands, stability ball exercises, or yoga poses for 20 minutes.',
        ' Core Intensity : Complete a 15-minute core workout focusing on challenging exercises such as Russian twists, bicycle crunches, and plank variations.',
        ' Tabata Training :Do a Tabata workout consisting of 8 rounds of 20 seconds of high-intensity exercise followed by 10 seconds of rest, alternating between two different exercises.',
        ' Endurance Run : Go for a 30-minute run or jog at a moderate pace to build cardiovascular endurance.',
        ' Mindful Movement :Wrap up the challenge with a 20-minute mindful movement session, combining gentle stretches, deep breathing, and relaxation techniques to promote overall well-being.',
      ],
      'Learning': [
        ' TED Talk Exploration : Watch a TED Talk on a topic that interests you and take notes on key points or insights.',
        ' Online Course Enrollment : Enroll in an online course or tutorial related to a skill or subject you want to learn more about.',
        ' Non-fiction Reading : Read a chapter or section of a non-fiction book on a topic that intrigues you.',
        ' Podcast Discovery : Listen to a podcast episode on a subject you\'re curious about and jot down any interesting ideas.',
        'Educational Video Watching : Find an educational video on YouTube or another platform and spend at least 30 minutes learning from it.',
        ' Documentary Viewing : Watch a documentary film that delves into a topic you\'ve always wanted to explore further.',
        ' Language Learning : Dedicate time to learning a new language through apps, online resources, or language exchange sessions.',
        ' Khan Academy Session : Complete a lesson or tutorial on Khan Academy covering a subject you want to improve in.',
        ' Research Project : Pick a topic of interest and spend time researching it online or at your local library.',
        ' Skill Practice : Spend at least 30 minutes practicing a skill you want to develop, whether it\'s playing an instrument, coding, or cooking.',
        ' Academic Journal Article : Read an academic journal article in a field you\'re interested in and summarize the key findings.',
        'Educational Podcast Listen to an educational podcast episode and take notes on any new information or insights.',
        'DIY Project : Take on a DIY project that requires learning new skills or techniques, whether it\'s woodworking, gardening, or crafting.',
        ' Book Club Discussion : Join or initiate a book club discussion on a book related to personal or professional development.',
        ' Webinar Attendance : Attend a webinar or online workshop on a topic that aligns with your learning goals.',
        'Educational App Exploration : Explore educational apps in areas like language learning, math, or science, and try out one that interests you.',
        ' Historical Document Reading : Read a historical document or primary source related to a period or event you\'re curious about.',
        ' Virtual Museum Tour : Take a virtual tour of a museum or art gallery online and learn about the exhibits and collections.',
        ' Educational Games : Play educational games or quizzes that challenge your knowledge and critical thinking skills.',
        'Masterclass Session :Watch a session from a Masterclass series on a subject taught by an expert in the field.',
        ' Reflect and Review : Reflect on what you\'ve learned over the past 20 days and identify areas for further exploration or improvement.',
      ],
      'Routine': [
        ' Morning Meditation: Start each day with a 10-minute meditation session to clear your mind and set a positive tone for the day.',
        'Daily Planning: Spend 15 minutes each morning planning out your day, setting goals, and prioritizing tasks to increase productivity.',
        ' Healthy Breakfast: Prepare and enjoy a nutritious breakfast every morning to fuel your body and mind for the day ahead.',
        ' Regular Exercise: Dedicate at least 30 minutes to exercise every day, whether it\'s a workout at the gym, a run outdoors, or yoga at home.',
        ' Midday Stretch: Take a 5-minute break every afternoon to stretch and release tension from your muscles, promoting relaxation and flexibility.',
        ' Mindful Eating: Practice mindful eating during meal times, focusing on savoring each bite and paying attention to hunger and fullness cues.',
        ' Evening Reflection: Spend 10 minutes each evening reflecting on your day, expressing gratitude for positive moments, and identifying areas for growth.',
        ' Digital Detox: Allocate 30 minutes each day to disconnect from electronic devices and engage in screen-free activities like reading or spending time outdoors.',
        ' Hydration Habit: Drink at least 8 glasses of water throughout the day to stay hydrated and support overall health and well-being.',
        ' Bedtime Routine: Establish a calming bedtime routine, such as reading a book or practicing relaxation techniques, to promote restful sleep.',
        ' Daily Affirmations: Start each day with positive affirmations to boost self-confidence and cultivate a positive mindset.',
        ' Creative Expression: Dedicate time each day to engage in a creative activity that brings you joy, whether it\'s painting, writing, or playing music.',
        ' Social Connection: Connect with a friend or loved one each day, whether it\'s through a phone call, video chat, or in-person visit.',
        ' Gratitude Practice: Write down three things you\'re grateful for each day to foster a sense of appreciation and contentment.',
        ' Time Management: Use a timer or productivity tool to allocate specific blocks of time for tasks and avoid procrastination.',
        ' Self-Care Ritual: Treat yourself to a self-care ritual each day, whether it\'s a bubble bath, face mask, or meditation session.',
        ' Outdoor Time: Spend at least 20 minutes outdoors each day, enjoying nature and soaking up the benefits of fresh air and sunshine.',
        ' Learning Moment: Learn something new each day, whether it\'s a new skill, fact, or perspective, to stimulate your mind and expand your knowledge.',
        ' Acts of Kindness: Perform a random act of kindness each day, whether it\'s complimenting a stranger, helping a neighbor, or donating to charity.',
        ' Reflection Journal: Keep a daily journal to reflect on your thoughts, feelings, and experiences, allowing for self-discovery and personal growth.',
        ' Celebration: Celebrate your accomplishments and progress at the end of each day, acknowledging your efforts and successes.',
      ],
      'Health': [
        'Drink at least 8 glasses of water throughout the day to stay hydrated and support overall health and well-being.',
        'Cook a healthy meal from scratch using whole, unprocessed ingredients.',
        'Practice portion control by using smaller plates or measuring out servings.',
        'Try a new fruit or vegetable that you\'ve never had before.',
        'Go for a walk outside and soak up some vitamin D from the sun.',
        'Get at least 7-9 hours of sleep to recharge your body and mind.',
        'Treat yourself to a healthy snack or dessert, like Greek yogurt with berries or a piece of dark chocolate.',
        'Cook a new healthy recipe and share it with a friend or family member.',
        'Incorporate more leafy greens into your meals, like spinach, kale, or Swiss chard.',
        'Practice mindful eating by savoring each bite and paying attention to hunger and fullness cues.',
        'Go for a bike ride or swim for 30 minutes to get your heart pumping and improve cardiovascular health.',
        'Prepare a meal plan for the week ahead and include a variety of nutritious foods.',
        'Join a fitness class or group activity that you enjoy, such as yoga, dance, or Pilates.',
        'Try a new form of exercise, like rock climbing, kickboxing, or paddleboarding.',
        'Limit your intake of sugary drinks and opt for water, herbal tea, or infused water instead.',
        'Take a relaxing bath with Epsom salts to soothe sore muscles and promote relaxation.',
        'Practice deep breathing exercises for 5 minutes to reduce stress and calm the mind.',
        'Experiment with different cooking methods, like grilling, roasting, or steaming, to add variety to your meals.',
        'Take a break from screens and spend time outdoors, enjoying nature and fresh air.',
        'Attend a group fitness class or workout with a friend to stay motivated and accountable.',
        'Practice gratitude by reflecting on three things you\'re thankful for each day, promoting a positive mindset.',
      ],
      'Mental Health': [
        'Practice deep breathing exercises for 5 minutes to reduce stress and calm the mind.',
        'Write down three things you\'re grateful for to cultivate a positive mindset.',
        'Spend 15 minutes decluttering your mind by journaling or free writing.',
        'Practice mindfulness by focusing on your senses during everyday activities.',
        'Take a break from screens and spend some time in nature to clear your mind.',
        'Connect with a friend or family member and have a meaningful conversation.',
        'Practice self-compassion by treating yourself with kindness and understanding.',
        'Listen to calming music or nature sounds to relax and unwind.',
        'Set boundaries with technology by turning off notifications or limiting screen time.',
        'Engage in a creative activity, such as painting, drawing, or crafting.',
        'Take a mental health day to rest and recharge.',
        'Challenge negative thoughts by reframing them in a more positive light.',
        'Practice forgiveness by letting go of resentment and embracing compassion.',
        'Engage in physical activity, such as yoga or walking, to boost mood and reduce anxiety.',
        'Create a gratitude jar and add a note each day with something positive that happened.',
        'Limit exposure to negative news or social media to protect your mental well-being.',
        'Practice progressive muscle relaxation to release tension and promote relaxation.',
        'Try a guided meditation or visualization exercise to calm the mind and promote inner peace.',
        'Engage in a hobby or activity that brings you joy and fulfillment.',
        'Set realistic goals for yourself and celebrate your achievements along the way.',
        'Seek support from a therapist or counselor if you\'re struggling with your mental health.',
      ],
      'Lifestyle': [
        'Try a new hobby or activity that you\'ve always wanted to explore.',
        'Create a vision board or Pinterest board with images that represent your goals and aspirations.',
        'Set boundaries with technology by turning off notifications or limiting screen time.',
        'Practice gratitude by writing down three things you appreciate about your life.',
        'Volunteer your time or resources to help someone in need.',
        'Spend quality time with loved ones and nurture your relationships.',
        'Evaluate your habits and routines and make adjustments to create a more balanced lifestyle.',
        'Set aside time each day for self-care activities like taking a bath or practicing mindfulness.',
        'Experiment with different cooking techniques or cuisines to add variety to your meals.',
        'Declutter one area of your home or workspace to create a more peaceful environment.',
        'Create a budget and track your expenses to improve financial management.',
        'Explore your local community and discover new parks, shops, or restaurants.',
        'Set personal or professional goals for yourself and create an action plan to achieve them.',
        'Unplug from technology for a day and spend time outdoors connecting with nature.',
        'Practice saying "no" to activities or commitments that don\'t align with your values or priorities.',
        'Learn a new skill or take a class to expand your knowledge and abilities.',
        'Embrace minimalism by decluttering your belongings and simplifying your life.',
        'Start a gratitude journal and write down three things you\'re thankful for each day.',
        'Practice mindfulness by focusing on the present moment and cultivating awareness.',
        'Create a morning or evening routine that helps you feel calm, centered, and prepared for the day ahead.',
        'Take a solo trip or adventure to explore new places and gain perspective.',
        'Reflect on your accomplishments and successes, and celebrate your growth and progress.',
      ],
      'Productivity': [
        'Identify your most important task for the day and tackle it first thing in the morning.',
        'Break larger tasks into smaller, more manageable steps to make them less overwhelming.',
        'Use a timer to work in focused intervals of 25 minutes, followed by a 5-minute break.',
        'Minimize distractions by turning off notifications and setting specific work hours.',
        'Delegate tasks that you can outsource or ask for help from others.',
        'Reflect on your accomplishments from the day and celebrate your progress.',
        'Plan out your week ahead and set specific goals and deadlines for each day.',
        'Create a to-do list and prioritize tasks based on importance and urgency.',
        'Schedule regular breaks throughout the day to rest and recharge.',
        'Set boundaries with your time and learn to say "no" to non-essential tasks or commitments.',
        'Review your goals and progress regularly to stay motivated and on track.',
        'Batch similar tasks together to improve efficiency and focus.',
        'Use productivity tools and apps to streamline your workflow and stay organized.',
        'Practice the two-minute rule: if a task takes less than two minutes, do it immediately.',
        'Limit multitasking and focus on one task at a time to improve concentration and effectiveness.',
        'Create a designated workspace that is free from distractions and conducive to productivity.',
        'Set aside time each day for personal development and skill-building activities.',
        'Automate repetitive tasks or create systems to streamline your workflow.',
        'Eliminate unnecessary meetings or commitments that don\'t contribute to your goals.',
        'Practice gratitude and positive affirmations to maintain a positive mindset and boost productivity.',
        'Get enough sleep and prioritize self-care to ensure optimal productivity and well-being.',
        'Reflect on your productivity habits and make adjustments to improve efficiency and effectiveness.',
      ],
      'Positivity': [
        'Start each day with positive affirmations about yourself.',
        'Practice gratitude by writing down three things you\'re thankful for each day.',
        'Surround yourself with uplifting music, quotes, or images that inspire you.',
        'Compliment someone else and spread positivity to those around you.',
        'Focus on the present moment and find joy in the little things throughout your day.',
        'Engage in activities that bring you pleasure and make you feel good about yourself.',
        'Reflect on your achievements and successes, no matter how small, and acknowledge your growth and progress.',
        'Practice random acts of kindness for yourself and others.',
        'Challenge negative thoughts by reframing them in a more positive light.',
        'Visualize your goals and aspirations, imagining yourself achieving success.',
        'Connect with nature by spending time outdoors and appreciating the beauty around you.',
        'Surround yourself with supportive and positive people who lift you up.',
        'Forgive yourself for past mistakes and focus on the present moment.',
        'Take time for self-care activities that nourish your mind, body, and soul.',
        'Stay optimistic and maintain a hopeful outlook, even in challenging times.',
        'Set realistic goals and celebrate your progress along the way.',
        'Practice mindfulness by staying present and cultivating awareness.',
        'Engage in hobbies or activities that bring you joy and fulfillment.',
        'Share your gratitude with others by expressing appreciation for their kindness and support.',
        'Keep a positivity journal to record moments of joy, gratitude, and inspiration.',
        'Surround yourself with positive affirmations and reminders of your worth and value.',
        'End each day by reflecting on the positive moments and experiences you had.',
      ],
      'Personal Growth': [
        'Set a specific, measurable goal for yourself and create an action plan to achieve it.',
        'Step out of your comfort zone and try something new or take a risk.',
        'Reflect on your strengths and weaknesses, and identify areas for improvement.',
        'Seek feedback from others and use it as an opportunity for growth and development.',
        'Take responsibility for your actions and learn from your mistakes and failures.',
        'Practice self-awareness by observing your thoughts, feelings, and behaviors without judgment.',
        'Celebrate your progress and achievements, no matter how small, and acknowledge your growth and progress.',
        'Commit to a daily practice of self-care activities that nurture your mind, body, and soul.',
        'Cultivate a growth mindset by embracing challenges and viewing setbacks as opportunities for learning and growth.',
        'Invest in yourself by dedicating time and resources to personal development and education.',
        'Engage in activities that inspire creativity and innovation, such as writing, painting, or brainstorming.',
        'Set boundaries with negative influences and prioritize relationships that support your personal growth.',
        'Challenge limiting beliefs and replace them with empowering beliefs that align with your goals and values.',
        'Practice mindfulness and presence by staying grounded in the present moment and embracing life as it unfolds.',
        'Read books, listen to podcasts, or attend workshops that expand your knowledge and perspective.',
        'Surround yourself with people who uplift and inspire you, and learn from their wisdom and experiences.',
        'Take initiative and pursue opportunities for growth and advancement in your personal and professional life.',
        'Reflect on your values and priorities, and align your actions with what matters most to you.',
        'Practice gratitude and appreciation for the blessings and opportunities in your life.',
        'Stay curious and open-minded, and embrace a lifelong journey of learning and growth.',
        'Commit to ongoing self-improvement and strive to become the best version of yourself every day.',
        'Embrace change and uncertainty as opportunities for growth and transformation.',
      ],
    };

    return challengesData[topic] ?? [];
  }
}

Map<String, List<bool>> completedDaysState = {};
