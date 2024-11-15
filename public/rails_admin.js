console.log("⭐️ kollektivavtal.nu admin")

function initEditorJS(editorSelector) {
  const editorContainer = document.querySelector(editorSelector);

  if (editorContainer) {
    const editorInstance = new EditorJS({
      holder: editorContainer.id,
      tools: {
        // Add more tools if needed
      },
      data: JSON.parse(editorContainer.dataset.editorjsValue || "{}"),
      onChange: async () => {
        const savedData = await editorInstance.save();
        const hiddenInput = document.querySelector(`input[name="${editorContainer.dataset.target}"]`);
        if (hiddenInput) {
          hiddenInput.value = JSON.stringify(savedData);
        }
      },
    });
  }
}

document.addEventListener("DOMContentLoaded", () => {
  initEditorJS(".editorjs-container");
});