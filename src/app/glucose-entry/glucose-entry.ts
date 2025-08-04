import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { DietList } from '../diet-list/diet-list';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-glucose-entry',
  imports: [CommonModule, ReactiveFormsModule, DietList],
  templateUrl: './glucose-entry.html',
  styleUrl: './glucose-entry.css'
})
export class GlucoseEntry {
   glucoseForm: FormGroup;
  glucoseValue: number | null = null;
  showDietList = false;

  constructor(private fb: FormBuilder) {
    this.glucoseForm = this.fb.group({
      glucose: ['', [Validators.required, Validators.min(0)]]
    });
  }

  onSubmit() {
    if (this.glucoseForm.valid) {
      this.glucoseValue = this.glucoseForm.value.glucose;
      this.showDietList = true;
    }
  }

}
