"""
Original Author: imsamuka

When an episode is not found, it executes 'ani-cli' to find and
watch it via streaming automatically!
"""

import shutil
from subprocess import run, DEVNULL


# Executed when trying to watch an episode that doesn't exist in your library
def episode_missing(engine, show, episode):
    anicli = shutil.which("ani-cli")  # find 'ani-cli' executable
    if anicli:
        query = show["title"].strip()
        args = [
            anicli,
            "--no-detach",
            "--exit-after-play",
            "-q",
            "best",
            "-e",
            str(episode),
            query,
        ]
        if not shutil.which("rofi"):
            # If rofi is not installed,
            # add '-S 1' to select the first show automatically
            args[1:1] = ["-S", "1"]

        if shutil.which("ani-skip"):
            # Use 'ani-skip' if available
            args[1:1] = ["--skip"]

        cmd = " ".join(args[:-1]) + f" '{query}'"
        engine.msg.info("episode_missing", cmd)  # Show the command used
        output = run(args, stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL)
        if output.returncode != 0:
            engine.msg.info("episode_missing", "ani-cli failed")
            run(
                [
                    "notify-send",
                    "-a",
                    "ani-cli",
                    f'Unable to play Episode {episode} of anime: "{query}"',
                ]
            )
    else:
        engine.msg.info("episode_missing", "ani-cli was not found")


# You can run this file directly to test it
if __name__ == "__main__":

    class MockEngine:
        class Messenger:
            info = print

        msg = Messenger()

    episode_missing(MockEngine(), {"title": "One Piece"}, 1)
