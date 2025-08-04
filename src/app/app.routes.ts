import { Routes } from '@angular/router';
import { Signup } from './signup/signup';
import { Login } from './login/login';
import { GlucoseEntry } from './glucose-entry/glucose-entry';
import { ModelEntry } from './model-entry/model-entry';


export const routes: Routes = [
  { path: 'signup', component: Signup },
  { path: 'login', component: Login },
   { path: 'glucose-entry', component: GlucoseEntry },
   {path:'model-entry',component:ModelEntry},
  { path: '', redirectTo: 'signup', pathMatch: 'full' }
];
