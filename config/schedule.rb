# frozen_string_literal: true

env :PATH, ENV["PATH"]

every 1.day, at: "5:00 am" do
  rake "decidim:metrics:all"
end

every 1.day, at: "1:00 am" do
  rake "sap:update_metadata"
end

every :sunday, at: "4:00 am" do
  rake "decidim:delete_data_portability_files"
end
