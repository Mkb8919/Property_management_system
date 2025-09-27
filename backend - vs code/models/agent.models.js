const mongoose = require("mongoose");

const agentSchema = new mongoose.Schema({
  name: { type: String, required: true },
  contact: { type: String, required: true },
  assignedProperties: [{ type: mongoose.Schema.Types.ObjectId, ref: "Property" }]
}, { timestamps: true });

module.exports = mongoose.model("Agent", agentSchema);
