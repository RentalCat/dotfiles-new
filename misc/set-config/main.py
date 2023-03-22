#!/usr/bin/env python
import os
import re

REPOSITORY_ROOT: str = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
LINK_FILE_PATH: str = os.path.join(REPOSITORY_ROOT, "ln.txt")


if __name__ == "__main__":
    with open(LINK_FILE_PATH) as f:
        for line in f:
            # リンクファイルから ln の引数を取得
            _src, _dst = tuple(r.strip() for r in line.split("\t"))
            # source_file path (リンクファイル内でカレントディレクトリ表記 `./` は削除する)
            src_path: str = os.path.join(REPOSITORY_ROOT, re.sub(r"^\./", "", _src))
            # target_file path (リンクファイル内でホームディレクトリ表記 `~/` は削除する)
            dst_path: str = os.path.join(os.environ["HOME"], re.sub(r"^\~/", "", _dst))

            # 配置先パスにファイルが配置されている場合
            if os.path.exists(dst_path):
                # 末尾に `.{YYYY_MM_DD}_old` を付けてリネーム
                #os.rename(dst_path, f"{dst_path}.{(datetime.datetime.now().strftime('%Y_%m_%d')_old")
                # ファイル削除
                print(f"'{dst_path}' is exists. delete file (or directory)...")
                if os.path.isdir(dst_path):
                    os.rmdir(dst_path)
                else:
                    os.remove(dst_path)

            print(f"execute: ln -s {src_path} {dst_path}")
            os.symlink(src_path, dst_path)
            print("done.\n")
