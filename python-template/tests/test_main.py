import logging

import pytest

from sample_pack import main


def test_main_output(caplog: pytest.LogCaptureFixture) -> None:
    """Ensure main prints the expected message."""
    with caplog.at_level(logging.INFO):
        main.main()
    assert "Hello from api!" in caplog.text
