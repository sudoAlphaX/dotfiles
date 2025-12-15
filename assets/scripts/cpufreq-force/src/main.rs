use std::env;
use std::fs;
use std::process::Command;

fn main() {
    // Collect command line arguments
    let args: Vec<String> = env::args().collect();

    // Check for --reset flag
    if args.contains(&"--reset".to_string()) {
        Command::new("/usr/bin/auto-cpufreq")
            .arg("--force")
            .arg("reset")
            .status()
            .expect("Failed to set reset mode");
        return;
    }

    // Check for --powersave flag
    if args.contains(&"--powersave".to_string()) {
        Command::new("/usr/bin/auto-cpufreq")
            .arg("--force")
            .arg("powersave")
            .status()
            .expect("Failed to set powersave mode");
        return;
    }

    // Check for --performance flag
    if args.contains(&"--performance".to_string()) {
        Command::new("/usr/bin/auto-cpufreq")
            .arg("--force")
            .arg("performance")
            .status()
            .expect("Failed to set performance mode");
        return;
    }

    // --- Original Logic (Default Behaviour) ---
    let override_path = "/opt/auto-cpufreq/override.pickle";

    match fs::metadata(override_path).is_ok() {
        // If file exists (governor override set)
        true => {
            Command::new("/usr/bin/auto-cpufreq")
                .arg("--force")
                .arg("reset")
                .status()
                .expect("Failed to reset auto-cpufreq");
        }

        // If file does not exist (no governor override set)
        false => {
            // If connected to AC power
            if Command::new("/usr/bin/systemd-ac-power")
                .status()
                .expect("Failed to execute systemd-ac-power")
                .success()
            {
                // Set powersave mode (inverse of default)
                Command::new("/usr/bin/auto-cpufreq")
                    .arg("--force")
                    .arg("powersave")
                    .status()
                    .expect("Failed to set powersave mode");
            } else {
                // If on battery power, set performance mode
                Command::new("/usr/bin/auto-cpufreq")
                    .arg("--force")
                    .arg("performance")
                    .status()
                    .expect("Failed to set performance mode");
            }
        }
    }
}
