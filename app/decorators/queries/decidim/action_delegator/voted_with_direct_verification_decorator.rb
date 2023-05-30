# # frozen_string_literal: true

# # This decorator change the query in order to get
# # consultations responses with sap and member picker authorizations.

# Decidim::ActionDelegator::VotedWithDirectVerification.class_eval do
#   # This solves the problem of group two fields that do not exist in SAP which are
#   # membership_type and membership_weight. As the query does not exist, it returns an empty result.
#   def query
#     relation
#       .joins(:votes)
#       .joins(join_on_votes_author(decrypted_authorizations))
#       .where(direct_verification.or(no_authorization).or(sap_authorization).or(member_picker_authorization))
#   end

#   private

#   def sap_authorization
#     decrypted_authorizations[:name].eq("sap_authorization_handler")
#   end

#   def member_picker_authorization
#     decrypted_authorizations[:name].eq("members_picker_authorization_handler")
#   end
# end
