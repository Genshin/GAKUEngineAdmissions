module Gaku
  module Admin
    class AdmissionMethods::AdmissionPhases::AdmissionPhaseStatesController < GakuController

      respond_to :js, :html

      def make_default
        @state = AdmissionPhaseState.find(params[:id])
        @phase = AdmissionPhase.find(params[:admission_phase_id])
        @phase.admission_phase_states.each {|state|
          state.is_default = false
          state.save
        }
        @state.is_default = true
        @state.save
      end

      def edit
        @state = AdmissionPhaseState.find(params[:id])
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
        @admission_phase = AdmissionPhase.find(params[:admission_phase_id])
      end

      def update
        @state = AdmissionPhaseState.find(params[:id])
        if @state.update(admission_method_params)
          respond_to do |format|
            format.js { render 'update' }
          end
        end
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:admission_phase_state).permit(admission_phase_state_attr)]
      end

      private

      def admission_method_params
        params.require(:admission_phase_state).permit(admission_phase_state_attr)
      end

      def admission_phase_state_attr
        [  :name, :can_progress, :can_admit, 
           :auto_progress, :auto_admit, 
           :is_default, :admission_phase_id]
      end
        
    end
  end
end
