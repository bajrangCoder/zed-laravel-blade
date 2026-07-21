# zed-laravel-blade

Laravel Blade templating language support for [Zed](https://zed.dev).

> [!Important]
> Add this in your zed setting to automatically select Blade mode for `.blade.php` files instead of php.
> ```json
> "file_types": {
>   "Blade": ["*.blade.php"]
> }
> ```

## Features

- Syntax highlighting for all Blade directives (conditionals, loops, sections, stacks, inline directives, keywords, attribute directives, Envoy, Livewire)
- Code folding for `@if`/`@foreach`/`@section`/`@switch` and all block directives
- Outline panel with section names, conditionals, loops, HTML elements
- Language injections: PHP, JavaScript, CSS, Alpine.js, Livewire attributes
- Auto-indentation for Blade blocks and HTML
- Bracket matching and tag auto-close
- Tailwind CSS IntelliSense opt-in
- Prettier support via `@shufo/prettier-plugin-blade` (currently broken — see [zed#42796](https://github.com/zed-industries/zed/issues/42796))

## Formatting

Install [blade-formatter](https://github.com/shufo/blade-formatter) globally:

```bash
npm install -g blade-formatter
```

Then add to your Zed settings:

```json
{
  "languages": {
    "Blade": {
      "formatter": {
        "external": {
          "command": "blade-formatter",
          "arguments": ["--stdin"]
        }
      },
      "format_on_save": "on"
    }
  }
}
```

Optionally, create `.bladeformatterrc.json` in your project root to configure formatting:

```json
{
  "indentSize": 2,
  "wrapLineLength": 120
}
```

> **Note:** Config keys must be **camelCase** (e.g. `indentSize`), not kebab-case. The CLI flags use `--indent-size`, but the JSON config file uses `indentSize`.

## Grammar

- [tree-sitter-blade](https://github.com/EmranMR/tree-sitter-blade)

## Language Servers

The extension provides these language servers (at least one must be enabled in Zed settings):

| Server | Description |
|---|---|
| **PHPantom** | Fast Rust-based PHP language server with native Blade preprocessing |
| **Intelephense** | PHP intelligence — autocompletion, go-to-definition, diagnostics |
| **PhpTools** | DEVSENSE PHP Tools — commercial alternative to Intelephense |
| **Phpactor** | Open-source PHP language server |
| **Emmet** | Emmet abbreviations support inside Blade files |
