import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators,ReactiveFormsModule  } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signup',
  imports: [CommonModule,ReactiveFormsModule],
  templateUrl: './signup.html',
  styleUrl: './signup.css'
})
export class Signup {
    signupForm: FormGroup;
    constructor(private fb: FormBuilder,private router: Router) {
    this.signupForm = this.fb.group({
      name: ['', Validators.required],
      surname: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      birth_date: ['', Validators.required]
    });
  }

  onSubmit() {
    if (this.signupForm.valid) {
      console.log('Kayıt Formu:', this.signupForm.value);
    } else {
      console.log('Form geçerli değil');
    }
  }
    goToLogin() {
    this.router.navigate(['login']);
    
  }

}
