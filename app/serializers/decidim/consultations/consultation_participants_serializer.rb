# frozen_string_literal: true

module Decidim
  module Consultations
    class ConsultationParticipantsSerializer < Decidim::Exporters::Serializer
      include Decidim::TranslationsHelper

      def serialize
        {
          author_name: resource[0],
          author_email: resource[1],
          did_vote: resource[2],
          delegated_vote: resource[3],
          vote_created_at: resource[4]
        }
      end
    end
  end
end
