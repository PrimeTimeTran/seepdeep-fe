/******************************************************
 * Editor State
 ******************************************************/

const editorState = {
  language: 'python',
  tabSize: 4,
  useSoftTabs: true,
}

let editor = null
let pendingCode = null
let readySent = false

/******************************************************
 * Flutter → Ace Message Bridge
 ******************************************************/

window.addEventListener('message', (event) => {
  const data = event.data
  if (!data || !data.type) return

  switch (data.type) {
    case 'set-code':
      if (editor) {
        editor.setValue(data.value || '', -1)
      } else {
        // editor not ready yet → buffer
        pendingCode = data.value || ''
      }
      break

    case 'set-language':
      if (editor && data.language) {
        setLanguage(data.language)
      }
      break

    case 'set-indentation':
      if (editor) {
        setIndentation(data.tabSize, data.useSoftTabs)
      }
      break
    case 'reset':
      editor.setValue('', -1) // 🔥 clear editor
      break
  }
})

/******************************************************
 * Ace Editor – Initialization
 ******************************************************/

window.addEventListener('DOMContentLoaded', () => {
  editor = ace.edit('editor')

  // Theme & language
  editor.setTheme('ace/theme/monokai')
  editor.session.setMode(`ace/mode/${editorState.language}`)

  // Editor behavior
  editor.setOptions({
    tabSize: editorState.tabSize,
    useSoftTabs: editorState.useSoftTabs,
    showPrintMargin: false,
    fontSize: '14px',
    wrap: false,
  })

  // Disable Ace worker (iframe-safe)
  editor.session.setUseWorker(false)
  editor.focus() // ✅ REQUIRED

  // Apply buffered code if it arrived early
  if (pendingCode !== null) {
    editor.setValue(pendingCode, -1)
    pendingCode = null
  }

  // Notify Flutter that editor is ready
  if (!readySent) {
    // window.parent.postMessage({ type: 'ace-ready' }, '*')

    window.parent.postMessage(
      {
        type: 'ace-ready',
        problemId: window.PROBLEM_ID ?? null,
      },
      '*'
    )

    readySent = true
  }

  wireEditorEvents()
})

/******************************************************
 * Editor Configuration API
 ******************************************************/

function setLanguage(lang) {
  editorState.language = lang
  editor.session.setMode(`ace/mode/${lang}`)
}

function setIndentation(tabSize, useSoftTabs) {
  editorState.tabSize = tabSize
  editorState.useSoftTabs = useSoftTabs

  editor.setOptions({
    tabSize,
    useSoftTabs,
  })
}

/******************************************************
 * UI Wiring (HTML Controls)
 ******************************************************/

const languageSelect = document.getElementById('language')
const tabSizeSelect = document.getElementById('tabSize')
const softTabsCheckbox = document.getElementById('softTabs')

if (languageSelect) {
  languageSelect.addEventListener('change', (e) => {
    setLanguage(e.target.value)
  })
}

if (tabSizeSelect && softTabsCheckbox) {
  const updateIndentation = () => {
    setIndentation(parseInt(tabSizeSelect.value, 10), softTabsCheckbox.checked)
  }

  tabSizeSelect.addEventListener('change', updateIndentation)
  softTabsCheckbox.addEventListener('change', updateIndentation)
}

/******************************************************
 * Keyboard Shortcuts
 ******************************************************/

function wireEditorEvents() {
  editor.commands.addCommand({
    name: 'save',
    bindKey: { win: 'Ctrl-S', mac: 'Cmd-S' },
    exec(editor) {
      window.parent.postMessage(
        {
          type: 'ace-save',
          value: editor.getValue(),
          language: editorState.language,
        },
        '*'
      )
    },
  })

  // Run
  editor.commands.addCommand({
    name: 'run',
    bindKey: { win: "Ctrl-'", mac: "Cmd-'" },
    exec(editor) {
      console.log("Cmd + '")
      window.parent.postMessage(
        {
          type: 'ace-run',
          value: editor.getValue(),
          language: editorState.language,
        },
        '*'
      )
    },
  })

  // Submit
  editor.commands.addCommand({
    name: 'submit',
    bindKey: { win: 'Ctrl-Enter', mac: 'Cmd-Enter' },
    exec(editor) {
      console.log('Cmd + enter')
      window.parent.postMessage(
        {
          type: 'ace-submit',
          value: editor.getValue(),
          language: editorState.language,
        },
        '*'
      )
    },
  })

  // Change events
  editor.session.on('change', () => {
    window.parent.postMessage(
      {
        type: 'ace-change',
        value: editor.getValue(),
        problemId: window.PROBLEM_ID,
      },
      '*'
    )
  })
}

/******************************************************
 * Public API (future-proof)
 ******************************************************/

window.editorApi = {
  setLanguage,
  setIndentation,
  getValue: () => editor?.getValue() ?? '',
  setValue: (code) => {
    if (editor) editor.setValue(code, -1)
    else pendingCode = code
  },
}
