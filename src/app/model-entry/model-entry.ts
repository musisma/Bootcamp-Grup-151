import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';

@Component({
  selector: 'app-model-entry',
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './model-entry.html',
  styleUrl: './model-entry.css'
})
export class ModelEntry { diabetesForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.diabetesForm = this.fb.group({
      nPregnant: [null, [Validators.required, Validators.min(0), Validators.pattern("^[0-9]*$")]],
      glucose: [null, [Validators.required, Validators.min(0), Validators.pattern("^[0-9]*$")]],
      tension: [null, [Validators.required, Validators.min(0), Validators.pattern("^[0-9]*$")]],
      thickness: [null, [Validators.required, Validators.min(0), Validators.pattern("^[0-9]*$")]],
      insulin: [null, [Validators.required, Validators.min(0), Validators.pattern("^[0-9]*$")]],
      bmi: [null, [Validators.required, Validators.min(0)]],        // float, no pattern to limit decimals
      pedigree: [null, [Validators.required, Validators.min(0)]],   // float
      age: [null, [Validators.required, Validators.min(0), Validators.pattern("^[0-9]*$")]]
    });
  }

  onSubmit() {
    if (this.diabetesForm.valid) {
      console.log('Form data:', this.diabetesForm.value);
      alert('Form başarıyla gönderildi!');
      // Burada API çağrısı veya hesaplama yapılabilir
    } else {
      alert('Lütfen formu doğru ve eksiksiz doldurun.');
      this.diabetesForm.markAllAsTouched();
    }
  }

}
