---
title: "{{ .TranslationBaseName | upper }}"
linktitle: "{{ .TranslationBaseName | upper }}"
author: "Kristoffel Boghaert"
date: {{ dateFormat "2006-01-02" .Date }}
weight: 0
images:
- image1.jpg
- image2.jpg

menu:
  main:
    name: "{{ .TranslationBaseName | upper }}"
    parent: "small"
---
