const baseUrl = "http://localhost:8080/api";
let loggedInUser = null;
let editingTicketId = null;

// Trains with prices
const trains = {
    "Shatabdi Express": 1200,
    "Rajdhani Express": 1500,
    "Duronto Express": 1000,
    "Local Passenger": 200
};

const stations = ["Delhi", "Mumbai", "Chennai", "Kolkata", "Bangalore", "Hyderabad"];

// Section toggle
function showRegister() {
    document.getElementById("register-section").classList.add("active");
    document.getElementById("login-section").classList.remove("active");
    document.getElementById("dashboard-section").classList.remove("active");
}

function showLogin() {
    document.getElementById("login-section").classList.add("active");
    document.getElementById("register-section").classList.remove("active");
    document.getElementById("dashboard-section").classList.remove("active");
}

function showDashboard() {
    document.getElementById("dashboard-section").classList.add("active");
    document.getElementById("login-section").classList.remove("active");
    document.getElementById("register-section").classList.remove("active");

    populateDropdowns();
    loadTickets();
}

// Populate dropdowns
function populateDropdowns() {
    const trainSelect = document.getElementById("train-name");
    const sourceSelect = document.getElementById("source");
    const destinationSelect = document.getElementById("destination");

    trainSelect.innerHTML = "";
    sourceSelect.innerHTML = "";
    destinationSelect.innerHTML = "";

    // Trains
    Object.keys(trains).forEach(t => {
        const option = document.createElement("option");
        option.value = t;
        option.text = t;
        trainSelect.appendChild(option);
    });

    // Stations
    stations.forEach(s => {
        const opt1 = document.createElement("option");
        opt1.value = s;
        opt1.text = s;
        sourceSelect.appendChild(opt1);

        const opt2 = document.createElement("option");
        opt2.value = s;
        opt2.text = s;
        destinationSelect.appendChild(opt2);
    });

    // Auto price set
    trainSelect.addEventListener("change", updatePrice);
    updatePrice();
}

function updatePrice() {
    const train = document.getElementById("train-name").value;
    document.getElementById("ticket-price").value = trains[train] || 0;
}

// Register
async function register() {
    const user = {
        username: document.getElementById("reg-username").value,
        email: document.getElementById("reg-email").value,
        password: document.getElementById("reg-password").value
    };

    const res = await fetch(`${baseUrl}/auth/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(user)
    });

    if (res.ok) {
        alert("Registration successful! Please login.");
        showLogin();
    } else {
        const error = await res.text();
        alert("Registration failed: " + error);
    }
}

// Login
async function login() {
    const user = {
        username: document.getElementById("login-username").value,
        password: document.getElementById("login-password").value
    };

    const res = await fetch(`${baseUrl}/auth/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(user)
    });

    if (res.ok) {
        loggedInUser = user.username;
        showDashboard();
    } else {
        const error = await res.text();
        alert("Login failed: " + error);
    }
}

// Add or Update Ticket
async function addTicket() {
    if (!loggedInUser) return;

    const train = document.getElementById("train-name").value;
    const source = document.getElementById("source").value;
    const dest = document.getElementById("destination").value;
    const price = parseFloat(document.getElementById("ticket-price").value);

    if (source === dest) {
        alert("Source and destination cannot be the same!");
        return;
    }

    const ticket = { username: loggedInUser, trainName: train, source, destination: dest, price };

    let url = `${baseUrl}/tickets`;
    let method = "POST";
    if (editingTicketId) {
        url = `${baseUrl}/tickets/${editingTicketId}`;
        method = "PUT";
    }

    const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(ticket)
    });

    if (res.ok) {
        alert(editingTicketId ? "Ticket updated!" : "Ticket booked!");
        editingTicketId = null;
        loadTickets();
    } else {
        alert("Failed to save ticket!");
    }
}

// Load Tickets
async function loadTickets() {
    if (!loggedInUser) return;

    const res = await fetch(`${baseUrl}/tickets/user/${loggedInUser}`);
    const tickets = await res.json();

    const list = document.getElementById("ticket-list");
    list.innerHTML = "";

    tickets.forEach(t => {
        const li = document.createElement("li");
        li.innerHTML = `
      <div><b>${t.trainName}</b> (${t.source} → ${t.destination}) - ₹${t.price}</div>
      <div class="button-group">
        <button onclick="editTicket('${t.id}','${t.trainName}','${t.source}','${t.destination}','${t.price}')">✏️</button>
        <button onclick="deleteTicket('${t.id}')">❌</button>
      </div>`;
        list.appendChild(li);
    });
}

// Edit Ticket
function editTicket(id, train, source, dest, price) {
    document.getElementById("train-name").value = train;
    document.getElementById("source").value = source;
    document.getElementById("destination").value = dest;
    document.getElementById("ticket-price").value = price;
    editingTicketId = id;
}

// Delete Ticket
async function deleteTicket(id) {
    await fetch(`${baseUrl}/tickets/${id}`, { method: "DELETE" });
    loadTickets();
}

// Logout
function logout() {
    loggedInUser = null;
    editingTicketId = null;
    showLogin();
}
