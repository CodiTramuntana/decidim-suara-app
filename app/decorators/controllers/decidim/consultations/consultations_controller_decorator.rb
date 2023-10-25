# frozen_string_literal: true

# This decorator change the behavior of the consultations
# to check permissions if you are not an admin user.
Decidim::Consultations::ConsultationsController.class_eval do
  include SuaraPermissionsSupervisor

  alias_method :original_show, :show

  before_action :questions_left_to_response, only: :show

  def show
    original_show
    render status: :forbidden unless admin_or_with_suara_permissions?(current_user, current_participatory_space)
  end

  private

  alias_method :original_consultations, :consultations

  def consultations
    if current_user&.admin?
      original_consultations
    else
      @consultations = filter_by_suara_permissions(reorder(search.result))
      @consultations = Decidim::Consultation.where(id: @consultations.map(&:id))
      @consultations = paginate(@consultations)
    end
  end

  def questions_left_to_response
    questions = current_consultation.questions.pluck(:id)
    response_questions = Decidim::Consultations::Vote.where(decidim_consultation_question_id: current_consultation.questions.pluck(:id),
                                                            decidim_author_id: current_user).pluck(:decidim_consultation_question_id)

    @questions_left_to_response = (questions - response_questions).count
  end

  def current_participatory_space
    current_consultation unless action_name == "index"
  end
end
