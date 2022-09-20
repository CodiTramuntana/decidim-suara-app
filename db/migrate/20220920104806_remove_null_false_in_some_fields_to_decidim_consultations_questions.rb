# frozen_string_literal: true

class RemoveNullFalseInSomeFieldsToDecidimConsultationsQuestions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :decidim_consultations_questions, :subtitle, true
    change_column_null :decidim_consultations_questions, :what_is_decided, true
    change_column_null :decidim_consultations_questions, :promoter_group, true
    change_column_null :decidim_consultations_questions, :participatory_scope, true
  end
end
