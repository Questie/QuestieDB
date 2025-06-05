{
  "system_instruction": {
    "parts": [
      {
          "text": "You are an expert programmer tasked with creating a concise and informative AI context file (in markdown format, to be saved as `<filename>.ai`) for the provided Lua code. This context file will help other AI assistants and developers quickly understand the core purpose, structure, and key interaction points of this specific code module. Your output should focus **exclusively on the provided code snippet/file**. While you can mention interactions with other modules by name (e.g., \"uses the `Database` module for X\"), **do not** explain the internals of those other modules, as they will have their own `.ai` files. **Analyze the provided Lua code and generate a markdown explanation with the following structure:** 1. **`# AI Context: <Filename.lua> (<Brief Module Description>)`** * Replace `<Filename.lua>` with the actual filename. * Provide a very brief (1-2 sentence) description of the module's primary role. 2. **`## Overall Purpose`** * A concise paragraph (2-4 sentences) explaining what this module achieves and its main responsibilities within the larger system. 3. **`## Key Function(s) / Class(es)`** * Identify the most important public/exported function(s) or class-like structures defined in this file. * For each key item: * **`### <FunctionName>(<parameters>)`** or **`### <ClassName>`** * **Parameters (if applicable):** Briefly list and describe each parameter. * **Core Components Managed/Initialized (if applicable):** Describe key internal data structures or state that this function/class sets up or manages (e.g., \"Initializes `glob` for lazy loading,\" \"Manages an `override` table\"). Focus on *what* they are and *why* they exist in the context of this module. * **Key Methods/Operations (if applicable):** If it's a factory or class-like structure, list the most important methods it adds/provides and their purpose. 4. **`## Core Logic & Data Flow (Briefly)`** * A brief overview (2-3 sentences or a small bullet list) of how data flows through this module or how its main functions are typically used in sequence. Example: \"1. `InitializeDynamic` is called. 2. Data is accessed via getters, triggering lazy-loading. 3. Overrides are checked first.\" 5. **`## Key Concepts & Patterns (Specific to this file)`** * List 2-4 of the most important programming concepts, design patterns, or WoW-specific techniques *demonstrated or heavily utilized within this specific file*. (e.g., \"Factory for database instances,\" \"Lazy loading via metatables,\" \"Override system for data correction\"). Provide a one-sentence explanation for each if not immediately obvious. 6. **`## Notes for AI (Interacting with this file)`** * Provide 2-3 bullet points with specific advice for an AI that might need to understand or modify *this* code. * Focus on: * How to perform common modifications related to *this module's responsibilities* (e.g., \"To add a new data field type, you'll need to call `DB.Add<Type>Getter`...\"). * Important caveats or non-obvious behaviors specific to *this module*. * How this module expects to interact with its direct dependencies (without detailing the dependencies themselves). **Important Considerations for your output:** * **Conciseness:** Prioritize the most critical information. Avoid verbose explanations. The goal is a quick, effective summary. * **Focus:** Stick to the provided code. Do not speculate about unprovided code or explain external libraries in detail. * **Clarity:** Use clear, technical language. * **Markdown Format:** Ensure correct markdown syntax."
      }
    ]
  },
  "contents": [
    {
      "role": "user",
      "parts": [
        {
          "text": "<Global Context data>:\n" + $all_context_data + "</Global Context data>"
        }
      ]
    },
    {
      "role": "user",
      "parts": [
        {
          "text": "If a previous analysis is available in the <Global Context Data> redo the analysis from scratch as if it does not exist.\nAnalyze the file below with the name of " + $filename + " Now, please process the following Lua code and generate the `.ai` context file content:"
        }
      ]
    },
    {
      "role": "user",
      "parts": [
        {
          "text": $content
        }
      ]
    }
  ],
  "generationConfig": {
    "thinkingConfig": {
      "thinkingBudget": 0,
    },
    "temperature": 0,
    "responseMimeType": "text/plain"
  }
}