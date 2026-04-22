# School Management API

## Overview
A streamlined, high-performance Node.js REST API for managing school location data. The system allows users to securely add schools with geographical coordinates and retrieve a dynamically sorted list of nearby schools based on user proximity.

---

## 🔗 Live Resources
- **Base API URL:** `https://educase-school-api-6o25.onrender.com`
- **Postman Collection:** [View & Test APIs Here](https://martian-flare-726487.postman.co/workspace/Team-Workspace~e07b6bba-1c9e-4d49-8bc6-2bd6f204560a/collection/43110364-957ca8fc-36a3-4697-aded-88522707a6c8?action=share&creator=43110364)

---

## Key Features (User Point of View)
- **Add New Schools**: Register a new school by providing its name, address, and geographical coordinates (latitude and longitude). The inputted data is validated immediately to ensure data integrity before it's saved.
- **Find Nearby Schools**: By providing your current geographical location, the system calculates the exact distance between you and all registered schools, instantly returning a list perfectly sorted from the nearest school to the farthest.

## Technical Approach
- **Backend Architecture**: Built using `Express.js` for robust routing and fast request handling.
- **Database**: `MySQL` is used for persistent data storage. Connections are managed through the `mysql2` promise-based client utilizing a connection pool for optimized query performance. The database automatically initializes missing tables upon connection.
- **Cloud Infrastructure**: The live API is hosted securely on **Render** (`Node.js`), while the production MySQL database is hosted entirely on **TiDB**, ensuring a robust decoupling of the server and database services.
- **Data Validation**: The `Zod` schema validation library is integrated to strictly validate incoming request payloads, preventing bad inserts or SQL errors.
- **Geospatial Processing**: The mathematical **Haversine formula** is implemented directly in the Node.js application layer. This allows the system to compute the great-circle distance between two sets of coordinate points on a sphere (the Earth) with high accuracy without needing heavy GIS database extensions.

---

## Setup Instructions

### Prerequisites
1. **Node.js** (v14 or higher)
2. **MySQL Server** installed and running locally

### 1. Installation
Navigate to the project directory and install the necessary dependencies:
```bash
npm install
```

### 2. Database Configuration

**Option A: Standard MySQL Server**
1. Open your MySQL command line or a GUI tool (like MySQL Workbench) and run the provided `init.sql` script to create the database:
```bash
mysql -u root -p < init.sql
```

**Option B: Using MAMP / XAMPP**
1. Start the **MAMP** application and ensure the MySQL server is running.
2. Open **phpMyAdmin** (usually available via the MAMP WebStart page).
3. Click on the **Import** tab at the top.
4. Upload the `init.sql` file provided in this project and click **Go** to automatically execute the setup and prepopulate the dummy data.
2. Create or verify the `.env` file in the root of the project to match your local MySQL credentials:
```env
DB_HOST=127.0.0.1
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=school_management
DB_PORT=3306
PORT=3000
```

### 3. Run the Server
Start the development server (which uses `nodemon` for auto-restarts upon file changes):
```bash
npm run dev
```

Alternatively, run in production mode:
```bash
npm start
```
The server will boot up and establish a connection. You should see `Database connected` in the terminal logs.

---

## API Documentation

### 1. Add a School
- **Endpoint**: `/addSchool`
- **Method**: `POST`
- **Headers**: `Content-Type: application/json`
- **Payload Structure**:
```json
{
  "name": "Oakridge International",
  "address": "123 Main Street",
  "latitude": 28.5355,
  "longitude": 77.3910
}
```
- **Response**: Returns a `201 Created` status with a success message along with the newly generated internal ID.

### 2. List Schools (Sorted by Proximity)
- **Endpoint**: `/listSchools`
- **Method**: `GET`
- **Query Parameters**:
  - `latitude`: User's current latitude (e.g., `28.5300`)
  - `longitude`: User's current longitude (e.g., `77.3915`)
- **Example Request**:
  `GET https://educase-school-api-6o25.onrender.com/listSchools?latitude=28.5300&longitude=77.3915`
- **Response**: Returns a `200 OK` status with an array of school objects. Each object is augmented with a runtime `distance` metric (in kilometers) and the array is sorted meticulously in an ascending order (closest schools appear first).

---

## Testing via Postman
A complete, pre-configured Postman Collection is included directly in the project directory (`schools_postman_collection.json`). 

This collection is permanently wired to the **live cloud deployment** (`educase-school-api-6o25.onrender.com`), meaning stakeholders can test the API instantly without running the server locally!

**How to test:**
1. Open Postman.
2. Click **Import** in the top left corner.
3. Select the `schools_postman_collection.json` file from this repository.
4. Open the imported folder to find the `Add School` and `List Schools` requests.
5. Click **Send** on either request to instantly test the live cloud database.
6. *Bonus:* The collection includes embedded **Example Responses** demonstrating the successful DB outputs. Click the examples dropdown inside Postman to view the exact JSON structures!
