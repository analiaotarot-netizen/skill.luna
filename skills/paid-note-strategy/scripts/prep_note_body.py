# -*- coding: utf-8 -*-
"""
note.comへの貼り付け用に、記事Markdownを2つの成果物に変換する。

1. note_body_clean.txt : Markdown記法（#, ##, ###, **）を取り除いたプレーンテキスト本文。
   note.comのエディタへそのまま貼り付ける用。
2. note_headings_list.txt : 見出しのレベルとテキストをタブ区切りで記録したリスト。
   "H2\t見出しテキスト" または "H3\t見出しテキスト" の形式。
   貼り付け後に一つずつ見出し装飾を当てていく作業で使う。

入力ファイルの1行目はタイトル、2行目は空行という前提（記事.mdの標準フォーマット）。
本文はそれ以降。
"""

import argparse
import os


def prep_note_body(md_path: str, out_dir: str) -> tuple[str, str, int, int]:
    with open(md_path, encoding="utf-8") as f:
        lines = f.read().split("\n")

    # 1行目はタイトル、2行目は空行の前提で読み飛ばす
    lines = lines[2:]

    out = []
    headings = []  # (index_in_out, level, text)
    for line in lines:
        if line.startswith("## "):
            text = line[3:].strip()
            out.append(text)
            headings.append((len(out) - 1, "H2", text))
        elif line.startswith("### "):
            text = line[4:].strip()
            out.append(text)
            headings.append((len(out) - 1, "H3", text))
        else:
            text = line.replace("**", "").replace("*", "")
            out.append(text)

    clean_body = "\n".join(out)

    os.makedirs(out_dir, exist_ok=True)
    body_path = os.path.join(out_dir, "note_body_clean.txt")
    headings_path = os.path.join(out_dir, "note_headings_list.txt")

    with open(body_path, "w", encoding="utf-8") as f:
        f.write(clean_body)

    with open(headings_path, "w", encoding="utf-8") as f:
        for _, level, text in headings:
            f.write(f"{level}\t{text}\n")

    return body_path, headings_path, len(headings), len(clean_body)


def main():
    parser = argparse.ArgumentParser(
        description="note記事Markdownを、貼り付け用プレーンテキストと見出しリストに変換する"
    )
    parser.add_argument("md_path", help="対象記事の.mdファイルパス")
    parser.add_argument(
        "--out-dir",
        default=None,
        help="出力先ディレクトリ（省略時は記事と同じフォルダ）",
    )
    args = parser.parse_args()

    out_dir = args.out_dir or os.path.dirname(os.path.abspath(args.md_path))

    body_path, headings_path, heading_count, char_count = prep_note_body(
        args.md_path, out_dir
    )

    print(f"clean body : {body_path} ({char_count} 文字)")
    print(f"headings   : {headings_path} ({heading_count} 件)")


if __name__ == "__main__":
    main()
