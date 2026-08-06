---
name: coconala-blog-full-draft
description: End-to-end Coconala blog workflow that researches a live product page, writes a fact-checked Japanese blog article, generates a Relife Art-style thumbnail plus two body images in the user's editable ChatGPT image chat, normalizes images under 700 KB, uploads everything to Coconala, saves only as an unpublished draft, and verifies the reopened draft. Use when the user asks to combine Coconala blog writing, thumbnail/article image generation, Relife Art thumbnail styling, and live Coconala draft upload.
---

# Coconala Blog Full Draft

## Core rule

Use this skill for the whole job from product research to proven unpublished Coconala draft. Do not stop at prepared text, image prompts, a save click, or ChatGPT's description of images. Report completion only after the exact draft is reopened and verified.

## Required reference

Read `references/full-workflow.md` completely before writing, generating images, operating ChatGPT, or touching Coconala.

Use `scripts/normalize_blog_images.py` after downloading each generated image unless the file already satisfies the requested dimensions and byte ceiling.

## Workflow

1. Collect or confirm the target Coconala account, product URL, adopted title, fixed first line, article memo, exclusions, image style, and any recurring-character reference.
2. Open the live product page and use only currently visible facts. Never invent reviews, qualifications, results, sales counts, scarcity, guarantees, deadlines, or conditions.
3. Write the article in Japanese using the adopted title exactly, three two-line headings, two body image placeholders, a natural CTA, and the product URL on the final line.
4. Create one new article-specific ChatGPT chat. Send the Relife Art-style thumbnail request, body image A request, and body image B request as three separate messages. Do not use Codex ImageGen.
5. Visually inspect the actual generated images, download them, and retry only failed images with the exact failure reason.
6. Normalize each final image to the requested canvas, or default to `1280 x 670`, and keep each file at or below `700 KB`.
7. Verify the signed-in Coconala account before entering content. Stop before saving if the account is not the requested account.
8. Insert the thumbnail as the cover and replace the two body placeholders using Coconala's native image tool.
9. Apply native bold and center alignment to all six heading lines.
10. Save as draft only. Never click publish, publication confirmation, or any public-release action.
11. Reopen or reload the exact draft edit URL and verify account, title, draft state, timestamp, cover image, two body images, removed placeholders, body content, and persisted heading formatting.

## Image rules

- One image per ChatGPT message.
- One independent image per output.
- No collage, grid, contact sheet, split screen, mockup, comparison table, or multiple-card preview.
- Thumbnail may contain only the adopted title when text is requested.
- Thumbnail should use the Relife Art generator/workflow style when no other thumbnail style is specified. Keep the final Coconala canvas, normally `1280 x 670`, instead of Instagram carousel size.
- Body images must contain no readable text, numbers, URL, logo, watermark, or frame.
- Do not reuse unrelated past images or attached images unless the user explicitly provides a recurring-character reference.
- Treat a ChatGPT completion message as incomplete until the pixels are visible and inspected.

## Coconala safety

- Save only as an unpublished draft.
- Do not publish.
- Do not claim draft completion until the exact edit page has been reopened.
- If native bold or center alignment does not persist after reload, repair it and verify again.
- If the browser, ChatGPT, or Coconala blocks progress, keep the prepared text and prompts and report the exact unsaved step.

## Completion evidence

Return:

- article title;
- product URL;
- character count;
- three image statuses with dimensions and file sizes;
- ChatGPT image chat URL;
- Coconala draft edit URL;
- saved timestamp;
- verified Coconala account;
- explicit confirmation that the article remains unpublished.
