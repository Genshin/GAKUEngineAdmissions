module Gaku
  class AdmissionPhaseRecord < ActiveRecord::Base

    include Notes, Trashable

    belongs_to :admission
    belongs_to :admission_phase
    belongs_to :admission_phase_state
    has_many :exam_scores

    default_scope where(is_deleted: false)
    scope :deleted, where(is_deleted: true)

    validates :admission_phase_state_id, uniqueness: {scope: :admission_id}

    def exam_score
      total_score = 0
      student_graded = false
      unless admission_phase.exam.nil?
        admission_phase.exam.exam_portions.each do |exam_portion|
          portion_score = Gaku::ExamPortionScore.find_by_exam_portion_id_and_student_id(exam_portion.id,  admission.student_id)
          unless portion_score.nil?
            student_graded = true
            total_score += portion_score.score.to_i
          end
        end
      end
      if student_graded
        total_score
      else
        nil
      end
    end

  end
end
