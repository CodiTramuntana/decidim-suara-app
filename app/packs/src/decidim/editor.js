/* eslint-disable require-jsdoc */

import lineBreakButtonHandler from "src/decidim/editor/linebreak_module"
import "src/decidim/vendor/image-resize.min"
import "src/decidim/vendor/image-upload.min"
// SUARA CUSTOMIZATION
import htmlEditButton from "quill-html-edit-button";
// SUARA CUSTOMIZATION

const quillFormats = ["bold", "italic", "link", "underline", "header", "list", "video", "image", "alt", "break", "width", "style", "code", "blockquote", "indent",
  // SUARA CUSTOMIZATION  
  "color"];
  // SUARA CUSTOMIZATION

export default function createQuillEditor(container) {
  const toolbar = $(container).data("toolbar");
  const disabled = $(container).data("disabled");

  let quillToolbar = [
    ["bold", "italic", "underline", "linebreak"],
    [{ list: "ordered" }, { list: "bullet" }],
    ["link", "clean"],
    ["code", "blockquote"],
    [{ "indent": "-1"}, { "indent": "+1" }],
    // SUARA CUSTOMIZATION
    [{ 'color': [] }],
    // SUARA CUSTOMIZATION
  ];

  let addImage = $(container).data("editorImages");

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

  if (addImage) {
    quillToolbar.push(["image"]);
  }

  let modules = {
    linebreak: {},
    toolbar: {
      container: quillToolbar,
      handlers: {
        "linebreak": lineBreakButtonHandler
      }
    },
    // SUARA CUSTOMIZATION
    htmlEditButton: {}
    // SUARA CUSTOMIZATION
  };
  const $input = $(container).siblings('input[type="hidden"]');
  container.innerHTML = $input.val() || "";
  const token = $('meta[name="csrf-token"]').attr("content");
  if (addImage) {
    modules.imageResize = {
      modules: ["Resize", "DisplaySize"]
    }
    modules.imageUpload = {
      url: $(container).data("uploadImagesPath"),
      method: "POST",
      name: "image",
      withCredentials: false,
      headers: { "X-CSRF-Token": token },
      callbackOK: (serverResponse, next) => {
        $("div.ql-toolbar").last().removeClass("editor-loading")
        next(serverResponse.url);
      },
      callbackKO: (serverError) => {
        $("div.ql-toolbar").last().removeClass("editor-loading")
        console.log(`Image upload error: ${serverError.message}`);
      },
      checkBeforeSend: (file, next) => {
        $("div.ql-toolbar").last().addClass("editor-loading")
        next(file);
      }
    }
  }

  // SUARA CUSTOMIZATION
  Quill.register("modules/htmlEditButton", htmlEditButton);
  // SUARA CUSTOMIZATION

  const quill = new Quill(container, {
    modules: modules,
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

    if (text === "\n" || text === "\n\n") {
      $input.val("");
    } else {
      $input.val(quill.root.innerHTML);
    }
  });
  // After editor is ready, linebreak_module deletes two extraneous new lines
  quill.emitter.emit("editor-ready");

  if (addImage) {
    const text = $(container).data("dragAndDropHelpText");
    $(container).after(`<p class="help-text" style="margin-top:-1.5rem;">${text}</p>`);
  }

  // After editor is ready, linebreak_module deletes two extraneous new lines
  quill.emitter.emit("editor-ready");

  return quill;
}
