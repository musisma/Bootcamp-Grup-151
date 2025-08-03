import 'package:flutter/material.dart';

class DiabetesRiskCalculatorScreen extends StatefulWidget {
  const DiabetesRiskCalculatorScreen({super.key});

  @override
  State<DiabetesRiskCalculatorScreen> createState() => _DiabetesRiskCalculatorScreenState();
}

class _DiabetesRiskCalculatorScreenState extends State<DiabetesRiskCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _glucoseController = TextEditingController();
  final _bloodPressureController = TextEditingController();
  final _weightController = TextEditingController();
  final _insulinController = TextEditingController();
  final _bmiController = TextEditingController();
  final _diabetesFunctionController = TextEditingController();
  final _ageController = TextEditingController();

  String? _pregnancyStatus;
  String? _diabetesStatus;
  String? _riskResult;
  double? _riskPercentage;

  final List<String> _pregnancyOptions = [
    'Evet',
    'Hayır',
    'Bilmiyorum'
  ];

  final List<String> _diabetesOptions = [
    'Evet',
    'Hayır',
    'Emin değilim'
  ];

  @override
  void dispose() {
    _glucoseController.dispose();
    _bloodPressureController.dispose();
    _weightController.dispose();
    _insulinController.dispose();
    _bmiController.dispose();
    _diabetesFunctionController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateRisk() {
    if (_formKey.currentState!.validate()) {
      // Basit risk hesaplama algoritması
      double risk = 0.0;
      
      // Glikoz değeri kontrolü
      double? glucose = double.tryParse(_glucoseController.text);
      if (glucose != null) {
        if (glucose > 126) risk += 30;
        else if (glucose > 100) risk += 15;
      }

      // Yaş kontrolü
      double? age = double.tryParse(_ageController.text);
      if (age != null) {
        if (age > 60) risk += 25;
        else if (age > 45) risk += 15;
        else if (age > 35) risk += 10;
      }

      // BMI kontrolü
      double? bmi = double.tryParse(_bmiController.text);
      if (bmi != null) {
        if (bmi > 30) risk += 20;
        else if (bmi > 25) risk += 10;
      }

      // Tansiyon kontrolü
      double? bp = double.tryParse(_bloodPressureController.text);
      if (bp != null) {
        if (bp > 140) risk += 15;
        else if (bp > 130) risk += 10;
      }

      // İnsülin kontrolü
      double? insulin = double.tryParse(_insulinController.text);
      if (insulin != null) {
        if (insulin > 25) risk += 10;
      }

      // Diyabet soyağacı
      if (_diabetesStatus == 'Evet') {
        risk += 20;
      }

      // Hamilelik
      if (_pregnancyStatus == 'Evet') {
        risk += 10;
      }

      // Risk yüzdesini sınırla
      risk = risk.clamp(0.0, 100.0);

      setState(() {
        _riskPercentage = risk;
        if (risk < 30) {
          _riskResult = 'düşük';
        } else if (risk < 60) {
          _riskResult = 'orta';
        } else {
          _riskResult = 'yüksek';
        }
      });
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

  List<String> _getRecommendations() {
    if (_riskResult == 'düşük') {
      return [
        'Mükemmel! Sağlıklı yaşam tarzınızı sürdürün.',
        'Düzenli egzersiz yapmaya devam edin.',
        'Dengeli beslenme programınızı koruyun.',
        'Yılda bir kez kontrol yaptırın.',
      ];
    } else if (_riskResult == 'orta') {
      return [
        'Dikkat! Diyabet riski artıyor.',
        'Kilo vermeyi hedefleyin.',
        'Haftada 3-4 kez egzersiz yapın.',
        '6 ayda bir kontrol yaptırın.',
        'Şekerli besinleri azaltın.',
      ];
    } else {
      return [
        'Acil önlem alın! Yüksek risk.',
        'Hemen doktora başvurun.',
        'Sıkı diyet programı başlatın.',
        'Günlük egzersiz yapın.',
        'Aylık kontroller yaptırın.',
        'Aile hikayenizi doktorunuzla paylaşın.',
      ];
    }
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  // Ana başlık
                  const Text(
                    'Diyabet Riskinizi\nHesaplayın, Bilimsel\nÖnerilerle Destek Alın',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Hamilelik durumu
                  DropdownButtonFormField<String>(
                    value: _pregnancyStatus,
                    decoration: const InputDecoration(
                      labelText: 'Hamilelik var mı?',
                      border: UnderlineInputBorder(),
                    ),
                    items: _pregnancyOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _pregnancyStatus = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alan zorunludur';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Glikoz değeri
                  TextFormField(
                    controller: _glucoseController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Glikoz değeri (mg/dL)',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Glikoz değeri zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Tansiyon
                  TextFormField(
                    controller: _bloodPressureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Tansiyon (mm Hg)',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tansiyon değeri zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Ağırlık
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ağırlık (kg)',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ağırlık zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // İnsülin
                  TextFormField(
                    controller: _insulinController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'İnsülin (mu U/ml)',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'İnsülin değeri zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Vücut Kitle Endeksi
                  TextFormField(
                    controller: _bmiController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Vücut Kitle Endeksi',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'BMI değeri zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Diyabet soyağacı fonksiyonu
                  TextFormField(
                    controller: _diabetesFunctionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Diyabet soyağacı fonksiyonu',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alan zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Yaş
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Yaş',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Yaş zorunludur';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir sayı giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Diyabet durumu
                  DropdownButtonFormField<String>(
                    value: _diabetesStatus,
                    decoration: const InputDecoration(
                      labelText: 'Diyabet var mı?',
                      border: UnderlineInputBorder(),
                    ),
                    items: _diabetesOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _diabetesStatus = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alan zorunludur';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  
                  // Hesapla butonu
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _calculateRisk,
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
                  if (_riskResult != null) ...[
                    Container(
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
                          // Risk sonucu
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Diyabet Risk Oranınız',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '%${_riskPercentage!.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: _riskResult == 'düşük' 
                                        ? Colors.green 
                                        : _riskResult == 'orta' 
                                            ? Colors.orange 
                                            : Colors.red,
                                  ),
                                ),
                                Text(
                                  'Risk seviyesi: $_riskResult',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _riskResult == 'düşük' 
                                        ? Colors.green 
                                        : _riskResult == 'orta' 
                                            ? Colors.orange 
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Öneriler
                          const Text(
                            'Öneriler:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._getRecommendations().map((recommendation) => 
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(top: 6, right: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      recommendation,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
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
                            child: Text(
                              'Analiz: %${_riskPercentage!.toStringAsFixed(0)} risk, $_riskResult seviye (${_getCurrentDateTime()})',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
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
          ),
        ),
      ),
    );
  }
}