#!/usr/bin/env python3
import sys
import json


def get_quadrant_tag(imp, exi):
    if imp == "High" and exi == "High":
        return "FOUNDATION"
    if imp == "High" and exi == "Low":
        return "ESSENTIAL"
    if imp == "Low" and exi == "High":
        return "NOISE"
    return "SHALLOWS"


def hook():
    lines = sys.stdin.readlines()
    if not lines:
        return

    task = json.loads(lines[-1])

    quadrant_tags = {"FOUNDATION", "ESSENTIAL", "NOISE", "SHALLOWS"}

    imp = task.get("importance", "Low")
    exi = task.get("exigency", "Low")
    new_tag = get_quadrant_tag(imp, exi)

    tags = task.get("tags", [])
    tags = [t for t in tags if t not in quadrant_tags]
    tags.append(new_tag)

    task["tags"] = tags

    print(json.dumps(task))


if __name__ == "__main__":
    hook()
