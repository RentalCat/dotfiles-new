#!/bin/sh

echo
for bg in '' $(seq 40 47); do
    for bold in '' 1; do
        for fg in '' $(seq 30 37); do
            code="${bold}${fg:+;$fg}${bg:+;$bg}"
            code="${code#;}"
            printf '\033[%sm%7sm \033[0m' "${code}" "${code}"
        done
        echo
    done
done
echo
