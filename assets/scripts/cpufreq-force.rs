use std::fs;
use std::process::Command;

fn main() {
    let override_path = "/opt/auto-cpufreq/override.pickle";

    if !fs::metadata(override_path).is_ok() {
        let status = Command::new("systemd-ac-power")
            .status()
            .expect("Failed to execute systemd-ac-power");

        if status.success() {
            Command::new("auto-cpufreq")
                .arg("--force")
                .arg("powersave")
                .status()
                .expect("Failed to set powersave mode");
        } else {
            Command::new("auto-cpufreq")
                .arg("--force")
                .arg("performance")
                .status()
                .expect("Failed to set performance mode");
        }
    } else {
        Command::new("auto-cpufreq")
            .arg("--force")
            .arg("reset")
            .status()
            .expect("Failed to reset auto-cpufreq");
    }
}
