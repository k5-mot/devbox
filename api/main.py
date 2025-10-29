from mypack.sample import get_version


def main() -> None:
    """."""
    print("Hello from api!")  # noqa: T201
    version = get_version()
    print(f"Package version: {version}")  # noqa: T201


if __name__ == "__main__":
    main()
