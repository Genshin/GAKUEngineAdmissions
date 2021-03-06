FactoryGirl.define do
  factory :admission_phase, class: Gaku::AdmissionPhase do
    name 'Admission Phase 1'
    position 1
  end

  factory :admission_phase_exam, class: Gaku::AdmissionPhase do
    name 'Exam'
    position 1
    after(:create) do |phase_exam|
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_pre_exam, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_passed, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_rejected, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_abscent, admission_phase: phase_exam)
      phase_exam.exam = FactoryGirl.create(:exam)
      phase_exam.save!
    end
  end

  factory :admission_phase_interview, class: Gaku::AdmissionPhase do
    name 'Interview'
    position 2
    after(:create) do |phase_interview|
      phase_interview.admission_phase_states << FactoryGirl.create(:admission_phase_state_waiting, admission_phase: phase_interview)
      phase_interview.admission_phase_states << FactoryGirl.create(:admission_phase_state_accepted, admission_phase: phase_interview)
      phase_interview.admission_phase_states << FactoryGirl.create(:admission_phase_state_rejected, admission_phase: phase_interview)
      phase_interview.save!
    end
  end

  factory :admission_phase_lang_exam, class: Gaku::AdmissionPhase do
    name 'Foreign Language Exam'
    position 3
    after(:create) do |phase_exam|
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_pre_exam, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_passed, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_passed_fluent, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_rejected, admission_phase: phase_exam)
      phase_exam.admission_phase_states << FactoryGirl.create(:admission_phase_state_abscent, admission_phase: phase_exam)
      phase_exam.save!
    end
  end

end
