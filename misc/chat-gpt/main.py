#!/usr/bin/env python
import click
import itertools
import os
import openai

from typing import TYPE_CHECKING, cast

if TYPE_CHECKING:
    from openai.openai_object import OpenAIObject

openai.api_key = os.environ.get("OPENAI_SECRET_KEY", "")


def _to_message(prompt: str) -> dict[str, str]:
    return {"role": "user", "content": prompt}


def _chat(messages: list[dict[str, str]]) -> list[dict[str, str]]:
    completions = cast(
            "OpenAIObject",
            openai.ChatCompletion.create(
            model="gpt-4",
            messages=messages,
            max_tokens=1024,
            n=1,
            stop=None,
            temperature=0.5,
        )
    )
    return messages + [completions.choices[0].message]


def _completion(prompt: str) -> str:
    completions = cast(
            "OpenAIObject",
            openai.Completion.create(
            model="text-davinci-003",
            prompt=prompt,
            max_tokens=1024,
            n=1,
            stop=None,
            temperature=0.5,
        )
    )
    return next(iter(completions.choices)).text.strip()


def _exec_interactive(count: int = 1, messages: list[dict[str, str]] = []) -> bool:
    click.echo()
    prompt: str = click.prompt(click.style(f"Input  [{count}]", bold=True, fg="green"), type=str)
    if prompt == "exit":
        return False

    new_messages: list[dict[str, str]] = _chat(messages + [_to_message(prompt)])
    text: str = new_messages[-1]["content"]
    click.echo("".join(
            [
                click.style(f"ChatGPT[{count}]", bold=True, fg="red"),
                ": ",
                click.style(text, fg="yellow"),
            ]
        )
    )
    return _exec_interactive(count + 1, new_messages)


@click.command()
@click.argument("prompt", type=str, default="")
def cli(prompt: str) -> None:
    # 引数がある場合はすぐにChatGPTへ問い合わせ
    if prompt:
        return click.echo(_completion(prompt))

    # 引数がなければインタラクティブモードへ
    click.echo("ChatGPT Interactive Mode -- To exit, type 'exit'.")
    _exec_interactive()


if __name__ == "__main__":
    cli()
