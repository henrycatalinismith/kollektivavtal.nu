import "rails_admin/src/rails_admin/base";
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
import Checklist from '@editorjs/checklist';
import Link from '@editorjs/link';
import Quote from '@editorjs/quote';
import Code from '@editorjs/code';
import Hyperlink from 'editorjs-hyperlink';

console.log("⭐️ kollektivavtal.nu admin")

document.addEventListener("DOMContentLoaded", () => {
  const editorContainers = document.querySelectorAll(".editorjs-container");
  editorContainers.forEach((editorContainer) => {
    const encodedValue = editorContainer.getAttribute('data-editorjs-value');
    const decodedValue = atob(encodedValue); 
    let editorData = {};
    try {
      editorData = JSON.parse(JSON.parse(decodedValue));
    } catch (error) {
      console.error('Error parsing editor data', error);
    }

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
          checklist: {
            class: Checklist,
            inlineToolbar: true,
          },
          link: {
            class: Link,
            inlineToolbar: true,
          },
          quote: {
            class: Quote,
            inlineToolbar: true,
          },
          code: {
            class: Code,
            inlineToolbar: true,
          },
          hyperlink: {
            class: Hyperlink,
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
  })
});