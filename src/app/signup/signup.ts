import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators,ReactiveFormsModule  } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signup',
  imports: [CommonModule,ReactiveFormsModule],
  templateUrl: './signup.html',
  styleUrls: ['./signup.css']
})
export class Signup {
    signupForm: FormGroup;
    private apiUrl = 'http://localhost:9090/users/signup'
    constructor(private fb: FormBuilder,private router: Router,private http:HttpClient) {
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
      this.http.post(this.apiUrl, this.signupForm.value).subscribe({
        next: (response) => {
          console.log('Kayıt başarılı:', response);
          this.router.navigate(['login']); // Başarılı kayıt sonrası login sayfasına yönlendir
        },
        error: (error) => {
          console.error('Kayıt sırasında hata oluştu:', error);
          // İstersen kullanıcıya hata mesajı gösterebilirsin
        }
      });
    } else {
      console.log('Form geçerli değil');
    }
  }

    goToLogin() {
    this.router.navigate(['login']);
    
  }

}
