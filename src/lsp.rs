mod language_servers;

use std::fs;

use zed::CodeLabel;
use zed_extension_api::{self as zed, serde_json, LanguageServerId, Result};

use crate::language_servers::{Emmet, Intelephense, PhpTools, Phpactor};

struct BladeExtension {
    intelephense: Option<Intelephense>,
    phpactor: Option<Phpactor>,
    emmet: Option<Emmet>,
    phptools: Option<PhpTools>,
}

impl zed::Extension for BladeExtension {
    fn new() -> Self {
        Self {
            intelephense: None,
            phpactor: None,
            emmet: None,
            phptools: None,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        match language_server_id.as_ref() {
            PhpTools::LANGUAGE_SERVER_ID => {
                let phptools = self.phptools.get_or_insert_with(PhpTools::new);
                phptools.language_server_command(language_server_id, worktree)
            }
            Intelephense::LANGUAGE_SERVER_ID => {
                let intelephense = self.intelephense.get_or_insert_with(Intelephense::new);
                intelephense.language_server_command(language_server_id, worktree)
            }
            Emmet::LANGUAGE_SERVER_ID => {
                let emmet = self.emmet.get_or_insert_with(Emmet::new);
                emmet.language_server_command(language_server_id)
            }
            Phpactor::LANGUAGE_SERVER_ID => {
                let phpactor = self.phpactor.get_or_insert_with(Phpactor::new);

                let (platform, _) = zed::current_platform();

                let phpactor_path =
                    phpactor.language_server_binary_path(language_server_id, worktree)?;

                if platform == zed::Os::Windows {
                    // fix：.phar files are not executable https://github.com/zed-extensions/php/issues/23
                    let php_path = worktree
                            .which("php")
                            .ok_or("Could not find PHP in path! PHP needs to be installed for running phpactor on Windows")?;

                    let abs_phpactor_path = std::env::current_dir()
                        .map_err(|_| "Could not get current directory")?
                        .join(&phpactor_path);

                    if !fs::exists(&abs_phpactor_path).is_ok_and(|exists| exists) {
                        return Err(format!(
                            "Could not resolve phpactor path {:?}!",
                            phpactor_path
                        ));
                    };

                    Ok(zed::Command {
                        command: php_path,
                        args: vec![
                            abs_phpactor_path.to_string_lossy().into(),
                            "language-server".into(),
                        ],
                        env: Default::default(),
                    })
                } else {
                    Ok(zed::Command {
                        command: phpactor_path,
                        args: vec!["language-server".into()],
                        env: Default::default(),
                    })
                }
            }
            language_server_id => Err(format!("unknown language server: {language_server_id}")),
        }
    }

    fn language_server_workspace_configuration(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<serde_json::Value>> {
        if language_server_id.as_ref() == PhpTools::LANGUAGE_SERVER_ID {
            if let Some(phptools) = self.phptools.as_mut() {
                return phptools.language_server_workspace_configuration(worktree);
            }
        }
        if language_server_id.as_ref() == Intelephense::LANGUAGE_SERVER_ID {
            if let Some(intelephense) = self.intelephense.as_mut() {
                return intelephense.language_server_workspace_configuration(worktree);
            }
        }

        Ok(None)
    }

    fn label_for_completion(
        &self,
        language_server_id: &zed::LanguageServerId,
        completion: zed::lsp::Completion,
    ) -> Option<CodeLabel> {
        match language_server_id.as_ref() {
            Intelephense::LANGUAGE_SERVER_ID => {
                self.intelephense.as_ref()?.label_for_completion(completion)
            }
            _ => None,
        }
    }
}

zed::register_extension!(BladeExtension);
