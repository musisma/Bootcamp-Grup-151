import 'package:flutter/material.dart';

class SugarCalculatorScreen extends StatefulWidget {
  const SugarCalculatorScreen({super.key});

  @override
  State<SugarCalculatorScreen> createState() => _SugarCalculatorScreenState();
}

class _SugarCalculatorScreenState extends State<SugarCalculatorScreen> {
  final _sugarController = TextEditingController();
  String? _analysisResult;
  String? _sugarLevel;
  List<SugarRecommendation> _recommendations = [];

  @override
  void dispose() {
    _sugarController.dispose();
    super.dispose();
  }

  void _calculateSugar() {
    if (_sugarController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen kan şekeri değerinizi giriniz'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double? sugarValue = double.tryParse(_sugarController.text);
    if (sugarValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Geçerli bir sayı giriniz'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _analysisResult = '${sugarValue.toStringAsFixed(0)} mg/dL';
      _sugarLevel = _getSugarLevel(sugarValue);
      _recommendations = _getRecommendations(sugarValue);
    });
  }

  String _getSugarLevel(double value) {
    if (value < 70) {
      return 'düşük';
    } else if (value >= 70 && value <= 140) {
      return 'normal';
    } else {
      return 'yüksek';
    }
  }

  List<SugarRecommendation> _getRecommendations(double value) {
    if (value < 70) {
      // Düşük şeker
      return [
        SugarRecommendation(
          text: 'Hemen meyve suyu için.',
          type: RecommendationType.urgent,
        ),
        SugarRecommendation(
          text: 'Bal veya şeker alın.',
          type: RecommendationType.urgent,
        ),
        SugarRecommendation(
          text: 'Doktorunuza danışın.',
          type: RecommendationType.warning,
        ),
      ];
    } else if (value >= 70 && value <= 140) {
      // Normal şeker
      return [
        SugarRecommendation(
          text: 'Taze elma yiyebilirsiniz.',
          type: RecommendationType.good,
        ),
        SugarRecommendation(
          text: 'Brokoli ile protein ekleyin.',
          type: RecommendationType.good,
        ),
        SugarRecommendation(
          text: 'Avokado ile sağlıklı yağ alın.',
          type: RecommendationType.good,
        ),
      ];
    } else {
      // Yüksek şeker
      return [
        SugarRecommendation(
          text: 'Su içmeyi artırın.',
          type: RecommendationType.warning,
        ),
        SugarRecommendation(
          text: 'Şekerli besinlerden kaçının.',
          type: RecommendationType.urgent,
        ),
        SugarRecommendation(
          text: 'Doktorunuzla görüşün.',
          type: RecommendationType.urgent,
        ),
      ];
    }
  }

  String _getCurrentDateTime() {
    final now = DateTime.now();
    final months = [
      '', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} '
           '${now.day.toString().padLeft(2, '0')} ${months[now.month]} ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Icon(Icons.favorite, color: Colors.green[400], size: 24),
            const SizedBox(width: 8),
            Text(
              'DiaScan',
              style: TextStyle(
                color: Colors.green[400],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // Ana başlık
            const Text(
              'Kan Şekeri Bilginizi Girin,\nBilimsel Önerilerle Destek\nAlın',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 40),
            
            // Şeker değeri giriş alanı
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: TextFormField(
                controller: _sugarController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '56',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[400]!),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Hesapla butonu
            SizedBox(
              width: 300,
              height: 52,
              child: ElevatedButton(
                onPressed: _calculateSugar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Hesapla',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Sonuçlar bölümü
            if (_analysisResult != null) ...[
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Öneriler
                    ..._recommendations.map((recommendation) => 
                      _buildRecommendationItem(recommendation)
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Analiz sonucu
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Analiz: $_analysisResult, $_sugarLevel (${_getCurrentDateTime()})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(SugarRecommendation recommendation) {
    Color dotColor;
    switch (recommendation.type) {
      case RecommendationType.good:
        dotColor = Colors.green;
        break;
      case RecommendationType.warning:
        dotColor = Colors.orange;
        break;
      case RecommendationType.urgent:
        dotColor = Colors.red;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommendation.text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SugarRecommendation {
  final String text;
  final RecommendationType type;

  SugarRecommendation({
    required this.text,
    required this.type,
  });
}

enum RecommendationType {
  good,
  warning,
  urgent,
}