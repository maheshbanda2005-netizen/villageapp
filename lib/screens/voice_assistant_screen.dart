import 'package:flutter/material.dart';
import '../theme/mana_gramam_theme.dart';
import '../widgets/fade_slide_in.dart';

/// Screen 17: VOICE ASSISTANT ("Ask Mana Gramam" / "గ్రామ మిత్ర")
/// Premium AI voice assistant with Deep Navy background, animated pulsing microphone ring,
/// and rural query prompts in English, Telugu, and Hindi.
class VoiceAssistantScreen extends StatefulWidget {
  final bool isTelugu;
  const VoiceAssistantScreen({super.key, this.isTelugu = false});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  bool _isListening = false;
  String _activeLanguage = 'English';
  String _lastUserQuery = '';
  String _assistantAnswer = '';

  final List<Map<String, String>> _quickPrompts = [
    {
      'en': 'Where is the nearest hospital?',
      'te': 'సమీపంలోని ఆసుపత్రి ఎక్కడ ఉంది?',
      'ansEn': 'Kothapally Primary Health Center is 450 meters away on Main Road. Dr. S. Rao is currently available.',
      'ansTe': 'కోతపల్లి ప్రాథమిక ఆరోగ్య కేంద్రం 450 మీటర్ల దూరంలో ఉంది. డాక్టర్ రావు గారు అందుబాటులో ఉన్నారు.',
    },
    {
      'en': 'What government schemes are available?',
      'te': 'రైతులకు ఏ పథకాలు ఉన్నాయి?',
      'ansEn': 'Currently 3 schemes are active for Kothapally: Rythu Bandhu (12th Phase), PM Kisan (₹6,000/yr), and Crop Insurance.',
      'ansTe': 'ప్రస్తుతం 3 పథకాలు అందుబాటులో ఉన్నాయి: రైతు బంధు, పీఎం కిసాన్ మరియు ఉచిత పంటల బీమా.',
    },
    {
      'en': 'Find a tractor for rent.',
      'te': 'ట్రాక్టర్ అద్దెకు ఎక్కడ దొరుకుతుంది?',
      'ansEn': 'Two Mahindra 575 tractors are available for hire near Market Yard. Rate is ₹800 per hour with driver.',
      'ansTe': 'మార్కెట్ యార్డ్ వద్ద 2 మహీంద్రా ట్రాక్టర్లు అద్దెకు ఉన్నాయి. గంటకు ₹800 చొప్పున డ్రైవర్‌తో లభిస్తుంది.',
    },
    {
      'en': 'Report a streetlight problem.',
      'te': 'వీధి దీపం సమస్యను నివేదించండి.',
      'ansEn': 'Complaint registered for Ward 3 streetlight. Panchayat Lineman Ramesh has been assigned. Resolution target: 24 hrs.',
      'ansTe': 'వార్డు 3 వీధి దీపం ఫిర్యాదు నమోదు చేయబడింది. పంచాయతీ లైన్‌మెన్ రమేష్ గారికి కేటాయించబడింది.',
    },
    {
      'en': 'What jobs are available today?',
      'te': 'ఈరోజు అందుబాటులో ఉన్న పనులు ఏమిటి?',
      'ansEn': '5 jobs found: 2 Farm Harvester workers at Reddy Farms (₹800/day), 1 Electrician needed at Panchayat office.',
      'ansTe': '5 పనులు ఉన్నాయి: రెడ్డి గార్డెన్స్‌లో వ్యవసాయ కూలీలు (రోజుకు ₹800), పంచాయతీలో ఎలక్ట్రీషియన్ కావలెను.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _activeLanguage = widget.isTelugu ? 'తెలుగు' : 'English';
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _triggerPrompt(Map<String, String> prompt) {
    final isTe = _activeLanguage == 'తెలుగు';
    final query = isTe ? prompt['te']! : prompt['en']!;
    final answer = isTe ? prompt['ansTe']! : prompt['ansEn']!;

    setState(() {
      _lastUserQuery = query;
      _assistantAnswer = '';
      _isListening = true;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _isListening = false;
        _assistantAnswer = answer;
      });
    });
  }

  void _toggleMic() {
    setState(() => _isListening = !_isListening);
    if (_isListening) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (!mounted) return;
        final isTe = _activeLanguage == 'తెలుగు';
        setState(() {
          _isListening = false;
          _lastUserQuery = isTe
              ? 'కోతపల్లిలో రేపు నీటి సరఫరా సమయాలు ఏమిటి?'
              : 'What are tomorrow\'s water supply timings?';
          _assistantAnswer = isTe
              ? 'రేపు ఉదయం 9 నుండి మధ్యాహ్నం 2 గంటల వరకు పైప్‌లైన్ మరమ్మతుల వల్ల నీరు సరఫరా ఉండదు. దయచేసి ముందే నీటిని నిల్వ చేసుకోండి.'
              : 'Water supply will be suspended tomorrow from 9:00 AM to 2:00 PM due to pipeline repairs. Please store water in advance.';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTe = _activeLanguage == 'తెలుగు';

    return Scaffold(
      backgroundColor: ManaColors.navy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: ManaText(
          isTe ? 'గ్రామ మిత్ర వాయిస్' : 'Ask Mana Gramam',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language_rounded, color: Colors.white),
            color: ManaColors.navySoft,
            initialValue: _activeLanguage,
            onSelected: (val) => setState(() => _activeLanguage = val),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'English',
                child: Text('English', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'తెలుగు',
                child: Text('తెలుగు (Telugu)', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'हिन्दी',
                child: Text('हिन्दी (Hindi)', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Header AI Avatar
            FadeSlideIn(
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: ManaColors.purple.withValues(alpha: 0.35),
                      shape: BoxShape.circle,
                      border: Border.all(color: ManaColors.purple, width: 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.auto_awesome_rounded, color: ManaColors.orange, size: 36),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ManaText(
                    isTe ? 'నమస్కారం! నేను మీ గ్రామ మిత్ర' : 'Ask Mana Gramam',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ManaText(
                    isTe ? 'ఏమి సహాయం కావాలి? మాట్లాడండి' : 'How can I help you today?',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Conversational Bubble / Transcription Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    if (_lastUserQuery.isNotEmpty)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: ManaColors.purple,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ManaText(
                            _lastUserQuery,
                            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    if (_isListening)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: ManaColors.navySoft,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ManaColors.purple.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(strokeWidth: 2, color: ManaColors.orange),
                              ),
                              const SizedBox(width: 10),
                              ManaText(
                                isTe ? 'వింటున్నాను…' : 'Listening…',
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_assistantAnswer.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ManaColors.navySoft,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: ManaColors.purple, width: 1.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.volume_up_rounded, color: ManaColors.orange, size: 18),
                                  const SizedBox(width: 8),
                                  ManaText(
                                    isTe ? 'సమాధానం' : 'Mana Gramam Response',
                                    style: const TextStyle(
                                      color: ManaColors.orange,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ManaText(
                                _assistantAnswer,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Quick Example Voice Prompts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ManaText(
                  isTe ? 'తరచుగా అడిగే ప్రశ్నలు:' : 'Try asking:',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _quickPrompts.length,
                itemBuilder: (context, i) {
                  final p = _quickPrompts[i];
                  final label = isTe ? p['te']! : p['en']!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      onPressed: () => _triggerPrompt(p),
                      backgroundColor: ManaColors.navySoft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: ManaColors.purple.withValues(alpha: 0.6)),
                      ),
                      label: Text(
                        label,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Large Microphone Action with animated concentric pulse ring
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isListening)
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 88 * _pulseAnimation.value,
                          height: 88 * _pulseAnimation.value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ManaColors.purple.withValues(alpha: 0.35),
                          ),
                        );
                      },
                    ),
                  GestureDetector(
                    onTap: _toggleMic,
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: _isListening ? ManaColors.orange : ManaColors.purple,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isListening ? ManaColors.orange : ManaColors.purple).withValues(alpha: 0.5),
                            blurRadius: 18,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isListening ? Icons.graphic_eq_rounded : Icons.mic_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            ManaText(
              _isListening
                  ? (isTe ? 'మాట్లాడండి, వింటున్నాను…' : 'Listening… speak now')
                  : (isTe ? 'మైక్ నొక్కి మాట్లాడండి' : 'Tap to speak'),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
