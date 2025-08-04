import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule  } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class Login {
  loginForm: FormGroup;

  constructor(private fb: FormBuilder,private router: Router,private http:HttpClient) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required]
    });
  }

 onLogin() {
  if (this.loginForm.valid) {
    const loginData = this.loginForm.value;

    this.http.post<any>('http://localhost:9090/users/login', loginData)
      .subscribe({
        next: (response) => {
          console.log('Giriş başarılı:', response);

        
          if (response.diabetesType == 1) {
            this.router.navigate(['/glucose-entry']);
          } else {
            this.router.navigate(['/model-entry']);
          }
        },
        error: (err) => {
          console.error('Giriş sırasında hata oluştu:', err);
        }
      });

  } else {
    console.log('Form geçerli değil');
    this.loginForm.markAllAsTouched();
  }
}
  goToGlucoseEntry() {
  this.router.navigate(['/glucose-entry']);

}
}