async function checkBackendHealth() {

    const status = document.getElementById("status");

    status.className = "loading";
    status.innerHTML = "Checking backend...";

    try {

        const response = await fetch("/health");

        if (!response.ok) {
            throw new Error("Backend returned an error");
        }

        const data = await response.json();

        if (data.status === "ok") {

            status.className = "success";
            status.innerHTML = "🟢 Backend Status: Healthy";

        } else {

            status.className = "error";
            status.innerHTML = "Unexpected backend response";

        }

    } catch (error) {

        status.className = "error";
        status.innerHTML = "🔴 Backend is unreachable";

    }

}


window.onload = checkBackendHealth;