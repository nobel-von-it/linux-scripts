use std::{
    env,
    fmt::{self},
    fs,
    io::Write,
    path::Path,
    process::{Command, Stdio},
};

use toml::{Table, Value, map::Map};

type Result<T> = std::result::Result<T, Box<dyn std::error::Error>>;

const DEFAULT_PATH: &str = "./setup.toml";
const USAGE: &str = r#"
USAGE: setup [OPTIONS]
    --path <path> to provide conf file
"#;

fn is_enable(fields: &Map<String, Value>) -> bool {
    if let Some(Value::Boolean(enable)) = fields.get("enable") {
        return *enable;
    }
    false
}
fn is_true(value: &Value) -> bool {
    if let Value::Boolean(bl) = value {
        return *bl;
    }
    false
}

#[derive(Debug, Clone)]
enum Script {
    SSHGit { name: String, email: String },
    Rustup { analyzer: bool },
    // ...
}

impl Script {
    fn name(&self) -> String {
        String::from(match self {
            Script::Rustup { .. } => "rustup",
            Script::SSHGit { .. } => "sshgit",
        })
    }
    fn parse<S: AsRef<str>>(name: S, value: &Value) -> Option<Self> {
        if let Value::Table(fields) = value {
            return match name.as_ref() {
                "sshgit" => Script::parse_sshgit(fields),
                "rustup" => Script::parse_rustup(fields),
                _ => None,
            };
        }
        None
    }
    fn parse_sshgit(fields: &Map<String, Value>) -> Option<Self> {
        if !is_enable(fields) {
            return None;
        }
        let name = if let Some(Value::String(name)) = fields.get("name") {
            name.to_string()
        } else {
            return None;
        };
        let email = if let Some(Value::String(email)) = fields.get("email") {
            email.to_string()
        } else {
            return None;
        };
        Some(Script::SSHGit { name, email })
    }
    fn parse_rustup(fields: &Map<String, Value>) -> Option<Self> {
        if !is_enable(fields) {
            return None;
        }
        let analyzer = if let Some(Value::Boolean(analyzer)) = fields.get("analyzer") {
            *analyzer
        } else {
            return None;
        };
        Some(Script::Rustup { analyzer })
    }
    fn run(&self) -> Result<()> {
        Ok(())
    }
}

#[derive(Debug, Clone)]
enum Service {
    Zapret,
}

#[derive(Debug, Default)]
struct Conf {
    packages: Vec<String>,
    scripts: Vec<Script>,
    services: Vec<Service>,
    githubs: Vec<String>,
}

impl Conf {
    fn parse(content: Map<String, Value>) -> Self {
        let mut conf = Conf::default();

        for (k, v) in content {
            match k.as_str() {
                "packages" => {
                    if let Value::Table(pkgs) = v {
                        conf.packages = pkgs
                            .iter()
                            .filter_map(|(pk, pv)| {
                                if is_true(pv) {
                                    return Some(pk.to_string());
                                }
                                None
                            })
                            .collect::<Vec<_>>();
                    }
                }
                "scripts" => {
                    if let Value::Table(scrs) = v {
                        conf.scripts = scrs
                            .iter()
                            .filter_map(|(sp, sv)| Script::parse(sp, sv))
                            .collect::<Vec<_>>();
                    }
                }
                _ => {}
            }
        }

        conf
    }
}

impl fmt::Display for Conf {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        writeln!(f, "CONFIGURATION")?;
        writeln!(
            f,
            "{} to install ({})",
            self.packages.len(),
            self.packages.as_slice().join(", ")
        )?;
        writeln!(
            f,
            "{} to activate ({})",
            self.scripts.len(),
            self.scripts
                .iter()
                .map(|s| s.name())
                .collect::<Vec<_>>()
                .join(", ")
        )?;
        Ok(())
    }
}

fn pacman_install(packages: &[String]) -> Result<()> {
    let mut command = Command::new("pacman");
    command.arg("-Suy");
    for pkg in packages {
        command.arg(pkg);
    }
    command.stdin(Stdio::piped()).stdout(Stdio::piped());

    let mut child = command.spawn()?;

    if let Some(mut stdin) = child.stdin.take() {
        stdin.write_all(b"y")?;
    }
    child.wait()?;
    println!("PACKAGES INSTALLED");
    Ok(())
}

fn main() -> Result<()> {
    let default_path = DEFAULT_PATH.to_string();
    let args = env::args().skip(1).collect::<Vec<_>>();
    let path = Path::new(args.first().unwrap_or(&default_path));
    let toml_content = fs::read_to_string(path)?.parse::<Table>()?;

    let conf = Conf::parse(toml_content);
    if !conf.packages.is_empty() {
        pacman_install(&conf.packages)?;
    }

    println!("{conf}");
    Ok(())
}
