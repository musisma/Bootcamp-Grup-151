import { Component,Input  } from '@angular/core';
import { CommonModule } from '@angular/common';
@Component({
  selector: 'app-diet-list',
  imports: [CommonModule],
  templateUrl: './diet-list.html',
  styleUrl: './diet-list.css'
})
export class DietList {
   @Input() glucose: number | null = null;

  get recommendations(): string[] {
    if (this.glucose === null) return [];
    if (this.glucose < 100) return [ 
    'Normal şeker seviyeniz var.',
    'Öneriler:',
    '- Yulaf ezmesi',
    '- Yoğurt + taze meyve',
    '- Tam tahıllı ekmek + lor peyniri'];
    if (this.glucose < 140) return [ 
    'Orta seviyede şekeriniz var, dikkat edin.',
    'Öneriler:',
    '- Muz',
    '- Bal ile tam buğday ekmeği',
    '- Taze portakal suyu'];
    return [  
    'Yüksek şeker seviyeniz var!',
    'Öneriler:',
    '- Brokoli',
    '- Avokado',
    '- Ceviz veya badem'];
  }

}