#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <linux/input.h>

// clang-format off
const struct input_event
syn       = {.type = EV_SYN , .code = SYN_REPORT   , .value = 0},
esc_up    = {.type = EV_KEY , .code = KEY_ESC      , .value = 0},
ctrl_up   = {.type = EV_KEY , .code = KEY_LEFTCTRL , .value = 0},
esc_down  = {.type = EV_KEY , .code = KEY_ESC      , .value = 1},
ctrl_down = {.type = EV_KEY , .code = KEY_LEFTCTRL , .value = 1};
// clang-format on

void print_usage(FILE *stream, const char *program) {
    // clang-format off
    fprintf(stream,
            "pageupdown - Swap PageUp and PageDown keys\n"
            "\n"
            "usage: %s [-h]\n",
            program);
    // clang-format on
}

int read_event(struct input_event *event) {
    return fread(event, sizeof(struct input_event), 1, stdin) == 1;
}

void write_event(const struct input_event *event) {
    if (fwrite(event, sizeof(struct input_event), 1, stdout) != 1)
        exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
    for (int opt; (opt = getopt(argc, argv, "h")) != -1;) {
        switch (opt) {
            case 'h':
                print_usage(stdout, argv[0]);
                return EXIT_SUCCESS;
            default: /* '?' */
                print_usage(stderr, argv[0]);
                return EXIT_FAILURE;
        }
    }

    if (optind < argc) {
        fprintf(stderr, "Unexpected argument: %s\n", argv[optind]);
        print_usage(stderr, argv[0]);
        return EXIT_FAILURE;
    }

    struct input_event input;

    setbuf(stdin, NULL);
    setbuf(stdout, NULL);

    while (read_event(&input)) {
        if (input.type == EV_MSC && input.code == MSC_SCAN)
            continue;

        if (input.type != EV_KEY && input.type != EV_REL &&
            input.type != EV_ABS) {
            write_event(&input);
            continue;
        }

        if (input.type == EV_KEY) {
            if (input.code == KEY_PAGEUP) {
                input.code = KEY_PAGEDOWN;
            } else if (input.code == KEY_PAGEDOWN) {
                input.code = KEY_PAGEUP;
            }
        }
        write_event(&input);
    }

    return EXIT_SUCCESS;
}
