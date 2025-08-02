import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelEntry } from './model-entry';

describe('ModelEntry', () => {
  let component: ModelEntry;
  let fixture: ComponentFixture<ModelEntry>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModelEntry]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModelEntry);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
