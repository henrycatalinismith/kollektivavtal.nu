import "rails_admin/src/rails_admin/base";
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';

console.log("⭐️ kollektivavtal.nu admin")

document.addEventListener("DOMContentLoaded", () => {
  const editorContainer = document.querySelector(".editorjs-container");
  const encodedValue = editorContainer.getAttribute('data-editorjs-value');
  const decodedValue = atob(encodedValue); 
  const editorData = JSON.parse(JSON.parse(decodedValue));

  if (editorContainer) {
    const editorInstance = new EditorJS({
      holder: editorContainer.id,
      tools: {
        header: {
          class: Header,
          inlineToolbar: true,
        },
        list: {
          class: List,
          inlineToolbar: true,
        },
      },
      data: editorData,
      onChange: async () => {
        const savedData = await editorInstance.save();
        const hiddenInput = document.querySelector(`input[name="${editorContainer.dataset.target}"]`);
        if (hiddenInput) {
          hiddenInput.value = JSON.stringify(savedData);
        }
      },
    });
  }
});