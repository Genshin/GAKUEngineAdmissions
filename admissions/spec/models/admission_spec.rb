require 'spec_helper'

describe Gaku::Admission do

  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }

  context 'validations' do
    it { should belong_to :student }
    it { should belong_to :scholarship_status }
    it { should belong_to :admission_method }
    it { should belong_to :admission_period}

    it { should have_many :specialty_applications }
    it { should have_many :admission_phase_records }
    it { should have_many(:exam_scores).through(:admission_phase_records) }
    it { should have_many :attachments }
    it { should have_many :notes }

    it { should have_one :external_school_record }

    it { should accept_nested_attributes_for :student }
    it { should accept_nested_attributes_for(:admission_phase_records).allow_destroy(true) }
  end

  context 'methods' do

    context 'changes student' do

      before do
        @student = create(:student, enrollment_status_code: 'admitted')
        @admission = create(:admission, student_id: @student.id)
      end

      it 'to applicant' do
        @admission.change_student_to_applicant
        expect(@admission.student.enrollment_status_code).to eq('applicant')
      end

    end

    context 'changes applicant' do

      before do
        @student = create(:student, enrollment_status_code: 'applicant')
        @admission = create(:admission, student_id: @student.id)
      end

      it 'changes applicant to student' do
        @admission.change_applicant_to_student(Date.today)
        expect(@admission.student.enrollment_status_code).to eq('admitted')
        expect(@admission.student.admitted).not_to be_nil
      end

    end

  end
end
