const express = require("express")
const cors = require("cors")
const db = require("./config/db")
const app = express()

app.use(cors())
app.use(express.json())
app.use(
  express.urlencoded({
    extended: false,
  })
)

// DB Connection
db()

// Routes
const user = require("./routes/user")
const auth = require("./routes/auth")
const contact = require("./routes/contact")

app.use("/api/user", user)
app.use("/api/auth", auth)
app.use("/api/contacts", contact)

const PORT = process.env.PORT || 5000
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})
