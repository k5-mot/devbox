import pytest

import main


def test_main_output(capsys: pytest.CaptureFixture) -> None:
    """Ensure main prints the expected message."""
    main.main()
    captured = capsys.readouterr()
    assert "Hello from api!" in captured.out
