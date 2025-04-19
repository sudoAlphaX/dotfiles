use std::fs;
use std::process::Command;

fn main() {
    let override_path = "/opt/auto-cpufreq/override.pickle";

    match fs::metadata(override_path).is_ok() {
        // If file exists (governor override set)
        true => {
            Command::new("auto-cpufreq")
                .arg("--force")
                .arg("reset")
                .status()
                .expect("Failed to reset auto-cpufreq");
        }

        // If file does not exist (no governor override set)
        false => {
            // If connected to AC power
            if Command::new("systemd-ac-power")
                .status()
                .expect("Failed to execute systemd-ac-power")
                .success()
            {
                // Set powersave mode (inverse of default)
                Command::new("auto-cpufreq")
                    .arg("--force")
                    .arg("powersave")
                    .status()
                    .expect("Failed to set powersave mode");
            } else {
                // If on battery power, set performance mode
                Command::new("auto-cpufreq")
                    .arg("--force")
                    .arg("performance")
                    .status()
                    .expect("Failed to set performance mode");
            }
        }
    }
}
