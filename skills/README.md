# skills

本リポジトリの執筆とレビューに使うスキルを格納する。

| スキル | 用途 |
|---|---|
| [repo-review](repo-review/SKILL.md) | 文書のレビュー。一次情報の明示、事実と推測の分離、日本語文章規範への適合、公開適格性を確認する |
| [japanese-tech-writing](japanese-tech-writing/SKILL.md) | 日本語文書の文章規範。記法、段落の組み立て、主張の確からしさ、語の選択、避ける表現、見出しを定める |

## Claude Code で使う

リポジトリ直下で、スキルディレクトリへのリンクを作る。

```sh
mkdir -p .claude/skills
ln -s ../../skills/repo-review .claude/skills/repo-review
```

以降、`/repo-review` で呼び出せる。
`.claude/` は `.gitignore` の対象であり、リンクはコミットされない。

リンクを作らない場合は、[`repo-review/SKILL.md`](repo-review/SKILL.md) を直接読んで手順に従う。

---

<sub>[トップへ](../README.md)</sub>
