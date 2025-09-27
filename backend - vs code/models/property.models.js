const mongoose = require("mongoose");

const propertySchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  address: { type: String, required: true },
  price: { type: Number, required: true },
  propertyType: { type: String, enum: ["apartment", "villa", "plot"], required: true },
  status: { type: String, enum: ["available", "sold"], default: "available" },
  images: [{ type: String }] // multiple images per property
}, { timestamps: true });

module.exports = mongoose.model("Property", propertySchema);
