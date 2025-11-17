# Start btw MCP Server
# This script starts the btw MCP server to expose R tools via Model Context Protocol

library(btw)

cat("🚀 Starting btw MCP Server...\n")
cat("Available tools:\n")
print(length(btw_tools()))

# Start the MCP server
cat("\n📡 Launching btw_mcp_server()...\n")
btw_mcp_server()