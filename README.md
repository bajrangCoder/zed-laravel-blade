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
- Emmet abbreviations through the official [Emmet extension](https://zed.dev/extensions/emmet)
- PHP language intelligence through the [PHP extension](https://github.com/zed-extensions/php)
- Tailwind CSS IntelliSense opt-in
- Prettier support via `@shufo/prettier-plugin-blade` (currently broken — see [zed#42796](https://github.com/zed-industries/zed/issues/42796))

## Tailwind CSS IntelliSense

Zed's built-in Tailwind CSS language server is not attached to Blade files by default. Add the following to your Zed `settings.json` to enable Tailwind class completions in Blade templates:

```json
{
  "languages": {
    "Blade": {
      "language_servers": [
        "tailwindcss-language-server",
        "..."
      ]
    }
  },
  "lsp": {
    "tailwindcss-language-server": {
      "settings": {
        "includeLanguages": {
          "blade": "html"
        }
      }
    }
  }
}
```

The `"..."` entry preserves the other language servers configured for Blade.

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

This extension does not bundle any language servers. Install version 0.5.4 or newer of the [PHP extension](https://zed.dev/extensions/php) to use PHPantom in Blade files without downloading or running duplicate PHP server adapters.

For abbreviations, install the official [Emmet extension](https://zed.dev/extensions/emmet), which supports Blade directly.
