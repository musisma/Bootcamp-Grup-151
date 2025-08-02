import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GlucoseEntry } from './glucose-entry';

describe('GlucoseEntry', () => {
  let component: GlucoseEntry;
  let fixture: ComponentFixture<GlucoseEntry>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GlucoseEntry]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GlucoseEntry);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
