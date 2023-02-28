---
title: Upstream Differences Dashboard 🤖
---

This issue show differences in github action workflows between this repository
and upstream repository `onedr0p/containers`.

## Differences in files

{% for item in env.JSON_DIFFERENCES %}

<details><summary>{{ item.filename }}</summary>

```patch
{{ item.diff }}
```

</details>

{% else %}

No changes between repositories.

{% endfor %}
