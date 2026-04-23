import express from "express";
import cors from "cors";

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors({
  origin: ["http://localhost:3001", "http://localhost:3000"],
}));
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ message: "TODO: API endpoints under construction" });
});

// Global error handler — never leak stack traces
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: "Internal server error" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Honor API running on port ${PORT}`);
});
