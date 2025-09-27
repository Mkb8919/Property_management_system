const Agent = require("../models/agent.models.js");

// Get all agents
exports.getAllAgents = async (req, res) => {
  try {
    const agents = await Agent.find().populate("assignedProperties");
    res.json(agents);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Get an agent by ID
exports.getAgentById = async (req, res) => {
  try {
    const agent = await Agent.findById(req.params.id).populate("assignedProperties");
    if (!agent) return res.status(404).json({ message: "Agent not found" });
    res.json(agent);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Create a new agent
exports.createAgent = async (req, res) => {
  try {
    const newAgent = new Agent(req.body);
    const savedAgent = await newAgent.save();
    res.status(201).json(savedAgent);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

// Update an agent
exports.updateAgent = async (req, res) => {
  try {
    const updatedAgent = await Agent.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!updatedAgent) return res.status(404).json({ message: "Agent not found" });
    res.json(updatedAgent);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

// Delete an agent
exports.deleteAgent = async (req, res) => {
  try {
    const deletedAgent = await Agent.findByIdAndDelete(req.params.id);
    if (!deletedAgent) return res.status(404).json({ message: "Agent not found" });
    res.json({ message: "Agent deleted successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
