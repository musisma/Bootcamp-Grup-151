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
    if (this.glucose < 100) return ['Normal şeker seviyeniz var.'];
    if (this.glucose < 140) return ['Orta seviyede şeker dikkaet et'];
    return ['Yüksek şeker seviyesiii.'];
  }

}
