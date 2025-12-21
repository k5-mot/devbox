import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def sample() -> None:
    """Sample function."""
    logger.info("This is a sample function.")
