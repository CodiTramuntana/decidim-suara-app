# frozen_string_literal: true

module Decidim
  module Consultations
    # Computes the participation into a Conslutation after this Consultation is closed.
    class Participation < Struct.new(:consultation)
      # Returns a list of participants as an Array of Arrays.
      # Thus, each user is represented by an Array of the following form:
      # [
      #   author.name,
      #   author.email,
      #   did_vote?,
      #   delegated_vote?,
      #   vote.created_at.rfc3339
      # ]
      #
      def results
        raise "Can not compute results on a Consultation that is not closed." unless consultation.finished?

        org_users= Decidim::User.where(organization: consultation.organization).order(:name)

        org_users.filter_map do |user|
          user_votes = user_votes_on_current_consultation(user)
          last_vote = user_votes.order(:created_at).last

          next unless last_vote

          [
            user.name,
            user.email,
            last_vote.present?,
            delegated_vote?(last_vote, user),
            last_vote&.created_at&.rfc3339
          ]
        end
      end

      def user_votes_on_current_consultation(user)
        Decidim::Consultations::Vote.joins(:question).where(author: user.id, "decidim_consultations_questions.decidim_consultation_id": consultation.id)
      end

      def any_responded_question_from_user?(user)
        Decidim::Consultations::Question.joins(:votes).where(consultation: consultation).exists?("decidim_consultations_votes.decidim_author_id" => user.id)
      end

      def delegated_vote?(vote, user)
        vote.versions.exists?(event: :create)
      end
    end
  end
end
