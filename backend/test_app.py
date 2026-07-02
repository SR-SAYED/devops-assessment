import json
from app import app


def test_home_endpoint():
    """
    Test the root endpoint (/)
    """
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200
    assert response.data.decode("utf-8") == "Application is running"


def test_health_endpoint():
    """
    Test the health endpoint (/health)
    """
    client = app.test_client()

    response = client.get("/health")

    data = json.loads(response.data)

    assert response.status_code == 200
    assert data["status"] == "ok"