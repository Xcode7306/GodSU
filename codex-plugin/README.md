# GodSU · 酥神简历 Codex Plugin

两个配套的 Codex Skill：**把经历写强**，再**把简历排好看**。方法论逆向自一份爆火的校招简历（多模态算法工程师方向）——手法、句式、视觉规格都是逐段拆解出来的。

| Skill | 管什么 | 输出 |
|---|---|---|
| [`resume-crafting`](skills/resume-crafting/) | 文案。挖料 → 按 11 个手法 / 13 个句式改写 → 自查 | 高信号的简历正文 |
| [`resume-typeset`](skills/resume-typeset/) | 排版。填模板 → 无头 Chrome 渲染 → 压成一页 | 一页 A4 PDF |

典型用法是串起来跑：先 `resume-crafting` 把内容写扎实，再 `resume-typeset` 出 PDF。

## 在 Codex 中使用

这个仓库已按 Codex Plugin 格式打包，包含 `.codex-plugin/plugin.json` 和 `skills/` 目录。安装后，在新对话中直接描述需求，或使用 `@` 选择对应 Skill：

```text
帮我优化简历
把这份简历排成 PDF
```

典型流程是先选择 `@resume-crafting`，文案定稿后再选择 `@resume-typeset`。

## resume-crafting

核心原则：**只放大，不虚构**——写上去的每一条都要能在面试里守住 15 分钟追问，守不住的包装是负资产。

- `SKILL.md` — 四步工作流：挖料 → 改写 → 排序 → 自查
- `references/exemplar.md` — 11 个手法（做什么），附简历片段示例
- `references/phrasebook.md` — 13 个句式模板（具体怎么写），每条给出 片段 → 抽象模板 → 适用条件与风险

## resume-typeset

只管视觉，不碰文案。Georgia 衬线与中文黑体混排、亮蓝分节标题细线、藏蓝强调段、灰带公司行——参数是从原版 PDF 逐 span 逆向的，**不要改 CSS**。

- `assets/template.html` — 组件清单写在模板注释里
- `scripts/render.sh` — 无头 Chrome 转 PDF，会报告页数

依赖：macOS + Google Chrome；验收步骤需要 `pip3 install pymupdf`。Codex 需要能够访问本机终端，且 Chrome 路径可执行。

## 关于示例

`references/` 里引用的简历片段已匿名化——姓名、账号、学校、公司、平台等专有名词一律替换为占位符（`github.com/xxxx`、"某大厂"、"X 大学"）。**句式结构和用词节奏保持原样**，占位符只是标出该往哪个位置填你自己的东西。
