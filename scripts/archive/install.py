#!/bin/python
import tomllib

# todo: read and validate config.toml
# todo: sanity check()
# todo: install()


from pathlib import Path


class DotDict(dict):
    """Dict allowing attribute access: cfg.key.subkey"""
    __getattr__ = dict.get
    __setattr__ = dict.__setitem__

    # recursively convert nested dicts
    @staticmethod
    def from_dict(data):
        if isinstance(data, dict):
            return DotDict({k: DotDict.from_dict(v) for k, v in data.items()})
        elif isinstance(data, list):
            return [DotDict.from_dict(x) for x in data]
        else:
            return data


def load_config(path="config.toml"):
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"Config file not found: {path}")

    with path.open("rb") as f:
        raw = tomllib.load(f)

    return DotDict.from_dict(raw)


with open("config.toml", "rb") as install_config:
    # installation_params = DotDict(tomllib.load(install_config))
    cfg = load_config()
    print(cfg.boot_config.mkinitcpio_conf)
