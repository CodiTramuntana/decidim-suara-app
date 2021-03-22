// = require quill.min
// = require quill-html-edit-button/dist/quill.htmlEditButton.min.js
// = require_self

Quill.register("modules/htmlEditButton", htmlEditButton);

((exports) => {
 const quillFormats = ["bold", "italic", "link", "underline", "header", "list", "video", "color"];

 const createQuillEditor = (container) => {
   const toolbar = $(container).data("toolbar");
   const disabled = $(container).data("disabled");

   let quillToolbar = [
     ["bold", "italic", "underline"],
     [{ list: "ordered" }, { list: "bullet" }],
     [{ 'color': [] }],
     ["link", "clean"]
   ];

   if (toolbar === "full") {
     quillToolbar = [
       [{ header: [1, 2, 3, 4, 5, 6, false] }],
       ...quillToolbar,
       ["video"]
     ];
   } else if (toolbar === "basic") {
     quillToolbar = [
       ...quillToolbar,
       ["video"]
     ];
   }

   const $input = $(container).siblings('input[type="hidden"]');
   const quill = new Quill(container, {
     modules: {
       toolbar: quillToolbar,
       htmlEditButton: {}
     },
     formats: quillFormats,
     theme: "snow"
   });

   if (disabled) {
     quill.disable();
   }

   quill.on("text-change", () => {
     const text = quill.getText();

     // Triggers CustomEvent with the cursor position
     // It is required in input_mentions.js
     let event = new CustomEvent("quill-position", {
       detail: quill.getSelection()
     });
     container.dispatchEvent(event);

     if (text === "\n") {
       $input.val("");
     } else {
       $input.val(quill.root.innerHTML);
     }
   });

   quill.root.innerHTML = $input.val() || "";
 };

 const quillEditor = () => {
   $(".editor-container").each((idx, container) => {
     createQuillEditor(container);
   });
 };

 exports.Decidim = exports.Decidim || {};
 exports.Decidim.quillEditor = quillEditor;
 exports.Decidim.createQuillEditor = createQuillEditor;
})(window);
