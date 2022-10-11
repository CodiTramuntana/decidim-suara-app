// This file is compiled inside Decidim core pack. Code can be added here and will be executed
// as part of that pack

// Load images
require.context("../../images", true)

// Existing javascripts should be moved to app/packs/src and imported with import 
// into decidim_application.js.
// If that JS file is replacing a Decidim file, there’s no need to add it to decidim_application.js

import './target_links';
import './admin/blank_vote';
import './consultations/blank_vote';
