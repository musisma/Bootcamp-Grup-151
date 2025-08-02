import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DietList } from './diet-list';

describe('DietList', () => {
  let component: DietList;
  let fixture: ComponentFixture<DietList>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DietList]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DietList);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
